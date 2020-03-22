Citizen.CreateThread(function() -- ESCONDER E MOSTRAR ALGUMAS HUDS
    while true do
        Citizen.Wait(0)    
        N_0x8bc7c1f929d07bf3(-1679307491) -- show    
        N_0x4cc5f2fc1332577f(-66088566) -- hide mpmoney
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 0xBB47198C) --disables reticle
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 1058184710) --remove skill cards
        Citizen.InvokeNative(0x4CC5F2FC1332577F, -66088566) --removed money
        N_0x50c803a4cd5932c5(false)
        N_0xd4ee21b7cc7fd350(false)
        Citizen.InvokeNative(0x50C803A4CD5932C5, true)
        Citizen.InvokeNative(0xD4EE21B7CC7FD350, true)
        GetTemperatura()
        DisplayRadar(true)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local ped = PlayerPedId()            
        if IsPedOnMount(ped) then            
            SetRelationshipBetweenGroups(1, 'PLAYER', 'PLAYER')
           -- print"set1"
        else
            SetRelationshipBetweenGroups(5, 'PLAYER', 'PLAYER')
           -- print"set2"
        end

        if IsPedInAnyVehicle(ped,false) or IsPedGettingIntoAVehicle(ped) then            
            SetRelationshipBetweenGroups(1, 'PLAYER', 'PLAYER')
       -- print"set1"
        else
            SetRelationshipBetweenGroups(5, 'PLAYER', 'PLAYER')
       -- print"set2"
        end
    end
end)

function GetTemperatura()
	    local _source = source
        local ent = GetPlayerPed(_source)
        local pp = GetEntityCoords(ent)
       	local temperatura = GetTemperatureAtCoords(tonumber(pp.x), tonumber(pp.y), tonumber(pp.z))     
        local vida = GetEntityHealth(PlayerPedId())
        if vida <= 5 then
         -- print('chegou')
        else

        if temperatura < -5 then
          Wait(5000)
            local pl = Citizen.InvokeNative(0x217E9DC48139933D)
            local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
          Citizen.InvokeNative(0x697157CED63F18D4, ped, 5, false, true, true)     
          print('está muito frio')     
        end
        if temperatura > 40 then 
          Wait(5000)
            local pl = Citizen.InvokeNative(0x217E9DC48139933D)
            local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
           Citizen.InvokeNative(0x697157CED63F18D4, ped, 5, false, true, true)  
          print('está muito calor')   
        end
      end
--print(temperatura)
end



-- local towns = {
--     [1] = { ["distance"] = 160.0, ["x"] = -300.00, ["y"] = 790.00, ["z"] = 117.00, ["name"] = "Valentine"},
--     [2] = { ["distance"] = 60.0, ["x"] = -1790.00, ["y"] = -404.00, ["z"] = 117.00, ["name"] = "Strawberry"},
--     [3] = { ["distance"] = 60.0, ["x"] = -812.00, ["y"] = -1294.00, ["z"] = 61.00, ["name"] = "Blackwater"},
--     [4] = { ["distance"] = 60.0, ["x"] = -3676.00, ["y"] = -2601.00, ["z"] = 00.00, ["name"] = "Armadillo"},
--     [5] = { ["distance"] = 180.0, ["x"] = -5510.00, ["y"] = -2939.00, ["z"] = 10.00, ["name"] = "Tumbleweed"},
--     [6] = { ["distance"] = 200.0, ["x"] = 1353.00, ["y"] = -1268.00, ["z"] = 80.00, ["name"] = "Rhodes"},
--     [7] = { ["distance"] = 500.0, ["x"] = 2604.00, ["y"] = -1177.00, ["z"] = 117.00, ["name"] = "Saint Denis"},
-- }

-- local NotifyIn = false
-- local NotifyOut = false
-- local insideTown = false

-- Citizen.CreateThread(function()
--     while true do
--         for i = 1, #towns do
--             Wait(500)
--             local player = PlayerPedId()
--             local coords = GetEntityCoords(player)
--             local myV = vector3(coords.x, coords.y, coords.z)
--             local dst = #(vector3(towns[i]["x"], towns[i]["y"], towns[i]["z"]) - myV)
            
--             if dst < towns[i]["distance"] then

--                 if not NotifyIn then                      
--                     insideTown = true


--                  --   TriggerEvent("fc_notify:start", 'Bem-vindo a '..towns[i]["name"], 5)
              
--                     NotifyIn = true
--                     NotifyOut = false

--                 elseif dst > towns[i]["distance"] then
--                     insideTown = false
--                 end

--             else

--                 if not NotifyOut then
--                     NotifyIn = false
--                     NotifyOut = true
--                 end

--             end


--         end
--     end
--     return
-- end)

-- local prompt = false
-- local AnimalPrompt

-- function SetupAnimalPrompt()
--     Citizen.CreateThread(function()
--         local str = 'Colocar '
--         AnimalPrompt = PromptRegisterBegin()
--         PromptSetControlAction(AnimalPrompt, 0xE8342FF2)
--         str = CreateVarString(10, 'LITERAL_STRING', str)
--         PromptSetText(AnimalPrompt, str)
--         PromptSetEnabled(AnimalPrompt, false)
--         PromptSetVisible(AnimalPrompt, false)
--         PromptSetHoldMode(AnimalPrompt, true)
--         PromptRegisterEnd(AnimalPrompt)

--     end)
-- end

-- Citizen.CreateThread(function()
-- 	SetupAnimalPrompt()
-- 	while true do 
-- 		Wait(100)
-- 		local ped = PlayerPedId()
-- 		coords = GetEntityCoords(ped)
-- 		forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
-- 		local Pos2 = GetEntityCoords(ped)
-- 		local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
-- 		local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
-- 		local A,hit,C,C,spot = GetShapeTestResult(rayCast)                
-- 		local model = GetEntityModel(spot)
-- 		cartcoords = GetEntityCoords(spot)
-- 		if model == model == -1758092337 or model == -1347283941 then --1347283941 : cart03 --1758092337 : WAGON05X
-- 			local animal = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
-- 			if animal ~= false then
-- 				if prompt == false then
-- 					PromptSetEnabled(AnimalPrompt, true)
-- 					PromptSetVisible(AnimalPrompt, true)
-- 					prompt = true
-- 				end
-- 				if PromptHasHoldModeCompleted(AnimalPrompt) then
-- 					PromptSetEnabled(AnimalPrompt, false)
-- 					PromptSetVisible(AnimalPrompt, false)
-- 					prompt = false
-- 					animalcheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
-- 					pedid = NetworkGetNetworkIdFromEntity(animalcheck)
-- 					Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), animalcheck, GetEntityCoords(PlayerPedId()), 10.0, true)
-- 					DoScreenFadeOut(1800)
-- 					Wait(2000)
-- 					TriggerServerEvent('EveryoneTeleportEntity',pedid,cartcoords.x,cartcoords.y,cartcoords.z+1.5)
-- 					SetEntityCoords(animalcheck,cartcoords.x,cartcoords.y,cartcoords.z+1.5,false)
-- 					DoScreenFadeIn(3000)
-- 					Wait(2000)
-- 				end

-- 				forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
-- 				local Pos2 = GetOffsetFromEntityInWorldCoords(ped, -0.0, 0.0,0.5)
-- 				local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
-- 				local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
-- 				A,hit,B,C,spot = GetShapeTestResult(rayCast)
-- 				NetworkRequestControlOfEntity(animalcheck)
-- 				model = GetEntityModel(spot)
-- 			else
-- 				PromptSetEnabled(AnimalPrompt, false)
-- 				PromptSetVisible(AnimalPrompt, false)
-- 				prompt = false
-- 			end
-- 		else
-- 			PromptSetEnabled(AnimalPrompt, false)
-- 			PromptSetVisible(AnimalPrompt, false)
-- 			prompt = false
-- 		end
-- 	end
-- end)


RegisterNetEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(netid,x,y,z)
	ent = NetworkGetEntityFromNetworkId(netid)
	Wait(150)
	SetEntityCoords(ent,x,y,z)
end)
