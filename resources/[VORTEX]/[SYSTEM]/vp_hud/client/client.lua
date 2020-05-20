local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")


local Cinematic = false


RegisterCommand('horsecl', function()

    local playerHorse = cAPI.GetPlayerHorse()
    -- playerHorse = 228907
    local p = PlayerId()

    Citizen.InvokeNative(0xD2CB0FB0FDCB473D, p, 0)

    local z = Citizen.InvokeNative(0x8FBF9EDB378CCB8C, p, playerHorse)
    local w = Citizen.InvokeNative(0x227B06324234FB09, p, playerHorse)

    local main_horse = Citizen.InvokeNative(0x46FA0AE18F4C7FA9, p)
    local temp_horse = Citizen.InvokeNative(0xD3F7445CEA2E5035, p)
    Citizen.InvokeNative(0x75415EE0CB583760, playerHorse, 7, 950)

    print(cAPI.GetPlayerHorse(), playerHorse, main_horse, temp_horse, DoesEntityExist(playerHorse))

end)


Citizen.CreateThread(
    function()
        -- ESCONDER E MOSTRAR ALGUMAS HUDS
       Citizen.InvokeNative(0x4CC5F2FC1332577F, 1058184710) --remove skill cards
       Citizen.InvokeNative(0x4CC5F2FC1332577F, -66088566) --removed money
        N_0x4cc5f2fc1332577f(2106452847) -- remove wheell itens
    
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 0xBB47198C) --disables reticle
        Citizen.InvokeNative(0x8BC7C1F929D07BF3, 0xBB47198C) --enables reticle

        while true do
            Citizen.Wait(0)
                  
            if Cinematic then
                N_0x69d65e89ffd72313(true)
            else
                N_0x69d65e89ffd72313(false)
            end

            if IsPedOnMount(PlayerPedId()) then
                N_0x8bc7c1f929d07bf3(474191950)
            --   ShowPlayerCores(false) -- player core
                Citizen.InvokeNative(0xD4EE21B7CC7FD350, false) -- horse core
            else
            --    ShowPlayerCores(false) -- player core
             ----   Citizen.InvokeNative(0xD4EE21B7CC7FD350, false) -- horse core
                N_0x4cc5f2fc1332577f(474191950)
            end

            --N_0xbae08f00021bffb2(horse) -- agitates the horse
         -- N_0x8bc7c1f929d07bf3(2106452847) -- show
 
        --    N_0x50c803a4cd5932c5(false)
       --     N_0xd4ee21b7cc7fd350(false)
        --    Citizen.InvokeNative(0x50C803A4CD5932C5, true)
        --    Citizen.InvokeNative(0xD4EE21B7CC7FD350, true)
            
            Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true)
            DisplayRadar(true)
            DisplayHud(true)
           -- Citizen.InvokeNative(0xC65A45D4453C2627, 704572841, "HUD_PAGE_RADAR", 1, 1, 0, 1)
        end
    end
)

--[[
["1"] = 0xE6F612E4,
["2"] = 0x1CE6D9EB,
["3"] = 0x4F49CC4C,
["4"] = 0x8F9F9E58,
["5"] = 0xAB62E997,
["6"] = 0xA1FDE2A6,
["7"] = 0xB03A913B,
["8"] = 0x42385422,

    ["F1"] = 0xA8E3F467,
    ["F4"] = 0x1F6D95E5,
    ["F6"] = 0x3C0A40F2,
]]

Citizen.CreateThread(
    function()
        while true do            
            Citizen.Wait(0)
           -- print(GetHashKey('INPUT_SELECT_NEXT_WHEEL'))
            EnableControlAction(0, GetHashKey('INPUT_SELECT_WEAPON_HANDGUN'), true)
            EnableControlAction(0, GetHashKey('INPUT_SELECT_WEAPON_AUTO_RIFLE'), true)
            EnableControlAction(0, 0x3C0A40F2, true)

            EnableControlAction(1, GetHashKey('INPUT_SELECT_WEAPON_HANDGUN'), true)
            EnableControlAction(1, GetHashKey('INPUT_SELECT_WEAPON_AUTO_RIFLE'), true)
            EnableControlAction(1, 0x3C0A40F2, true)

            EnableControlAction(2, GetHashKey('INPUT_SELECT_WEAPON_HANDGUN'), true)
            EnableControlAction(2, GetHashKey('INPUT_SELECT_WEAPON_AUTO_RIFLE'), true)
            EnableControlAction(2, 0x3C0A40F2, true)

            if IsControlJustPressed(0, GetHashKey('INPUT_SELECT_WEAPON_HANDGUN')) then
                print('1')
            end
            if IsControlJustPressed(1, GetHashKey('INPUT_SELECT_WEAPON_HANDGUN')) then
                print('2')
            end
            if IsControlJustPressed(2, GetHashKey('INPUT_SELECT_WEAPON_HANDGUN')) then
                print('3')
            end

            if IsControlJustPressed(0, GetHashKey('INPUT_SELECT_WEAPON_AUTO_RIFLE')) then
                print('1')
            end
            if IsControlJustPressed(1, GetHashKey('INPUT_SELECT_WEAPON_AUTO_RIFLE')) then
                print('2')
            end
            if IsControlJustPressed(2, GetHashKey('INPUT_SELECT_WEAPON_AUTO_RIFLE')) then
                print('3')
            end

            if IsControlJustPressed(0, 0x3C0A40F2) then
                print('1')
            end
            if IsControlJustPressed(1, 0x3C0A40F2) then
                print('2')
            end
            if IsControlJustPressed(2, 0x3C0A40F2) then
                print('3')
            end
        end
end)

RegisterCommand(
    "testb",
    function(source, args)
        local a = Citizen.InvokeNative(0x935A30AA88FB1014, PlayerPedId(), Citizen.ResultAsVector())
        local b = Citizen.InvokeNative(0x6BFBDC46139C45AB, GetEntityCoords(PlayerPedId()))
        print(a,b)
    end
)


RegisterCommand(
    "cinema",
    function(source, args)
        if args[1] == '1' then
            Cinematic = true
        elseif args[1] == "2" then
            print('foi')
            Cinematic = false
        end
    end
)

RegisterNetEvent("VP:HUD:RevealMap")
AddEventHandler(
    "VP:HUD:RevealMap",
    function(toggle)
        if toggle == nil then
            SetMinimapHideFow(false)
        else
            Citizen.InvokeNative(0xEB3CB3386C775D72, 0)
            Citizen.InvokeNative(0x63E7279D04160477, toggle, 0)         
            Citizen.InvokeNative(0xF8096DF9B87246E3, toggle)
          --  RevealMinimapFow(toggle)
        end
    end
)

RegisterCommand(
    "cans",
    function(source, args)

        Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, 1.0, true) -- bost        

      --  Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)

        Citizen.InvokeNative(0xF0FE8E790BFEB5BB, PlayerPedId(), 5)

   --     Citizen.InvokeNative(IsDeadeyeAbilityLocked, PlayerPedId())

        Wait(100)
        
        SetDeadeyeAbilityLocked(PlayerPedId(), 0, false)

        print(GetAttributeCoreValue(PlayerPedId(), 2))

    end
)


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

RegisterNetEvent("EveryoneTeleportEntity")
AddEventHandler(
    "EveryoneTeleportEntity",
    function(netid, x, y, z)
        ent = NetworkGetEntityFromNetworkId(netid)
        Wait(150)
        SetEntityCoords(ent, x, y, z)
    end
)
