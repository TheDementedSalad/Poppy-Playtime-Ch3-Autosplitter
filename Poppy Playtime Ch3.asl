// Poppy Playtime Ch3 Autosplitter and Load Remover
// Supports Load Remover IGT
// Splits for campaigns can be obtained from 
// Script by TheDementedSalad


state("Playtime_Chapter3-Win64-Shipping", "SteamRelease")
{
	byte CheckpointID	:	0x6DD1BA8, 0x158, 0x380;
	byte LevelID		:	0x6DD1BA8, 0x158, 0x480;
	byte MainMenu		:	0x6DD1BA8, 0x158, 0x4E8;
	bool CatDefeat		:	0x6DD1BA8, 0x158, 0x3F9;

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
	return current.LevelID == 0 && current.CheckpointID == 1 && current.MainMenu != 0;
}

split
{

}

isLoading
{

}

reset
{

}
