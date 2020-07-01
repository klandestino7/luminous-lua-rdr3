local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterNetEvent('VP:WANTED:gunshotInProgress')
AddEventHandler('VP:WANTED:gunshotInProgress', function(targetCoords) 
 --   if cAPI.hasGroupOrInheritance('trooper') or cAPI.hasGroupOrInheritance('sheriff') then
        local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 408396114, targetCoords.x, targetCoords.y, targetCoords.z, 60.0)	
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Disparo de Tiro')
        Wait(8000)
        RemoveBlip(blip)  
   -- end
end)


local reward2 = 0 
local pname = "Nome Desconhecido"
local annon = false
local CityName = "Cidade Fantasma"

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
        local CityName = GetCurrentTownName()
        local retval, hashArma = GetCurrentPedWeapon(PlayerPedId(), 0, 0,0)
        local arma = Citizen.InvokeNative(0x705BE297EEBDB95D, hashArma)
        local retval, weaponHash = GetCurrentPedWeapon(playerPed, 1)
        if IsPedShooting(playerPed) and weaponHash ~= GetHashKey("WEAPON_BOW") then           
            if arma then
         --       local Policia = cAPI.hasGroupOrInheritance('trooper') or cAPI.hasGroupOrInheritance('sheriff')
                if CityName ~= nil and CityName ~= "Cidade Fantasma" then          
                    local ped = PlayerPedId()
                    local currentWeaponHash = GetCurrentPedWeapon(ped)
                    local havesilence = false
                    local playerGender = GetEntityModel(ped)		            
                    Citizen.Wait(3000)                   
                   -- DecorSetInt(playerPed, 'isOutlaw', 2)           
                    TriggerServerEvent('VP:WANTED:gunshotInProgress', {
                        x = playerCoords.x,
                        y = playerCoords.y,
                        z = playerCoords.z,
                    }, CityName, playerGender)      
                end
            end



		end
	end
end)


RegisterNetEvent('VP:WANTED:RewardClient')
AddEventHandler('VP:WANTED:RewardClient', function(arg1, arg2)
    TriggerServerEvent('VP:WANTED:RewardNotify', arg1, arg2, GetCurrentTownName()) 
    TriggerServerEvent('VP:WANTED:RewardSERVER', arg1, arg2, GetCurrentTownName())
end)


RegisterNetEvent('VP:WANTED:RewardNotify')
AddEventHandler('VP:WANTED:RewardNotify', function(reward, playername, city)
    reward2 = reward
    pname = playername
    CityName = city
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)    
    annon = true
    Wait(9000)
    annon = false
end)


RegisterNetEvent('VP:WANTED:GetWanted')
AddEventHandler('VP:WANTED:GetWanted', function(city)
    for key, value in pairs(city) do
        print(key, value)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)        
        if annon then            
            DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.30, 0.10, 0.8, 0, 0, 0, 250, 1)
            DrawTxt('~e~PROCURADO', 0.50, 0.05, 0.9, 0.9, true, 255, 255, 255, 255, true)
            DrawTxt('Capture ~e~' .. pname .. ' ~q~morto ou vivo, recompensa $' .. reward2, 0.50, 0.10, 0.3, 0.3, true, 255, 255, 255, 255, true)
            DrawTxt('E leve para o Sheriff de ~e~'.. CityName, 0.50, 0.12, 0.3, 0.3, true, 255, 255, 255, 255, true)
        end
    end
end)

RegisterNetEvent('VP:WANTED:outlawNotify')
AddEventHandler('VP:WANTED:outlawNotify', function(alert)
  --  if cAPI.hasGroupOrInheritance('trooper') or cAPI.hasGroupOrInheritance('sheriff') then
        TriggerEvent('VP:NOTIFY:Simple', "Sheriff: ".. (alert), 5000)
 --   end
end)


function GetCurrentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)

    if town_hash == GetHashKey("Annesburg") then
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
    elseif town_hash == false then
        return "Cidade Fantasma"
    end
end



function GetCurrentStateName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 0)

    -- if town_hash == GetHashKey("GuarmaD") then
    --     return "GuarmaD"
    -- elseif town_hash == GetHashKey("BayouNwa") then
    --     return "BayouNwa"
    -- elseif town_hash == GetHashKey("bigvalley") then
    --     return "bigvalley"
    -- elseif town_hash == GetHashKey("BluewaterMarsh") then
    --     return "BluewaterMarsh"
    -- elseif town_hash == GetHashKey("ChollaSprings") then
    --     return "ChollaSprings"
    -- elseif town_hash == GetHashKey("Cumberland") then
    --     return "Cumberland"
    -- elseif town_hash == GetHashKey("DiezCoronas") then
    --     return "DiezCoronas"
    -- elseif town_hash == GetHashKey("GaptoothRidge") then
    --     return "GaptoothRidge"
    -- elseif town_hash == GetHashKey("greatPlains") then
    --     return "greatPlains"
    -- elseif town_hash == GetHashKey("GrizzliesEast") then
    --     return "GrizzliesEast"
    -- elseif town_hash == GetHashKey("GrizzliesWest") then
    --     return "GrizzliesWest"
    -- elseif town_hash == GetHashKey("HennigansStead") then
    --     return "HennigansStead"
    -- elseif town_hash == GetHashKey("Perdido") then
    --     return "Perdido"
    -- elseif town_hash == GetHashKey("PuntaOrgullo") then
    --     return "PuntaOrgullo"
    -- elseif town_hash == GetHashKey("RioBravo") then
    --     return "RioBravo"
    -- elseif town_hash == GetHashKey("roanoke") then
    --     return "roanoke"     
    -- elseif town_hash == GetHashKey("scarlettMeadows") then
    --     return "scarlettMeadows"     
    -- elseif town_hash == GetHashKey("TallTrees") then
    --     return "TallTrees"     
    -- elseif town_hash == GetHashKey("Heartlands") then
    --     return "Heartlands"     
    -- elseif town_hash == false then
    --     return "Cidade Fantasma"
    -- end

    if town_hash == 999150106 then
        return "Ambarino"
    elseif town_hash == -1806461473 then
        return "Lemoyne"    
    elseif town_hash == -694461623 then 
        return "West Elizabeth"
    elseif town_hash == 1098225713 then
        return "New Austin"
    elseif town_hash == 1093870742 then  
        return "New Hanover"
    elseif town_hash == -1828192959 then  
        return "Guarma"
    end

end
--=============================================================-- DRAW TEXT SECTION--=============================================================--
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
	local str = CreateVarString(10, 'LITERAL_STRING', str)
	--Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end
	Citizen.InvokeNative(0xADA9255D, 1)
	DisplayText(str, x, y)
end




function CreateVarString(p0, p1, variadic)
	return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
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
