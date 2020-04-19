Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())

		for i=1, #Config.DoorList do
			local doorID   = Config.DoorList[i]
			local distance = GetDistanceBetweenCoords(playerCoords, doorID.doorCoords.x, doorID.doorCoords.y, doorID.doorCoords.z, true)

			local maxDistance = 1.5
			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < 1.5 then
				if distance < maxDistance then
					ApplyDoorState(doorID)
					
					local displayText = 'Destrancada'
					if doorID.locked then
						displayText = 'Trancada'
					end

					DrawText3D(doorID.doorCoords.x, doorID.doorCoords.y, doorID.doorCoords.z, displayText)
					
					if IsControlJustPressed(2, 0xE8342FF2) then -- Hold ALT
						TriggerEvent("VP:DOORLOCK:updatedoor", GetPlayerServerId(), i)
			
					end
				end
			end
		end
	end
end)

RegisterNetEvent('VP:DOORLOCK:updatedoor')
AddEventHandler('VP:DOORLOCK:updatedoor', function(source, door) 

    TriggerServerEvent("VP:DOORLOCK:updatedoorsv", source, door, function(cb) end) --Perms check
end)

RegisterNetEvent('VP:DOORLOCK:changedoor')
AddEventHandler('VP:DOORLOCK:changedoor', function(doorID) 
	local name   = Config.DoorList[doorID]
	name.locked = not name.locked
	TriggerServerEvent('VP:DOORLOCK:updateState', source, doorID, name.locked)
end)

RegisterNetEvent('VP:DOORLOCK:setState')
AddEventHandler('VP:DOORLOCK:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

function ApplyDoorState(doorID)
	local shapeTest = StartShapeTestBox(doorID.doorCoords.x, doorID.doorCoords.y, doorID.doorCoords.z, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, 16)
    local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
	FreezeEntityPosition(entityHit, doorID.locked)

	DoorSystemSetDoorState(entityHit, doorID.locked)
	if doorID.locked then
		SetEntityRotation(entityHit, 0.0, 0.0, doorID.objYaw, 1, true)
		if GetEntityRotation(entityHit).z ~= doorID.objYaw then
			SetEntityRotation(entityHit, 0.0, 0.0, doorID.objYaw, 1, true)
		end
	end
end