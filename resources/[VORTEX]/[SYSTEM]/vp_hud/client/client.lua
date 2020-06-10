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
       -- Citizen.InvokeNative(0x8BC7C1F929D07BF3, 0xBB47198C) --enables reticle

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


Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            for _, i in pairs(GetActivePlayers()) do
                local ped = GetPlayerPed(i)
                if ped ~= 0 then
                    SetPedPromptName(ped, 'Desconhecido')
                end
            end
        end
    end
)

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



Citizen.CreateThread(
    function()
        local StateName
        while true do
            Citizen.Wait(0)
            local CurrentStateName = GetCurrentStateName()            
            if CurrentStateName ~= StateName then         
                local RegionName = GetCurrentRegionName()
                DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.20, 0.15, 0.8, 0, 0, 0, 250, 1)
                DrawTxt(RegionName, 0.50, 0.04, 0.8, 0.8, true, 255, 255, 255, 255, true)
                DrawTxt(StateName, 0.50, 0.095, 0.4, 0.4, true, 255, 255, 255, 255, true)
                StateName = CurrentStateName 
                Citizen.Wait(5000)
            end
        end
    end
)




function GetCurrentStateName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)

    if town_hash == GetHashKey("bigvalley") then
        return "LANDMARK_VALLEY_VIEW"
    elseif town_hash == GetHashKey("Cumberland") then
        return "LANDMARK_CUMBERLAND_FALLS"
    elseif town_hash == GetHashKey("GaptoothRidge") then
        return "HIDEOUT_GAPTOOTH_BREACH"
    elseif town_hash == GetHashKey("roanoke") then
        return "LANDMARK_ROANOKE_VALLEY"
    elseif town_hash == GetHashKey("Annesburg") then
        return "TOWN_ANNESBURG"
    elseif town_hash == GetHashKey("Armadillo") then
        return "TOWN_ARMADILLO"
    elseif town_hash == GetHashKey("Blackwater") then
        return "TOWN_BLACKWATER"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "SETTLEMENT_BEECHERS_HOPE"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "SETTLEMENT_BRAITHWAITE_MANOR"
    elseif town_hash == GetHashKey("Butcher") then
        return "SETTLEMENT_BUTCHER_CREEK"
    elseif town_hash == GetHashKey("Caliga") then
        return "SETTLEMENT_CALIGA_HALL"
    elseif town_hash == GetHashKey("cornwall") then
        return "SETTLEMENT_CORNWALL_KEROSENE_TAR"
    elseif town_hash == GetHashKey("Emerald") then
        return "SETTLEMENT_EMERALD_RANCH"
    elseif town_hash == GetHashKey("lagras") then
        return "SETTLEMENT_LAGRAS"
    elseif town_hash == GetHashKey("Manzanita") then
        return "SETTLEMENT_MANZANITA_POST"
    elseif town_hash == GetHashKey("Rhodes") then
        return "TOWN_RHODES"
    elseif town_hash == GetHashKey("StDenis") then
        return "TOWN_SAINTDENIS"
    elseif town_hash == GetHashKey("Strawberry") then
        return "TOWN_STRAWBERRY"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "TOWN_TUMBLEWEED"
    elseif town_hash == GetHashKey("valentine") then 
        return "TOWN_VALENTINE"
    elseif town_hash == GetHashKey("VANHORN") then
        return "TOWN_VANHORN"
    elseif town_hash == GetHashKey("Wallace") then
        return "LANDMARK_WALLACE_STATION"
    elseif town_hash == GetHashKey("wapiti") then
        return "SETTLEMENT_WAPITI"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "SETTLEMENT_AGUASDULCES"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "SETTLEMENT_AGUASDULCES"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "SETTLEMENT_AGUASDULCES"
    elseif town_hash == GetHashKey("Manicato") then
        return "TOWN_MANICATO"
    elseif town_hash == false then
        return "Cidade Desconhecida"
    end
end









--[[
LANDMARK_MACOMBS_END
LANDMARK_HAGEN_ORCHARDS
LANDMARK_VALLEY_VIEW

LANDMARK_MONTOS_REST
LANDMARK_OWANJILA_DAM
LANDMARK_SILTWATER_STRAND
LANDMARK_BERYLS_DREAM
LANDMARK_RIGGS_STATION
LANDMARK_CANEBREAK_MANOR
LANDMARK_COPPERHEAD_LANDING
LANDMARK_RILEYS_CHARGE
LANDMARK_BACCHUS_BRIDGE
LANDMARK_MERKINS_WALLER
LANDMARK_WINDOW_ROCK
LANDMARK_MILLESANI_CLAIM
LANDMARK_TEMPEST_RIM
LANDMARK_THE_LOFT
LANDMARK_QUAKERS_COVE
LANDMARK_CALUMET_RAVINE
LANDMARK_EWING_BASIN

SETTLEMENT_GRAND_KORRIGAN
SETTLEMENT_APPLESEED_TIMBER_CO
SETTLEMENT_PRONGHORN_RANCH
SETTLEMENT_FORT_RIGGS_HOLDING_CAMP
SETTLEMENT_SISIKA_PENITENTIARY
SETTLEMENT_COOTS_CHAPEL
SETTLEMENT_RIDGEWOOD_FARM
SETTLEMENT_FORT_WALLACE
SETTLEMENT_RATHSKELLER_FORK






SETTLEMENT_PLAINVIEW

SETTLEMENT_CENTRAL_UNION_RAILROAD_CAMP
SETTLEMENT_THIEVES_LANDING



SETTLEMENT_BENEDICT_POINT

HOMESTEAD_DOVERHILL
HOMESTEAD_MACLEANS_HOUSE
HOMESTEAD_LONE_MULE_STEAD
HOMESTEAD_PAINTED_SKY
HOMESTEAD_SHEPHERDS_RISE
HOMESTEAD_WATSONS_CABIN
HOMESTEAD_FIRWOOD_RISE
HOMESTEAD_CHEZ_PORTER
HOMESTEAD_ADLER_RANCH
HOMESTEAD_GUTHRIE_FARM
HOMESTEAD_CARMODY_DELL
HOMESTEAD_LARNED_SOD
HOMESTEAD_ABERDEEN_PIG_FARM
HOMESTEAD_DOWNES_RANCH
HOMESTEAD_COMPSONS_STEAD
HOMESTEAD_HILL_HAVEN_RANCH
HOMESTEAD_LONNIES_SHACK
HOMESTEAD_CATFISH_JACKSONS
HOMESTEAD_WILLARDS_REST





TOWN_MACFARLANES_RANCH
TOWN_ANNESBURG


TOWN_SAINTDENIS

TOWN_TUMBLEWEED

LANDMARK_MOSSY_FLATS
LANDMARK_ROANOKE_VALLEY
LANDMARK_GRANGERS_HOGGERY
LANDMARK_LUCKYS_CABIN
LANDMARK_FLATNECK_STATION

LANDMARK_OLD_GREENBANK_MILL
LANDMARK_CINCO_TORRES
LANDMARK_LA_CAPILLA
LANDMARK_RADLEYS_PASTURE
LANDMARK_BEAR_CLAW
LANDMARK_PACIFIC_UNION_RAILROAD
LANDMARK_TANNERS_REACH
LANDMARK_BLACK_BALSAM_RISE
LANDMARK_BRANDYWINE_DROP
LANDMARK_BOLGER_GLADE

HIDEOUT_HANGING_DOG_RANCH
HIDEOUT_SHADY_BELLE
HIDEOUT_TWIN_ROCKS
HIDEOUT_SIX_POINT_CABIN

HIDEOUT_LAKAY
HIDEOUT_COLTER
HIDEOUT_BEAVER_HOLLOW
HIDEOUT_FORT_MERCER
HIDEOUT_CLEMENS_POINT ]]





function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
	local str = CreateVarString(10, 'REGION_BOUNTY', str)
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
