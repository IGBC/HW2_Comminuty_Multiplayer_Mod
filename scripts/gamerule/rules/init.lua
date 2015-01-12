--global imports
dofilepath("data:scripts/gamerule/lib/3rd party code/sobgroupfunctions.lua");
dofilepath("data:scripts/scar/restrict.lua")
dofilepath("data:scripts/gamerule/lib/musicPlayer.lua")
dofilepath("data:scripts/gamerule/lib/CoreRules.lua")
dofilepath("data:scripts/gamerule/lib/MODEST31.lua");

function modinit()
	MPRestrict();
	print("Local player: "..FE_GetCurrentPlayerIndex());
	Music_PickTrack();
	dofilepath("data:balance/MANIFEST.lua");
	Rule_Add("CoreRuleUntimed");
end