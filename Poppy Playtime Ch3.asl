// Poppy Playtime Ch3 Autosplitter and Load Remover
// Supports Load Remover IGT
// Splits for campaigns can be obtained from 
// Script by TheDementedSalad


state("Playtime_Chapter3-Win64-Shipping", "SteamRelease")
{
	byte CheckpointID	:	0x6DD1BA8, 0x158, 0x380; // 1 when you start, 2 when you reach the 2nd piston puzzle, 3 when you reach the platform stairs, 4 when you reach tram
	byte LevelID		:	0x6DD1BA8, 0x158, 0x480;
	byte spawnType		:	0x6DD1BA8, 0x1B8, 0x1C1;
	
	string100 Level		:	0x6DCDDA0, 0xAE0, 0x14; // /Game/Maps/Menus/Level_MainMenu in main menu 
	
	byte isPaused		:	0x6DCDDA0, 0xADA;
    byte isLoading		: 	0x6970FF8; // 0 when not loading (game not frozen)
	byte Inventory		:	0x6D1F364; // 1 in inventory, 0 not in inventory.
	
	float X				:	0x6DB30B0, 0x30, 0x2D0, 0x328, 0x264;
	float Y				:	0x6DB30B0, 0x30, 0x2D0, 0x328, 0x274;
	float Z				:	0x6DB30B0, 0x30, 0x2D0, 0x328, 0x26C;
	
	byte IntroPlaying	:	0x6DD4300, 0x110, 0x1E0, 0x50, 0x2F0, 0x8, 0x28, 0x280; //LevelSequencePlayer 
	uint IntroFrames	:	0x6DD4300, 0x110, 0x1E0, 0x50, 0x2F0, 0x8, 0x28, 0x294; //""
	byte EndingPlaying	:	0x6DD4300, 0x110, 0x1E0, 0x80, 0x2F0, 0x8, 0x28, 0x280; //""
	uint EndingFrames	:	0x6DD4300, 0x110, 0x1E0, 0x80, 0x2F0, 0x8, 0x28, 0x294; //""

}

init
{
	vars.completedSplits = new List<byte>();
	
	switch (modules.First().ModuleMemorySize)
	{
		case (122298368):
			version = "SteamRelease";
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
	
	//print(current.LevelID.ToString());
	
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplits.Clear();
	}

}

start
{
	return (current.X != old.X || current.Y != old.Y || current.Z != old.Z) && current.IntroPlaying == 0 && current.IntroFrames == 882;
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
	
	if(current.EndingFrames == 916 && current.EndingPlaying == 0 && old.EndingPlaying == 1){
		return true;
	}
}

isLoading
{
	return current.isPaused == 1 && current.Inventory != 1 || current.isLoading != 0 || current.Level == "/Menus/Level_MainMenu";
}

reset
{
	return current.Level != "/Menus/Level_MainMenu" && old.Level == "/Menus/Level_MainMenu" && current.spawnType == 3;
}
