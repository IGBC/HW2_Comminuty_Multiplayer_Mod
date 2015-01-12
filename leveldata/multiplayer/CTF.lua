-- =============================================================================
-- Homeworld 2 Clean Data Resource Project
-- By S110
-- Version 1.0
-- 02/06/2010
-- Tools used: EditPad Lite, LuaDC version 0.9.19, and Cold Fusion LUA Decompiler v1.0.0
-- =============================================================================

GUID = {110, 91, 157, 190, 18, 23, 250, 78, 144, 20, 41, 246, 181, 128, 214, 12}

GameRulesName = "Capture The Flag"

Description = "Use a resource collector to salvage the mover in the centre of the map. The player who salvages the mover the required number of times first will be the victor. Motherships are invulnerable, attepmting to anihalate your enemy is futile."

GameSetupOptions = {
{name = "scorelimit",
	locName = "Flag Captures For Victory",
	tooltip = "",
	default = 1,
	visible = 1,
	choices = {"1 TEST", 1, "3", 3, "5", 5, "7", 7},},
{name = "sharedflags",
	locName = "Share Flags",
	tooltip = "Share Flag Captures With Alies Of The Capturer",
	default = 0,
	visible = 1,
	choices = {"Yes", 1, "No", 0},},
{name = "resources",
	locName = "$3240",
	tooltip = "$3239",
	default = 1,
	visible = 0,
	choices = {"$3241", "0.5", "$3242", "1.0", "$3243", "2.0"},},
{name = "unitcaps",
	locName = "$3214",
	tooltip = "$3234",
	default = 1,
	visible = 0,
	choices = {"$3215", "Small", "$3216", "Normal", "$3217", "Large"},},
{name = "resstart",
	locName = "$3205",
	tooltip = "$3232",
	default = 0,
	visible = 1,
	choices = {"$3206", "1000", "$3207", "3000", "$3208", "10000", "$3209", "0"},},
{name = "lockteams",
	locName = "$3220",
	tooltip = "$3235",
	default = 1,
	visible = 0,
	choices = {"$3221", "yes", "$3222", "no"},},
{name = "startlocation",
	locName = "$3225",
	tooltip = "$3237",
	default = 0,
	visible = 1,
choices = {"$3226", "random", "$3227", "fixed"},},}

dofilepath("data:scripts/scar/restrict.lua")
dofilepath("data:scripts/gamerule/lib/musicPlayer.lua")

function OnInit()
	MPRestrict();
	print("mod code start");
	print("Local player: "..FE_GetCurrentPlayerIndex());
	Music_PickTrack();
	SobGroup_Create("flag");
	SobGroup_Create("Collector_Salvaging_flag");
	SobGroup_Create("Collector_Salvaging_flag_for_drop");
	
	Volume_AddSphere("flag spawn vol", {0,0,0,}, 1000);
	MS_NoKill();
	scorelimit=GetGameSettingAsNumber("scorelimit");
	sharedflags=GetGameSettingAsNumber("sharedflags");
	UI_SetScreenVisible("testingUI", 1);
	for i = 1,10 do
		UI_SetElementVisible("testingUI", "tstdat"..i.."_name", 0)
		UI_SetElementVisible("testingUI", "tstdat"..i.."_dat", 0)
	end	
	for i = 1, Universe_PlayerCount() do
		UI_SetElementVisible("testingUI", "tstdat"..i.."_name", 1)
		UI_SetElementVisible("testingUI", "tstdat"..i.."_dat", 1)
		UI_SetTextLabelText("testingUI", "tstdat"..i.."_name", "Player "..i.." Score")
		UI_SetTextLabelText("testingUI", "tstdat"..i.."_dat", "0")
	end
	UI_SetElementVisible("testingUI", "tstdat7_name", 1)
	UI_SetElementVisible("testingUI", "tstdat7_dat", 1)
	UI_SetTextLabelText("testingUI", "tstdat7_name", "Score Target")
	UI_SetTextLabelText("testingUI", "tstdat7_dat", scorelimit)
	score={0,0,0,0,0,0,};
	Rule_AddInterval("Rule_CreateFlag",300);
	Rule_AddInterval("init_notify",10);
end

function init_notify()
	Subtitle_Add(Actor_FleetCommand, "Use a Resource Collector to salvage the Mover from the centre of the map. \nThe Mover will spawn in 5 minutes.\nThe first player to salvage it "..scorelimit.." times will win.", 30);
	Sound_SpeechPlay("Data:sound/sfx/ui/sensorsmanager/fintelobjectiveping")
	Rule_Remove("init_notify");
end

function MS_NoKill()
	SobGroup_Create('starters');
	for player = 0, Universe_PlayerCount()-1 do
		SobGroup_Clear("starters");
		--check if player has empty sob
		if SobGroup_Empty("Player_Ships"..player)==0 then
			print("invun-ing mothership"..player);
			--Get motherships
			if Player_GetRace(player)==1 then --if hgn
				SobGroup_FillShipsByType("starters", "Player_Ships"..player, "Hgn_Mothership");
			else
				SobGroup_FillShipsByType("starters", "Player_Ships"..player, "Vgr_Mothership");
			end
			--make motherships unkillable
			SobGroup_SetInvulnerability("starters", 1);
			--prevent mothership scuttling;
			SobGroup_AbilityActivate("starters", AB_Scuttle, 0);
		end
	end
end

function Rule_CreateFlag()
	--create ship
	SobGroup_SpawnNewShipInSobGroup(-1, "MP_Flag", "Flag", "flag", "flag spawn vol");
	Subtitle_Add(Actor_FleetCommand, "ALERT: The Flag has Spawned. Go get it!", 7); --tell everyone
	Sound_SpeechPlay("Data:sound/sfx/ui/sensorsmanager/fintelobjectiveping")
	FOW_RevealGroup("flag", 1);
	SobGroup_SetInvulnerability("flag", 1); --flag can get caught in the crossfire, this stops it dieing.
	SobGroup_SetSwitchOwnerFlag("flag", 0); --makes us not loose the flag once captured
	Rule_Add("Rule_FlagBeingCaptured"); --start checking for capture
	Rule_Remove("Rule_CreateFlag");
	print("Flag Created");
end

function Rule_FlagBeingCaptured()
	SobGroup_GetSobGroupSalvagingGroup("flag", "Collector_Salvaging_flag"); --find slavaging collectors
	if (SobGroup_Empty("Collector_Salvaging_flag") == 0) then --if flag now picked up
		print("pickup detected");
		SobGroup_SetSpeed("Collector_Salvaging_flag", 0.6); --that thing is heavy
		Subtitle_Add(Actor_FleetCommand, "ALERT: Player "..(SobGroup_OwnedBy("Collector_Salvaging_flag")+1).." is capturing the flag", 7); --tell everyone
		Sound_SpeechPlay("Data:sound/sfx/ui/sensorsmanager/fintelobjectiveping")
		Music_ForceBattle = 1; --update audio
		Rule_Add("Rule_FlagDropped"); --check for drop
		Rule_Add("Rule_FlagSalvaged"); --check for capture
		Rule_Remove("Rule_FlagBeingCaptured"); --stop checking for pickup
	end
end

function Rule_FlagDropped()
	local is_captured = 0;
	SobGroup_GetSobGroupSalvagingGroup("flag", "Collector_Salvaging_flag_for_drop"); --find slavaging collectors
	if (SobGroup_Empty("Collector_Salvaging_flag_for_drop") == 1) then --if flag now dropped
		if SobGroup_IsDoingAbility("Collector_Salvaging_flag", AB_Dock)==0 then --check for misfire as group goes empty during docking
			Subtitle_Add(Actor_FleetCommand, "ALERT: Player "..(SobGroup_OwnedBy("Collector_Salvaging_flag")+1).." dropped the flag", 7); --tell everyone
			Sound_SpeechPlay("Data:sound/sfx/ui/sensorsmanager/fintelobjectiveping")
			SobGroup_SetSpeed("Collector_Salvaging_flag", 1); --collector returned to full speed
			Music_ForceBattle = 0; --update audio
			Rule_Remove("Rule_FlagDropped"); --stop check for drop
			Rule_Remove("Rule_FlagSalvaged"); --stop check for capture
			Rule_Add("Rule_FlagBeingCaptured"); --check for pickup
			print("Flag Dropped");
		else
			--False Alarm
			--check distance between flags
		end
	end	
	SobGroup_Clear("Collector_Salvaging_flag_for_drop"); --don't need this anymore
end

function Rule_FlagSalvaged()
	--check for capture
	for player = 0, Universe_PlayerCount()-1 do --for each player
		if (SobGroup_SalvagedByPlayer("flag", player) == 1) then --check if they have captured the flag
			local gameover = 0;
			print("capture detected by "..player);
			SobGroup_SetSpeed("Collector_Salvaging_flag", 1); --collector returned to full speed
			Subtitle_Add(Actor_FleetCommand, "ALERT: Player "..(player+1).." has captured the flag", 7); --tell everyone
			Sound_SpeechPlay("Data:sound/sfx/ui/sensorsmanager/fintelobjectiveping")
			SobGroup_Clear("Collector_Salvaging_flag"); --don't need this angmore
			SobGroup_Clear("flag");
			Music_ForceBattle = 0; --update audio
			--score
			score[player+1]=score[player+1]+1; --increment score
			UI_SetTextLabelText("testingUI", "tstdat"..(player+1).."_dat", score[player+1]);--update ui
			for otherplayer = 0, Universe_PlayerCount()-1 do
				if not(otherplayer == player) then
					if AreAllied(player, otherplayer) == 1 then
						score[otherplayer+1]=score[otherplayer+1]+1; --always share with your freinds
					end
				end
			end
			if score[player+1]==scorelimit then
				--victory code
				Subtitle_Add(Actor_FleetCommand, "ALERT: Player "..(player+1).." won the game.", 10000);
				Sound_SpeechPlay("Data:sound/sfx/ui/sensorsmanager/fintelobjectiveping")
				if sharedflags == 1 then --if shared flags enabled
					for otherplayer = 0, Universe_PlayerCount()-1 do
						if not(otherplayer == player) then
							if not (AreAllied(player, otherplayer) == 1) then
								Player_Kill(otherplayer); --kill off all players not allied with the victor
							end
						end
					end
				end
				Event_Start("endGame")
				Rule_Add("waitForEnd")
				gameover = 1;
			end
			--end score
			Rule_Remove("Rule_FlagDropped"); --stop check for drop
			Rule_Remove("Rule_FlagSalvaged"); --stop check for capture
			if gameover == 0 then
				Rule_AddInterval("Rule_CreateFlag",RandomRange(60,120));
			end
		end
	end
end

function MainRule()
	local playerIndex = 0;
	local playerCount = Universe_PlayerCount();
	while (playerIndex < playerCount) do
		if (Player_IsAlive(playerIndex) == 1 and Player_HasShipWithBuildQueue(playerIndex) == 0) then
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
		Event_Start("endGame")
		Rule_Add("waitForEnd")
		Rule_Remove("MainRule")
	end
end

function waitForEnd()
	if (Event_IsDone("endGame")) then
	setGameOver()
	Rule_Remove("waitForEnd")
	end
end

function list_abilites(sob)
	print("current abilites being done by "..sob.." ("..SobGroup_Count(sob).." ships)");
	print(SobGroup_IsDoingAbility(sob, AB_None));
	print(SobGroup_IsDoingAbility(sob, AB_Move));
	print(SobGroup_IsDoingAbility(sob, AB_Attack));
	print(SobGroup_IsDoingAbility(sob, AB_Guard));
	print(SobGroup_IsDoingAbility(sob, AB_Repair));
	print(SobGroup_IsDoingAbility(sob, AB_Cloak));
	print(SobGroup_IsDoingAbility(sob, AB_Harvest));
	print(SobGroup_IsDoingAbility(sob, AB_Mine));
	print(SobGroup_IsDoingAbility(sob, AB_Capture));
	print(SobGroup_IsDoingAbility(sob, AB_Dock));
	print(SobGroup_IsDoingAbility(sob, AB_AcceptDocking));
	print(SobGroup_IsDoingAbility(sob, AB_Stop));
	print(SobGroup_IsDoingAbility(sob, AB_Hyperspace));
	print(SobGroup_IsDoingAbility(sob, AB_Parade));
	print(SobGroup_IsDoingAbility(sob, AB_FormHyperspaceGate));
	print(SobGroup_IsDoingAbility(sob, AB_HyperspaceViaGate));
	print(SobGroup_IsDoingAbility(sob, AB_SensorPing));
	print(SobGroup_IsDoingAbility(sob, AB_SpecialAttack));
	print(SobGroup_IsDoingAbility(sob, AB_Retire));
	print(SobGroup_IsDoingAbility(sob, AB_DefenseField));
	print(SobGroup_IsDoingAbility(sob, AB_DefenseFieldShield));
	print(SobGroup_IsDoingAbility(sob, AB_HyperspaceInhibitor));
	print(SobGroup_IsDoingAbility(sob, AB_Steering));
	print(SobGroup_IsDoingAbility(sob, AB_Targeting));
	print(SobGroup_IsDoingAbility(sob, AB_Sensors));
	print(SobGroup_IsDoingAbility(sob, AB_Lights));
	print(SobGroup_IsDoingAbility(sob, AB_Scuttle));
	print(SobGroup_IsDoingAbility(sob, AB_UseSpecialWeaponsInNormalAttack));	
end

Events = {}
Events["endGame"] = {{{"wID = Wait_Start(20)", "Wait_End(wID)"},},}
