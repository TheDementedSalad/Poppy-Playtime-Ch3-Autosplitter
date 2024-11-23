// Poppy Playtime Ch3 Autosplitter and Load Remover
// Supports Load Remover IGT
// Splits for campaigns can be obtained from 
// Script by TheDementedSalad


state("Playtime_Chapter3-Win64-Shipping", "SteamRelease"){}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.Settings.CreateFromXml("Components/PPCH3.Settings.xml");
	
	vars.LvlStorage = new List<string>()
	{"/TheDome/MP_Dome_Main", "/GasProductionZone/MP_GasProductionZone_Main", "/DreamOne/MP_DreamOne_Main", "/HomeSweetHome/MP_HomeSweetHome_Main", "/School/MP_School_Main",
	 "/Bridge/MP_Bridge_Main", "/Playhouse/MP_Playhouse_Main", "/CounselorsOffice/MP_CounselorOffice_Main", "/FinalEncounter/MP_FinalEncounter_Main"};
}

init
{
	vars.completedSplits = new List<byte>();
	
	switch (modules.First().ModuleMemorySize)
	{
		case (122298368):
			version = "SteamRelease";
			break;
		case (122306560):
			version = "Update1";
			break;
		case (122347520):
			version = "Update3";
			break;
	}

	IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 3B C? 48 0F 44 C? 48 89 05 ???????? E8");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 89 05 ???????? 48 85 c9 74 ?? e8 ???????? 48 8d 4d");
	IntPtr fNames = vars.Helper.ScanRel(3, "48 8d 0d ?? ?? ?? ?? e8 ?? ?? ?? ?? c6 05 ?? ?? ?? ?? ?? 0f 10 07");
	IntPtr gSyncLoad = vars.Helper.ScanRel(21, "33 C0 0F 57 C0 F2 0F 11 05");
	
	if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}
	
	vars.Helper["isLoading"] = vars.Helper.Make<bool>(gSyncLoad);
	
	vars.Helper["CheckpointID"] = vars.Helper.Make<byte>(gEngine, 0x9A0, 0x78, 0x158, 0x380);
	
	vars.Helper["spawnType"] = vars.Helper.Make<byte>(gEngine, 0x1058, 0x1C1);
	
	vars.Helper["Level"] = vars.Helper.MakeString(gEngine, 0xAE0, 0x14);
	
	vars.Helper["localPlayer"] = vars.Helper.Make<ulong>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x18);
	vars.Helper["localPlayer"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
	
	//gEngine.GameInstance.LocalPlayers[0].PlayerController.Character.CapsuleMovement.RelativeLocationYXZ
	//vars.Helper["X"] = vars.Helper.Make<double>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x2E0, 0x328, 0x128);
	//vars.Helper["Y"] = vars.Helper.Make<double>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x2E0, 0x328, 0x138);
	//vars.Helper["Z"] = vars.Helper.Make<double>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x2E0, 0x328, 0x130);
	
	//gEngine.GameInstance.LocalPlayers[0].PlayerController.AcknowledgedPawn.bPlayerAlive[1]
	vars.Helper["isAlive"] = vars.Helper.Make<bool>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x338, 0x9A8);
	
	//gEngine.GameInstance.LocalPlayers[0].PlayerController.MyHUD.Base_UI_Widget.Menus_Layer.DisplayedWidget.FName
	vars.Helper["CurrentWidget"] = vars.Helper.Make<ulong>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x340, 0x388, 0x2B8, 0x180, 0x18);
	vars.Helper["CurrentWidget"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
	
	vars.Helper["isMoving"] = vars.Helper.Make<ushort>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x338, 0x85E);
	
	vars.Helper["FinalCutMaxFrame"] = vars.Helper.Make<ulong>(gEngine, 0x9A0, 0x78, 0x30, 0xA8, 0xA8, 0x2C0, 0x294);
	vars.Helper["FinalCutCurrFrame"] = vars.Helper.Make<ulong>(gEngine, 0x9A0, 0x78, 0x30, 0xA8, 0xA8, 0x2C0, 0x3D0);
	
	
	if(version == "SteamRelease"){
		vars.Helper["CanMove"] = vars.Helper.Make<byte>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x2E0, 0x618);
	}
	else{
		vars.Helper["CanMove"] = vars.Helper.Make<byte>(gEngine, 0x1058, 0x38, 0x0, 0x30, 0x2E0, 0x619);
	}
	
	vars.FNameToString = (Func<ulong, string>)(fName =>
	{
		var nameIdx  = (fName & 0x000000000000FFFF) >> 0x00;
		var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
		var number   = (fName & 0xFFFFFFFF00000000) >> 0x20;

		IntPtr chunk = vars.Helper.Read<IntPtr>(fNames + 0x10 + (int)chunkIdx * 0x8);
		IntPtr entry = chunk + (int)nameIdx * sizeof(short);

		int length = vars.Helper.Read<short>(entry) >> 6;
		string name = vars.Helper.ReadString(length, ReadStringType.UTF8, entry + sizeof(short));

		return number == 0 ? name : name + "_" + number;
	});
	
	vars.FNameToShortString = (Func<ulong, string>)(fName =>
	{
		string name = vars.FNameToString(fName);

		int dot = name.LastIndexOf('.');
		int slash = name.LastIndexOf('/');

		return name.Substring(Math.Max(dot, slash) + 1);
	});
	
	vars.FNameToShortString2 = (Func<ulong, string>)(fName =>
	{
		string name = vars.FNameToString(fName);

		int under = name.LastIndexOf('_');

		return name.Substring(0, under + 1);
	});
}

update
{
	//Uncomment debug information in the event of an update.
	//print(modules.First().ModuleMemorySize.ToString());
	
	vars.Helper.Update();
	vars.Helper.MapPointers();
	
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplits.Clear();
	}

	//print(current.CanMove.ToString());
	
	//print(vars.FNameToShortString2(current.Character));
}

start
{
	return current.isMoving == 1 && old.isMoving == 0 && current.Level == "/IntroTunnels/MP_IntroTunnels_Main";
}

split
{
	if (current.CheckpointID != old.CheckpointID && settings["" + current.CheckpointID] && !vars.completedSplits.Contains(current.CheckpointID)){
		vars.completedSplits.Add(current.CheckpointID);
        return true;
    }
	
	if(settings["Map"]){
		if(vars.LvlStorage.Contains(current.Level) && current.Level != old.Level && current.Level != "/Menus/Level_MainMenu"){
			return true;
		}
	}
	
	if(current.FinalCutMaxFrame == 916 && current.FinalCutCurrFrame >= 740){
		return true;
	}
}

isLoading
{
	return vars.FNameToShortString2(current.CurrentWidget) == "BPW_PauseMenu_C_" || vars.FNameToShortString2(current.localPlayer) != "PlaytimePlayerController_" || 
			current.Level == "/Menus/Level_MainMenu" || current.CheckpointID == 0 || current.CanMove == 4 && current.isAlive || current.isLoading;
}

reset

{
	return current.Level != "/Menus/Level_MainMenu" && old.Level == "/Menus/Level_MainMenu" && current.spawnType == 3;
}
