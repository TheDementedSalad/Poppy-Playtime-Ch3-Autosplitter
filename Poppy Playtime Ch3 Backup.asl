// Poppy Playtime Ch3 Autosplitter and Load Remover
// Supports Load Remover IGT
// Splits for campaigns can be obtained from 
// Script by TheDementedSalad


state("Playtime_Chapter3-Win64-Shipping", "SteamRelease")
{
	byte CheckpointID	:	0x6DD1BA8, 0x158, 0x380; // 1 when you start, 2 when you reach the 2nd piston puzzle, 3 when you reach the platform stairs, 4 when you reach tram
	byte spawnType		:	0x6DD1BA8, 0x1B8, 0x1C1;
	
	string100 Level		:	0x6DCDDA0, 0xAE0, 0x14; // /Game/Maps/Menus/Level_MainMenu in main menu 
	
	byte isPaused		:	0x6DCDDA0, 0xADA;
    byte isFroze		: 	0x6970FF8; // 0 when not loading (game not frozen)
	byte Inventory		:	0x6D1F364; // 1 in inventory, 0 not in inventory.
	
	float X				:	0x6DB30B0, 0x30, 0x2D0, 0x328, 0x264;
	float Y				:	0x6DB30B0, 0x30, 0x2D0, 0x328, 0x274;
	float Z				:	0x6DB30B0, 0x30, 0x2D0, 0x328, 0x26C;
	
	float loadIntro		:	0x6DD1BA8, 0x30, 0x98, 0x60, 0x290, 0x1B0, 0x288, 0xE8; //UI_LoadingPlay_C during black screen after load
	float loadDome		:	0x6DD1BA8, 0x30, 0x98, 0x1B8, 0x290, 0x1B0, 0x288, 0xE8;
	float loadGas		:	0x6DD1BA8, 0x30, 0x98, 0x100, 0x290, 0x1B0, 0x288, 0xE8;
	float loadDream1	:	0x6DD1BA8, 0x30, 0x98, 0xD8, 0x290, 0x1B0, 0x288, 0xE8;
	float loadHome		:	0x6DD1BA8, 0x30, 0x98, 0x78, 0x290, 0x1B0, 0x288, 0xE8;
	float loadSchool	:	0x6DD1BA8, 0x30, 0x98, 0x90, 0x290, 0x1B0, 0x288, 0xE8; 
	float loadBridge	:	0x6DD1BA8, 0x30, 0x98, 0xC8, 0x290, 0x1B0, 0x288, 0xE8;
	float loadPlay		:	0x6DD1BA8, 0x30, 0x98, 0x30, 0x290, 0x1B0, 0x288, 0xE8;
	float loadCounsel	:	0x6DD1BA8, 0x30, 0x98, 0x220, 0x290, 0x1B0, 0x288, 0xE8;
	float loadDream2	:	0x6DD1BA8, 0x30, 0x98, 0x28, 0x290, 0x1B0, 0x288, 0xE8;
	float loadFinal		:	0x6DD1BA8, 0x30, 0x98, 0x20, 0x290, 0x1B0, 0x288, 0xE8;
	
	byte IntroPlaying	:	0x697E420, 0x58, 0x9B0, 0x50, 0x2F0, 0x8, 0x28, 0x280; //LevelSequencePlayer 
	uint IntroFrames	:	0x697E420, 0x58, 0x9B0, 0x50, 0x2F0, 0x8, 0x28, 0x294;
	uint EndingCurF		:	0x697E420, 0x58, 0x9B0, 0x80, 0x2F0, 0x8, 0x28, 0x364;
	uint EndingFrames	:	0x697E420, 0x58, 0x9B0, 0x80, 0x2F0, 0x8, 0x28, 0x294;

}

state("Playtime_Chapter3-Win64-Shipping", "Update1")
{
	byte CheckpointID	:	0x6DD2CA8, 0x158, 0x380; // 1 when you start, 2 when you reach the 2nd piston puzzle, 3 when you reach the platform stairs, 4 when you reach tram
	byte spawnType		:	0x6DD2CA8, 0x1B8, 0x1C1;
	
	string100 Level		:	0x6DCEEA0, 0xAE0, 0x14; // /Game/Maps/Menus/Level_MainMenu in main menu 
	
	byte isPaused		:	0x6DCEEA0, 0xADA;
    byte isFroze		: 	0x6972078; // 0 when not loading (game not frozen)
	byte Inventory		:	0x6D20464; // 1 in inventory, 0 not in inventory.
	
	float X				:	0x6DB41B0, 0x30, 0x2D0, 0x328, 0x264;
	float Y				:	0x6DB41B0, 0x30, 0x2D0, 0x328, 0x274;
	float Z				:	0x6DB41B0, 0x30, 0x2D0, 0x328, 0x26C;
	
	float loadIntro		:	0x6DD2CA8, 0x30, 0x98, 0x60, 0x290, 0x1B0, 0x288, 0xE8; //UI_LoadingPlay_C during black screen after load
	float loadDome		:	0x6DD2CA8, 0x30, 0x98, 0x1B8, 0x290, 0x1B0, 0x288, 0xE8;
	float loadGas		:	0x6DD2CA8, 0x30, 0x98, 0x100, 0x290, 0x1B0, 0x288, 0xE8;
	float loadDream1	:	0x6DD2CA8, 0x30, 0x98, 0xD8, 0x290, 0x1B0, 0x288, 0xE8;
	float loadHome		:	0x6DD2CA8, 0x30, 0x98, 0x78, 0x290, 0x1B0, 0x288, 0xE8;
	float loadSchool	:	0x6DD2CA8, 0x30, 0x98, 0x90, 0x290, 0x1B0, 0x288, 0xE8; 
	float loadBridge	:	0x6DD2CA8, 0x30, 0x98, 0xC8, 0x290, 0x1B0, 0x288, 0xE8;
	float loadPlay		:	0x6DD2CA8, 0x30, 0x98, 0x30, 0x290, 0x1B0, 0x288, 0xE8;
	float loadCounsel	:	0x6DD2CA8, 0x30, 0x98, 0x220, 0x290, 0x1B0, 0x288, 0xE8;
	float loadDream2	:	0x6DD2CA8, 0x30, 0x98, 0x28, 0x290, 0x1B0, 0x288, 0xE8;
	float loadFinal		:	0x6DD2CA8, 0x30, 0x98, 0x20, 0x290, 0x1B0, 0x288, 0xE8;
	
	byte IntroPlaying	:	0x697F4A0, 0x58, 0x9B0, 0x50, 0x2F0, 0x8, 0x28, 0x280; //LevelSequencePlayer 
	uint IntroFrames	:	0x697F4A0, 0x58, 0x9B0, 0x50, 0x2F0, 0x8, 0x28, 0x294;
	uint EndingCurF		:	0x697F4A0, 0x58, 0x9B0, 0x80, 0x2F0, 0x8, 0x28, 0x364;
	uint EndingFrames	:	0x697F4A0, 0x58, 0x9B0, 0x80, 0x2F0, 0x8, 0x28, 0x294;

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
	}
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.Settings.CreateFromXml("Components/PPCH3.Settings.xml");
	
	vars.LvlStorage = new List<string>()
	{"/TheDome/MP_Dome_Main", "/GasProductionZone/MP_GasProductionZone_Main", "/DreamOne/MP_DreamOne_Main", "/HomeSweetHome/MP_HomeSweetHome_Main", "/School/MP_School_Main",
	 "/Bridge/MP_Bridge_Main", "/Playhouse/MP_Playhouse_Main", "/CounselorsOffice/MP_CounselorOffice_Main", "/FinalEncounter/MP_FinalEncounter_Main"};
}

update
{
	//Uncomment debug information in the event of an update.
	//print(modules.First().ModuleMemorySize.ToString());
	
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplits.Clear();
	}

}

start
{
	return (current.X != old.X || current.Y != old.Y || current.Z != old.Z) && current.IntroPlaying == 0 && current.IntroFrames == 882 && current.Level == "/IntroTunnels/MP_IntroTunnels_Main";
}

split
{
	if(settings["Check"]){
		if(settings["" + current.CheckpointID] && !vars.completedSplits.Contains(current.CheckpointID)){
			vars.completedSplits.Add(current.CheckpointID);
			return true;
		}
	}
	
	if(settings["Map"]){
		if(vars.LvlStorage.Contains(current.Level) && current.Level != old.Level){
			vars.completedSplits.Add(current.CheckpointID);
			return true;
		}
	}
	
	if(current.EndingFrames == 916 && current.EndingCurF >= 740){
		return true;
	}
}

isLoading
{
	return current.isPaused == 1 && current.Inventory != 1 || current.isFroze != 0 || current.Level == "/Menus/Level_MainMenu" || 
			current.loadIntro == 1 && current.Level == "/IntroTunnels/MP_IntroTunnels_Main" ||
			current.loadDome == 1 && current.Level == "/TheDome/MP_Dome_Main" ||
			current.loadGas == 1 && current.Level == "/GasProductionZone/MP_GasProductionZone_Main" ||
			current.loadDream1 == 1 && current.Level == "/DreamOne/MP_DreamOne_Main" ||
			current.loadHome == 1 && current.Level == "/HomeSweetHome/MP_HomeSweetHome_Main" ||
			current.loadSchool == 1 && current.Level == "/School/MP_School_Main" ||
			current.loadBridge == 1 && current.Level == "/Bridge/MP_Bridge_Main" ||
			current.loadPlay == 1 && current.Level == "/Playhouse/MP_Playhouse_Main" ||
			current.loadCounsel == 1 && current.Level == "/CounselorsOffice/MP_CounselorOffice_Main"||
			current.loadDream2 == 1 && current.Level == "/DreamTwo/MP_DreamTwo_Main"||
			current.loadFinal == 1 && current.Level == "/FinalEncounter/MP_FinalEncounter_Main";
			
}

reset
{
	return current.Level != "/Menus/Level_MainMenu" && old.Level == "/Menus/Level_MainMenu" && current.spawnType == 3;
}
