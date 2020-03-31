
local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


trainHash = -2006657222
CURRENT_TRAIN = nil
train = nil



--     -1464742217, trem 3 pass
--     -577630801, TREM CARCA E PASS 1 
--     -1901305252, -- TREM CARGAS VAZIA
--     519580241, -- TREM DE CARGA
--     -1083616881, -- train metade transporte / carga
--     1030903581,  -- train metade transporte / carga
--     -2006657222, -- trem grande metade carga / metade pass
--     1285344034, -- TREM 6 PASS
--     987516329, -- somente passageiro
--     -651487570, -- 2 carga 2 pass
--     -593637311, -- 2 pass pequeno

--     1094934838, -- carga e pass grande



--     1054492269, -- trem de duas pessoas
--     1216031719, -- trem de carga usado


local stops = {
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -4343.20,  ["y"] = -3084.541,   ["z"] = -9.895, ["time"] = 3000, ["name"] = "Mercer Station"},
    {["dst"] = 400.0, ["dst2"] = 4.0, ["x"] = -3749.27,  ["y"] = -2617.67, ["z"] = -13.760,  ["time"] = 6000, ["name"] = "Armadillo Station"},
   -- {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = -2497.32,  ["y"] = -2437.034, ["z"] = 60.199,  ["time"] = 60000, ["name"] = "Macfarlane's Ranch Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = -1871.85,  ["y"] = -2314.516,  ["z"] = 52.093,  ["time"] = 3000, ["name"] = "Stillwater Creek Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = -2497.32,  ["y"] = -2437.034, ["z"] = 60.199,  ["time"] = 6000, ["name"] = "Macfarlane's Ranch Station"},
    {["dst"] = 400.0, ["dst2"] = 4.0, ["x"] = -3749.27,  ["y"] = -2617.67, ["z"] = -13.760,  ["time"] = 6000, ["name"] = "Armadillo Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -4343.20,  ["y"] = -3084.541,   ["z"] = -9.895, ["time"] = 3000, ["name"] = "Mercer Station"},   
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -5235.58, ["y"] = -3467.379,  ["z"] = -21.258,  ["time"] = 3000, ["name"] = "Riggs Station"},

} 




Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(1000)
        local game = NetworkIsGameInProgress()
        if game == 1 then
            TriggerServerEvent('train:playerActivated')
            return
        end
    end
end)





function SWITCHTRACK(bool)
    local param1
    local param2
    print(bool)
	if bool == 1 then	
		N_0x2a7413168f6cd5a8()
		local param1 = 1
		while param1 <= 4 do
			if N_0xc29996a337bdd099(param2) then			
                N_0xf8f7da13cfbd4532(param2, 0)    
                print('1')
            end	
            Citizen.Wait(10)
		end	
	else	
		local param2 = 1
		while param2 <= 4 do		
			if N_0xc29996a337bdd099(param2) then			
            N_0xf8f7da13cfbd4532(param2 ,0)
                print('2')
            end		
            N_0x4c05b42a8d937796()
            N_0x16b86a49e072aa85()
            Citizen.Wait(10)
        end
    end

end


RegisterNetEvent('FRP:Trainroute')
AddEventHandler('FRP:Trainroute', function(n)
    DeleteAllTrains()
    SetRandomTrains(false) 

    local trainWagons = N_0x635423d55ca84fc8(trainHash)

    for wagonIndex = 0, trainWagons - 1 do
        local trainWagonModel = N_0x8df5f6a19f99f0d5(trainHash, wagonIndex)
        while not HasModelLoaded(trainWagonModel) do
            Citizen.InvokeNative(0xFA28FE3A6246FC30,trainWagonModel,1)
            Citizen.Wait(100)
        end
    end

    --spawn--
    local ped = PlayerPedId()
    local train = N_0xc239dbd9a57d2a71(trainHash, -1951.7194824219,-2605.0729980469,67.672920227051, 1, 1, 1, 1)
    local coords = GetEntityCoords(train)
    local trainV = vector3(coords.x, coords.y, coords.z)
  --  Citizen.InvokeNative(0xBA8818212633500A, train, 0, 1) -- this makes the train undrivable for players         
    --blip--
    local blipname = "Trem Roubavel"
    local bliphash = -399496385
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
    SetBlipScale(blip, 1.5)
    trainspawned = true
    CURRENT_TRAIN = train
 --   SetMissionTrainCoords(CURRENT_TRAIN, -5236.0234375,-3490.9416503906,-21.104068756104 )

    local cruisespeed = 0.0
    SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)



    Wait(60000)
    
    local cruisespeed = 15.0
    SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
    Citizen.InvokeNative(0xF8F7DA13CFBD4532, CURRENT_TRAIN, 0)
    --trainroute()
end)



-- function trainroute()
--     while trainspawned == true do
--         for i = 1, #stops do
--             local coords = GetEntityCoords(CURRENT_TRAIN)
--             local trainV = vector3(coords.x, coords.y, coords.z)
--             local distance = #(vector3(stops[i]["x"], stops[i]["y"], stops[i]["z"]) - trainV)
    
--             --speed--
--             local stopspeed = 0.0
--             local cruisespeed = 20.0
--             local fullspeed = 60.0
--             if distance < stops[i]["dst"] then
--                 SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
--                 Wait(200)
--                 if distance < stops[i]["dst2"] then
--                     SetTrainCruiseSpeed(CURRENT_TRAIN, stopspeed)
--                     Wait(stops[i]["time"])
--                     SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
--                     Wait(10000)
--                 end
--             elseif distance > stops[i]["dst"] then
--                 SetTrainCruiseSpeed(CURRENT_TRAIN, fullspeed)
--                 Wait(25)
--             end
--         end
--     end
-- end

RegisterNetEvent('TRAIN:create')
AddEventHandler('TRAIN:create', function()
	TriggerEvent('Distress', 'sucesso', 'Um trem carregado de materias está no mapa.')	
end)

RegisterCommand('deletartrain', function()
    DeleteEntity(CURRENT_TRAIN)
end)

RegisterCommand('change', function(source,args)
    TriggerEvent('TRAIN:createPedDefender')
end)


RegisterCommand('road', function(source,args)
   print(GetTrainCurrentTrackNode(CURRENT_TRAIN))
end)

local seguranca = GetHashKey("S_M_M_UniTrainGuards_01")

RegisterNetEvent('TRAIN:createPedDefender')
AddEventHandler('TRAIN:createPedDefender', function()
    print('vapo')

    print(-1947.3331298828,-2605.48828125,68.722503662109)
   -- carrosinfo(carros_spw)
    --setupModelo(seguranca)
    local seguranca_spw = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4, 1, 0)
    local seguranca_spw_2 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_3 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_4 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_5 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_6 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_7 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_8 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_9 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,   1, 0)
    local seguranca_spw_10 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    SetEntityAsMissionEntity(seguranca_spw, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_2, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_3, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_4, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_5, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_6, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_7, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_8, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_9, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_10, 0, 0) 
    guardasinfo(seguranca_spw)
    guardasinfo(seguranca_spw_2)
    guardasinfo(seguranca_spw_3)
    guardasinfo(seguranca_spw_4)
    guardasinfo(seguranca_spw_5)
    guardasinfo(seguranca_spw_6)
    guardasinfo(seguranca_spw_7)
    guardasinfo(seguranca_spw_8)
    guardasinfo(seguranca_spw_9)
    guardasinfo(seguranca_spw_10)
end)


function setupModelo(modelo)
    RequestModel(modelo)
    while not HasModelLoaded(modelo) do
      RequestModel(modelo)
      Wait(50)
    end
    SetModelAsNoLongerNeeded(modelo)
  end

function guardasinfo(inputPed)
    SetPedShootRate(inputPed,  700)
    --AddArmourToPed(inputPed, GetPlayerMaxArmour(seguranca_spw)- GetPedArmour(seguranca_spw))
   -- SetPedAlertness(inputPed, 3)
   	Citizen.InvokeNative(0x283978A15512B2FE, inputPed, true)
	Citizen.InvokeNative(0x58A850EAEE20FAA3, inputPed)
    SetPedAccuracy(inputPed, 81)
    SetEntityHealth(inputPed,  200)
    SetPedFleeAttributes(inputPed, false, true)
    SetPedCombatAttributes(inputPed, 46, true)
    SetPedCombatAttributes(inputPed, 0, true)
    SetPedCombatAttributes(inputPed, 2, true)
    SetPedCombatAttributes(inputPed, 52, true)
    SetPedCombatAbility(inputPed,  2)
    SetPedCombatRange(inputPed, 2)
    SetPedPathAvoidFire(inputPed,  0)
    SetPedPathCanUseLadders(inputPed,1)
    SetPedPathCanDropFromHeight(inputPed, 1)
    SetPedPathPreferToAvoidWater(inputPed, 1)
    --SetPedGeneratesDeadBodyEvents(inputPed, 1)
   -- GiveWeaponToPed(inputPed, GetHashKey("WEAPON_COMBATPISTOL"), 5000, false, true)
    --GiveWeaponToPed(inputPed, GetHashKey("WEAPON_SMG"), 5000, false, true)
    SetPedRelationshipGroupHash(inputPed, GetHashKey("security_guard"))
  end

RegisterNetEvent('TRAIN:killblip')
AddEventHandler('TRAIN:killblip', function()
	RemoveBlip(blip)
end)
