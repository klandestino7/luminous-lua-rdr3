
local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('TREASURE:create')
AddEventHandler('TREASURE:create', function(x,y,z)
	TriggerEvent('Distress', 'sucesso', 'Há um tesouro perdido no mapa, procure pela mancha vermelha.')
	local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 693035517, x, y, z, 100.0)	
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Tesouro Perdido')		
end)

RegisterNetEvent('TREASURE:createPedDefender')
AddEventHandler('TREASURE:createPedDefender', function(x,y,z)
	local pedModelHash = GetHashKey('A_C_Wolf_Medium')
	local pedModelHash2 = GetHashKey('A_C_Wolf')
	
	if not HasModelLoaded(pedModelHash) then
		RequestModel(pedModelHash)
		while not HasModelLoaded(pedModelHash) do
			Citizen.Wait(10)
		end
	end
	if not HasModelLoaded(pedModelHash2) then
		RequestModel(pedModelHash2)
		while not HasModelLoaded(pedModelHash2) do
			Citizen.Wait(10)
		end
	end
	
	local ped1 = CreatePed(pedModelHash, x+2, y, z, GetEntityHeading(PlayerPedId()), 1, 0)
	Citizen.InvokeNative(0x283978A15512B2FE, ped1, true)
	Citizen.InvokeNative(0x58A850EAEE20FAA3, ped1)
	Citizen.InvokeNative(0xE054346CA3A0F315, ped1, x, y, z, 10, 0, 0)
    ClearPedSecondaryTask(ped1)
	SetEntityAsMissionEntity(ped1)
	SetRelationshipBetweenGroups(5, ped1, `PLAYER`)

	local ped2 = CreatePed(pedModelHash, x,y+1,z, GetEntityHeading(PlayerPedId()), 1, 0)
	Citizen.InvokeNative(0x283978A15512B2FE, ped2, true)
	Citizen.InvokeNative(0x58A850EAEE20FAA3, ped2)
	Citizen.InvokeNative(0xE054346CA3A0F315, ped2, x, y, z, 10, 0, 0)
	ClearPedSecondaryTask(ped2)
	SetEntityAsMissionEntity(ped2)
	SetRelationshipBetweenGroups(5, ped2, `PLAYER`)

	local ped3 = CreatePed(pedModelHash2, x-2,y ,z, GetEntityHeading(PlayerPedId()), 1, 0)
	Citizen.InvokeNative(0x283978A15512B2FE, ped3, true)
	Citizen.InvokeNative(0x58A850EAEE20FAA3, ped3)
	Citizen.InvokeNative(0xE054346CA3A0F315, ped3, x, y, z, 10, 0, 0)
    ClearPedSecondaryTask(ped3)
	SetEntityAsMissionEntity(ped3)
	SetRelationshipBetweenGroups(5, ped3, `PLAYER`)
	
	local ped4 = CreatePed(pedModelHash2, x-2.5,y ,z, GetEntityHeading(PlayerPedId()), 1, 0)
	Citizen.InvokeNative(0x283978A15512B2FE, ped4, true)
	Citizen.InvokeNative(0x58A850EAEE20FAA3, ped4)
	Citizen.InvokeNative(0xE054346CA3A0F315, ped4, x, y, z, 10, 0, 0)
    ClearPedSecondaryTask(ped4)
	SetEntityAsMissionEntity(ped4)
	SetRelationshipBetweenGroups(5, ped4, `PLAYER`)
end)

RegisterNetEvent('TREASURE:killblip')
AddEventHandler('TREASURE:killblip', function()
	RemoveBlip(blip)
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
		local game = NetworkIsGameInProgress()
		if game == 1 then
			TriggerServerEvent('TREASURE:playerActivated')
			return
		end
    end
end)

