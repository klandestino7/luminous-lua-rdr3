RegisterNetEvent('WANTED:gunshotInProgress')
AddEventHandler('WANTED:gunshotInProgress', function(targetCoords)
    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 408396114, targetCoords.x, targetCoords.y, targetCoords.z, 60.0)	
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Disparo de Tiro')
    Wait(8000)
    RemoveBlip(blip)  
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
        local CityName = GetCurentTownName()


        if IsPedShooting(playerPed) then

            local Policia = TriggerServerEvent('WANTED:checkJOB')
        
            print(Policia)

            if CityName ~= nil then
                local ped = PlayerPedId()
                local currentWeaponHash = GetCurrentPedWeapon(ped)
                local havesilence = false
                local playerGender = GetEntityModel(ped)		            
                Citizen.Wait(3000)                                   
                DecorSetInt(playerPed, 'isOutlaw', 2)
                TriggerServerEvent('WANTED:gunshotInProgress', {
                    x = playerCoords.x,
                    y = playerCoords.y,
                    z = playerCoords.z,
                }, CityName, playerGender)
                
            end
		end
	end
end)




RegisterNetEvent('WANTED:outlawNotify')
AddEventHandler('WANTED:outlawNotify', function(alert)
    print('notifi')
    TriggerEvent('Distress', 'sucesso', "<b style='color:#007cb5; font-weight:700;'>Sheriff:</b> ".. (alert))
end)

function GetCurentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    end
end




-- RegisterNetEvent('WANTED:InfoSheriff')
-- AddEventHandler('WANTED:InfoSheriff', function(x, y, z, zone)
--     AllowSonarBlips(true)
--     --TriggerEvent("redemrp_notification:start", "Robbery in progress at "..zone , 5, "error")
--     local time = 60
--     Citizen.CreateThread(function()
--         while time > 0 do
--             Wait(1000)
--             ForceSonarBlipsThisFrame()
--             local coords = GetEntityCoords(PlayerPedId())
--             TriggerSonarBlip(348490638, x, y, z)
--             time = time - 1
--         end
--     end)
-- end)


-- local towns = {
--   --  [1] = { ["distance"] = 160.0, ["x"] = -300.00, ["y"] = 790.00, ["z"] = 117.00, ["name"] = "Valentine"},
--  --   [2] = { ["distance"] = 60.0, ["x"] = -1790.00, ["y"] = -404.00, ["z"] = 117.00, ["name"] = "Strawberry"},
--   --  [3] = { ["distance"] = 60.0, ["x"] = -812.00, ["y"] = -1294.00, ["z"] = 61.00, ["name"] = "Blackwater"},
--     [4] = { ["distance"] = 60.0, ["x"] = -3676.00, ["y"] = -2601.00, ["z"] = 00.00, ["name"] = "Armadillo"},
--    -- [5] = { ["distance"] = 180.0, ["x"] = -5510.00, ["y"] = -2939.00, ["z"] = 10.00, ["name"] = "Tumbleweed"},
--    -- [6] = { ["distance"] = 200.0, ["x"] = 1353.00, ["y"] = -1268.00, ["z"] = 80.00, ["name"] = "Rhodes"},
--    -- [7] = { ["distance"] = 500.0, ["x"] = 2604.00, ["y"] = -1177.00, ["z"] = 117.00, ["name"] = "Saint Denis"},
-- }



-- local NotifyIn = false
-- local NotifyOut = false

-- Citizen.CreateThread(function()
--     while true do
--         for i = 1, #towns do
--             Wait(500)
--             local player = PlayerPedId()
--             local coords = GetEntityCoords(player)
--             local dst = #(vector3(towns[i]["x"], towns[i]["y"], towns[i]["z"]) - coords)

--             if dst < towns[i]["distance"] then
--                 if not NotifyIn then    
--                     insideTown = true
--                    -- TriggerEvent("redemrp_notification:start", 'Bienvenido a '..towns[i]["name"], 5)
--                     print(dst) 
--                     NotifyIn = true
--                 elseif dst > towns[i]["distance"] then
--                     insideTown = false
--                 end
--             end
--             print(towns[i]["distance"])
--             if dst > towns[i]["distance"] then
--                 print('s')
--                 if not NotifyOut then                   
--                     NotifyIn = false
--                     NotifyOut = true
--                 end
--             end

--         end
--     end
--     return
-- end)
