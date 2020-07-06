
local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local blip 

RegisterNetEvent('TREASURE:create')
AddEventHandler('TREASURE:create', function(x,y,z)
	TriggerEvent('VP:NOTIFY:Simple', 'Há um tesouro perdido no mapa, procure pela mancha vermelha.', 10000)
	blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 693035517, x, y, z, 150.0)	
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Tesouro Perdido')		
end)

RegisterNetEvent('TREASURE:createPedDefender')
AddEventHandler('TREASURE:createPedDefender', function(x,y,z, animal, qtd)
	local pedModelHash = GetHashKey(animal)
	
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

	for i = 1, qtd do
		local ped = CreatePed(pedModelHash, x+2, y, z, GetEntityHeading(PlayerPedId()), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
		Citizen.InvokeNative(0xE054346CA3A0F315, ped, x, y, z, 10, 0, 0)
		ClearPedSecondaryTask(ped)
		SetEntityAsMissionEntity(ped)
		SetRelationshipBetweenGroups(5, ped, `PLAYER`)
		SetPedOutfitPreset(ped, math.random(1,5))
	end

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

