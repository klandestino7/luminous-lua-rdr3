
local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

Citizen.CreateThread(function() -- ESCONDER E MOSTRAR ALGUMAS HUDS
    while true do
        Citizen.Wait(0) 

     --   N_0x69d65e89ffd72313(true) -- cinematic--
--N_0xbae08f00021bffb2(horse) -- agitates the horse


        N_0x8bc7c1f929d07bf3(-1679307491) -- show   



        N_0x4cc5f2fc1332577f(-66088566) -- hide mpmoney
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 0xBB47198C) --disables reticle
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 1058184710) --remove skill cards
        Citizen.InvokeNative(0x4CC5F2FC1332577F, -66088566) --removed money
        N_0x50c803a4cd5932c5(false)
        N_0xd4ee21b7cc7fd350(false)
        Citizen.InvokeNative(0x50C803A4CD5932C5, true)
        Citizen.InvokeNative(0xD4EE21B7CC7FD350, true)
        cAPI.Temperatura()
        DisplayRadar(true)
    end
end)

RegisterCommand('cans', function(source,args)

    Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, 0.5, true) -- cançaso 
    Citizen.InvokeNative(0xF0FE8E790BFEB5BB , PlayerPedId(), 0, 0.2, false)

    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 2, 100)
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, 100)
   print(Citizen.InvokeNative(IsDeadeyeAbilityLocked,PlayerPedId()))
    Wait(100)
   -- print(GetAttributeCoreValue(PlayerPedId, 2))
end)


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