--See spec sheet for configuration details.
--Operation of this code requires a ship splitter and ship manifest.

-- MODDEST 3.1 by IGBC. Do not use without permission from IGBC: fakespamtrap@gmail.com
function M3(ship,ship_type) 
	--variables
	local n = ship_type.M3[1]; --name
	local c = ship_type.M3[2]; --count
	local p = ship_type.M3[3]; --preset list
	local pc = getn(ship_type.M3[3]); --preset count
	local i, j; --loop counters
	
	for i = 1, pc do --for each preset option
		if SobGroup_GetHardPointHealth(ship, n.."_"..p[i]) == 1 then
		--if preset has been built
			--populate slots
			print("preset exists, populating")
			for j = 1, c do
				SobGroup_CreateSubSystem(ship, p[i].."_"..j);	
			end
			--erase Preset Flag
			SobGroup_SetHardPointHealth(ship, n.."_"..p[i], 0);
			break
		end
	end
	
	--if ship has disarm command
	if (SobGroup_GetHardPointHealth(ship, n.."_DISARM") == 1) then
		for i = 1,c do --depopulate slots
			SobGroup_SetHardPointHealth(ship, n.."_"..i, 0);
		end
		--clear flags
		SobGroup_SetHardPointHealth(ship, n.."_DISARM", 0);
	end
end

--legacy MODDEST 2 support (now called "M2") (verson 2.5)
function M2(ship,guns,subsName)
local name = ship_type.M2[1];
local guns = ship_type.M2[2];
local subsName = ship_type.M2[3];
local i;
	if guns > 0 then
		--if ARM flag exists (prebuilt on ship)
		if SobGroup_GetHardPointHealth(ship, name.."_ARM") > 0 then
			for i = 1, guns do
				--create preset guns
				SobGroup_CreateSubSystem(ship, subsName.."_"..i);
			end
			--remove ARM flag
			SobGroup_SetHardPointHealth(ship, name.."_ARM", 0);
		end
		--if DISARM flag exists (built by player)
		if SobGroup_GetHardPointHealth(ship, name.."_DISARM") > 0 then
			for i = 1, guns do
				--remove all guns
				SobGroup_SetHardPointHealth(ship, name.."_"..i, 0);
			end
			--remove all flags
			SobGroup_SetHardPointHealth(ship, name.."_ARM", 0);
			SobGroup_SetHardPointHealth(ship, name.."_DISARM", 0);
		end
	end
end