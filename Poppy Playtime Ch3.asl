// Poppy Playtime Ch3 Autosplitter and Load Remover
// Supports Load Remover IGT
// Splits for campaigns can be obtained from 
// Script by TheDementedSalad


state("Playtime_Chapter3-Win64-Shipping", "SteamRelease")
{
	byte CheckpointID	:	0x6DD1BA8, 0x158, 0x380;
	byte LevelID		:	0x6DD1BA8, 0x158, 0x480;
	byte spawnType		:	0x6DD1BA8, 0x1B8, 0x1C1;
	

	string100 Level		:	0x6DCDDA0, 0xAE0, 0x14; // /Game/Maps/Menus/Level_MainMenu in main menu 
	
	byte isPaused		:	0x6DCDDA0, 0xADA;
    byte IsGameFrozen 	: 	0x6970FF8; // 0 when its not frozen != 0 when its frozen
	byte Inventory		:	0x6D1F364; 
	
	byte MoviePlaying	:	0x697E420, 0x130, 0x5F0, 0x50, 0x2F0, 0x8, 0x28, 0x280;
	uint MovieFrames	:	0x697E420, 0x130, 0x5F0, 0x50, 0x2F0, 0x8, 0x28, 0x294;

}

init
{
	switch (modules.First().ModuleMemorySize)
	{
		case (122298368):
			version = "SteamRelease";
			break;
	}
}

startup
{
}

update
{
	//Uncomment debug information in the event of an update.
	//print(modules.First().ModuleMemorySize.ToString());
	
	//print(current.LevelID.ToString());

}

start
{
	return current.MoviePlaying == 0 && old.MoviePlaying == 1 && current.MovieFrames == 882;
}

split
{

}

isLoading
{
	return current.isPaused == 1 && current.Inventory != 1 || current.IsGameFrozen != 0 || current.Level == "/Menus/Level_MainMenu";
}

reset
{
	return current.Level != "/Menus/Level_MainMenu" && old.Level == "/Menus/Level_MainMenu" && current.spawnType == 3;
}
