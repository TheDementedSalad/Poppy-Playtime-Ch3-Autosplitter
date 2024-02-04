// Poppy Playtime Ch3 Autosplitter and Load Remover
// Supports Load Remover IGT
// Splits for campaigns can be obtained from 
// Script by TheDementedSalad


state("Playtime_Chapter3-Win64-Shipping", "SteamRelease")
{
	byte CheckpointID	:	0x6DD1BA8, 0x158, 0x380;
	byte LevelID		:	0x6DD1BA8, 0x158, 0x480;
	byte spawnType		:	0x6DD1BA8, 0x1B8, 0x1C1;
	

	string100 Level		:	0x6DCDDA0, 0x4E0, 0x0; // /Game/Maps/Menus/Level_MainMenu in main menu 
	
	byte isPaused		:	0x6DCDDA0, 0xADA;
    byte IsGameFrozen 	: 	0x6970FF8; // 0 when its not frozen != 0 when its frozen
	byte Inventory		:	0x6D1F364; 

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
	return current.LevelID == 0 && current.CheckpointID == 1 && current.IsGameFrozen == 0;
}

split
{

}

isLoading
{
	return current.isPaused == 1 && current.Inventory != 1 || current.IsGameFrozen != 0;
}

reset
{
	return current.spawnType == 3 && old.spawnType != 3;
}
