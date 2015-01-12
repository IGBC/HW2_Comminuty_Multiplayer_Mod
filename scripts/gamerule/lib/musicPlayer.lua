dofilepath("data:scripts/gamerule/lib/music_data.lua")

Music_ForceBattle = 0;

function Music_PickTrack()
	local track;
	if (SobGroup_UnderAttack("Player_Ships"..FE_GetCurrentPlayerIndex())==1 or 
		SobGroup_IsDoingAbility("Player_Ships"..FE_GetCurrentPlayerIndex(), AB_Attack)==1) or
		Music_ForceBattle == 1 then
		track = Music_Battle[random(1,getn(Music_Battle))];
	else
		--if player not in battle then pick a track from the ambient track list
		track = Music_Ambient[random(1,getn(Music_Ambient))];
		--as we are not in combat RN check for battle listener running, if not reactivate it
		if Rule_Exists("Music_BattleListener") == 0 then
			Rule_Add("Music_BattleListener");
		end
	end
	Sound_MusicPlayType(track.path, MUS_Ambient); --play track
	print("Track Over - Playing: "..track.name);
	if Rule_Exists("Music_PickTrack") then
		Rule_Remove("Music_PickTrack"); --clear this trigger
	end
	Rule_AddInterval("Music_PickTrack",track.length) --reset this trigger to fire at the end of the track
end

function Music_BattleListener()
	if (SobGroup_UnderAttack("Player_Ships"..FE_GetCurrentPlayerIndex())==1 or 
		SobGroup_IsDoingAbility("Player_Ships"..FE_GetCurrentPlayerIndex(), AB_Attack)==1) or
		Music_ForceBattle == 1 then
		--we are in battle so stop the ambient music start battle music NOW
		local track = Music_Battle[random(1,getn(Music_Battle))];
		Sound_MusicPlayType(track.path, MUS_Ambient);
		print("Battle Detected - Playing: "..track.name);
		if Rule_Exists("Music_PickTrack") then
			Rule_Remove("Music_PickTrack"); --clear this trigger
		end
		Rule_AddInterval("Music_PickTrack",track.length) --reset this trigger to fire at the end of the track
		--we are now in battle mode so we won't need this listener to fire again until we are back in ambiant mode
		Rule_Remove("Music_BattleListener");
	end
end
