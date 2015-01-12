splits={1,1,1,1,1,1};
--global ship splitter
function masterSplitter(playerIndex)
	local splitCount;
	local numToSplit = SobGroup_Count("Player_Ships"..playerIndex-1);
	splitCount = SobGroup_SplitGroup("Split_Player_Ships"..playerIndex.."_", "Player_Ships"..playerIndex-1, numToSplit);
	if not(splitCount == numToSplit) then
		-- splitting wasn't 100% successful
		--print("Splitting was "..splitCount.."/"..numToSplit.." effective for player "..playerIndex); 
		-- for i = 0, splitCount do
			-- if SobGroup_Count("Split_Player_Ships"..playerIndex.."_"..i) > 1 then
				-- SobGroup_Clear("Split_Player_Ships"..playerIndex.."_"..i);
				-- --I'm sure we'll get it next time, this just stops errors
			-- end
		-- end
	end
	--adjust for indexes in core:
	splitCount = splitCount -1; --this becomes maximum split index
	return splitCount;
end

function CoreRuleUntimed()
	Update_AllShips();
	local player,i,j;
	for player = 1, Universe_PlayerCount() do
		splits[player] = masterSplitter(player);
		for i = 0, splits[player] do			
			for j = 1, getn(shipManifest) do
				if SobGroup_AreAnyOfTheseTypes("Split_Player_Ships"..player.."_"..i, shipManifest[j].name)==1 then
					M3("Split_Player_Ships"..player.."_"..i,shipManifest[j]);
					break
				end
			end
		end
	end
end