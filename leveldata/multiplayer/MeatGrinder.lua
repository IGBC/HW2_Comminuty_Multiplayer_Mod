GUID = {110, 91, 157, 190, 18, 23, 250, 78, 144, 20, 41, 246, 181, 128, 214, 12}

GameRulesName = "Meat Grinder"
Description = ""
Directories ={Levels = "data:LevelData\\Multiplayer\\meatgrinder\\",};

GameSetupOptions = {
{name = "unitcaps",
	locName = "$3214",
	tooltip = "$3234",
	default = 2,
	visible = 0,
	choices = {"$3215", "Small", "$3216", "Normal", "$3217", "Large"},},
{name = "resstart",
	locName = "$3205",
	tooltip = "$3232",
	default = 0,
	visible = 1,
	choices = {"10000", "10000", "20000", "20000", "30000", "30000", "40000", "40000", "50000", "50000", "60000", "60000", "70000", "70000", "80000", "80000", "90000", "90000", "100000", "100000"},},
{name = "lockteams",
	locName = "$3220",
	tooltip = "$3235",
	default = 0,
	visible = 0,
	choices = {"$3221", "yes", "$3222", "no"},},
{name = "startlocation",
	locName = "$3225",
	tooltip = "$3237",
	default = 1,
	visible = 0,
choices = {"$3226", "random", "$3227", "fixed"},},}

dofilepath("data:scripts/gamerule/rules/init.lua")

function OnInit()
	modinit()
	Rule_Add("Rule_init");
end
function Rule_init()
	--wait for ships to appear hack
	if (SobGroup_Empty("Player_Ships0")==0) then
		--oneshot;
		Rule_Remove("Rule_init");
		--set up players (both of them)
		for player = 0, Universe_PlayerCount()-1 do
			SobGroup_Create("SY"..player);
			SobGroup_Clear("SY"..player);
			--destroy starting ships
			--SobGroup_Despawn("Player_Ships"..player);
			SobGroup_SetHealth("Player_Ships"..player, 0);
			--spawn shipyard & restrict collectors and constructors
			if Player_GetRace(player)==1 then --if hgn
				SobGroup_SpawnNewShipInSobGroup(player, "Hgn_Shipyard", "Shipyard", "SY"..player, "StartPos"..player);
				Player_RestrictBuildOption(player, "Hgn_Resourcecollector");
				Player_RestrictBuildOption(player, "Hgn_Shipyard");
				Player_RestrictBuildOption(player, "Hgn_Carrier");
				--hgn needs adv res module
				SobGroup_CreateSubSystem("SY"..player, "AdvancedResearch");
				Player_RestrictBuildOption(player, "AdvancedResearch");
			else
				SobGroup_SpawnNewShipInSobGroup(player, "Vgr_Shipyard", "Shipyard", "SY"..player, "StartPos"..player);
				Player_RestrictBuildOption(player, "Vgr_Resourcecollector");
				Player_RestrictBuildOption(player, "Vgr_Shipyard");
				Player_RestrictBuildOption(player, "Vgr_Carrier");
			end
			--restrict disallowed units
			--production
			Player_RestrictBuildOption(player, "FighterProduction");
			Player_RestrictBuildOption(player, "CorvetteProduction");
			Player_RestrictBuildOption(player, "FrigateProduction");
			--generic
			Player_RestrictBuildOption(player, "CloakGenerator");
			Player_RestrictBuildOption(player, "FireControlTower");
			Player_RestrictBuildOption(player, "HyperspaceInhibitor");
			Player_RestrictBuildOption(player, "PlatformProduction");
			Player_RestrictBuildOption(player, "Research");
			Player_RestrictBuildOption(player, "Hyperspace");
			--sensor
			Player_RestrictBuildOption(player, "HyperspaceSensor");
			Player_RestrictBuildOption(player, "CloakSensor");
			--set-up shipyard
			SobGroup_CreateSubSystem("SY"..player, "FighterProduction");
			SobGroup_CreateSubSystem("SY"..player, "CorvetteProduction");
			SobGroup_CreateSubSystem("SY"..player, "FrigateProduction");
			SobGroup_CreateSubSystem("SY"..player, "CapShipProduction");
			SobGroup_CreateSubSystem("SY"..player, "Research");
			--stop sy from moving
			SobGroup_SetMaxSpeedMultiplier("SY"..player, 0);
			--make SY Build Faster
			SobGroup_SetBuildSpeedMultiplier("SY"..player, 100);
			--grant build techs
			Player_GrantAllResearch(player);
		end
		Rule_Add("BuildRule");
		Rule_AddInterval("KillSY",60 + (GetGameSettingAsNumber("resstart")*0.0015)); --2 mins + 1 min per 10000 ru's  
		Rule_Add("MainRule");
		--focus on new shipyard
		Camera_FocusSobGroupWithBuffer("SY"..Universe_CurrentPlayer(), 100000, 1500, 0);
		SobGroup_Create("Parade");
	end
end

--rules for build phase
function BuildRule()
	for player = 0, Universe_PlayerCount()-1 do
		SobGroup_Clear("Parade");
		SobGroup_SetBuildSpeedMultiplier("Player_Ships"..player, 100);
		SobGroup_FillSubstract("Parade", "Player_Ships"..player, "SY"..player);
		SobGroup_ParadeSobGroup("Parade", "SY"..player, 2);
	end
end

function KillSY()
	Rule_Remove("KillSY");
	Rule_Remove("BuildRule");		
	for player = 0, Universe_PlayerCount()-1 do
		SobGroup_SetHealth("SY"..player,0);
		SobGroup_SetBuildSpeedMultiplier("Player_Ships"..player, 1);
	end
end

function MainRule()
	local playerIndex = 0;
	local playerCount = Universe_PlayerCount();
	while (playerIndex < playerCount) do
	if (Player_IsAlive(playerIndex) == 1 and SobGroup_Empty("Player_Ships"..playerIndex) == 1) then
	Player_Kill(playerIndex)
	end
	playerIndex = playerIndex + 1
	end
	local numAlive = 0;
	local numEnemies = 0;
	local gameOver = 1;
	playerIndex = 0
	while (playerIndex < playerCount) do
	if (Player_IsAlive(playerIndex) == 1) then
	local otherPlayerIndex = 0;
	while (otherPlayerIndex < playerCount) do
	if (AreAllied(playerIndex, otherPlayerIndex) == 0 and Player_IsAlive(otherPlayerIndex) == 1) then
	gameOver = 0
	else
	numEnemies = numEnemies + 1
	end
	otherPlayerIndex = otherPlayerIndex + 1
	end
	numAlive = numAlive + 1
	end
	playerIndex = playerIndex + 1
	end
	if (numEnemies == 0 and numAlive > 0) then
	gameOver = 0
	end
	if (gameOver == 1) then
	Rule_Add("waitForEnd")
	Event_Start("endGame")
	Rule_Remove("MainRule")
	end
end

function waitForEnd()
	if (Event_IsDone("endGame")) then
	setGameOver()
	Rule_Remove("waitForEnd")
	end
end

Events = {}
Events["endGame"] = {{{"wID = Wait_Start(5)", "Wait_End(wID)"},},}
