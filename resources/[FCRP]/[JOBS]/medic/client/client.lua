local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

---------------------------
-- MEDIC MANAGEMENT API --
---------------------------
-- Variables


RegisterNetEvent('FRP:MEDIC:revivecheck')
AddEventHandler('FRP:MEDIC:revivecheck', function()
  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('FRP:MEDIC:revivecallback', GetPlayerPed(player))
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Curou o (' .. GetPlayerName(player) .. ')')
  else
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

RegisterNetEvent('FRP:MEDIC:heal')
AddEventHandler('FRP:MEDIC:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
	SetEntityHealth(playerPed, maxHealth)
end)



Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(100) -- DO NOT REMOVE

			local playerdst = cAPI.getNearestPlayer(3)
			local whoplayer = cAPI.getNearestPlayers(3)
			--if IsControlJustPressed(0, 0xE8342FF2) then -- Hold ALT      
		--		print(playerdst, whoplayer)
			--end		

			-- if IsPlayerDead(player) and isDead == false then
			-- 	Citizen.Wait(0) -- DO NOT REMOVE
			-- 	isDead = true				
			-- 	deathEndingTime = GetGameTimer() + Config.RespawnTime	
			-- end
		end
	end
)

-- RegisterNetEvent('FRP:MEDIC:revive')
-- AddEventHandler('FRP:MEDIC:revive', function()
-- Citizen.CreateThread(function()

-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	--TriggerServerEvent('FRP:MEDIC:setDeathStatus', false)

-- 		IsDead = false
-- 		DoScreenFadeOut(800)

-- 		while not IsScreenFadedOut() do
-- 			Citizen.Wait(50)
-- 			IsDead = false 
-- 			local timer = tonumber(0)
-- 		end

-- 		DoScreenFadeOut(300)

-- 		local pl = Citizen.InvokeNative(0x217E9DC48139933D)
-- 		local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)

-- 	if IsDead == false then
-- 		local coords = GetEntityCoords(ped, false)
-- 		SetEntityCoords(ped, coords.x, coords.y, coords.z)	
-- 		DoScreenFadeIn(200)
-- 		IsDead = false 
--     	Citizen.InvokeNative(0x71BC8E838B9C6035, ped)
-- 		Citizen.InvokeNative(0x0E3F4AF2D63491FB)
-- 		SetEntityHealth(GetPlayerPed(-1), 200)
-- 		DisplayHud(true)
-- 		print(IsDead)
-- 		DisplayRadar(true)
-- 	end
-- end)
-- end)

function isNearPlayer()
	local player, distance = GetClosestPlayer()
	if distance ~= -1 and distance <= 2.0 then
	    return player, distance
	else
	    return false
	end
	return false
end


function GetPlayers()
    local players = {}

    for _,player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
    
    local coords, usePlayerPed = coords, false
    local playerPed, playerId = PlayerPedId(), PlayerId()

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    for i=1, #players, 1 do
        local target = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(target)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end