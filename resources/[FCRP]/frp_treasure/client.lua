
local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9, ["J"] = 0xF3830D8E }

local chest_id = 'e.' .. math.random(9999)
local chest_owner_id = 0 -- Não tem dono, então o id é 0, irrelevante
local chest_position = {x,y,z}
local chest_type = 0 -- Global, os items são sempre os mesmos
local chest_capacity = 20 -- Capacidade maxima de peso
local chest_group = nil -- Grupo necessaria para abrir o baú(nenhum)

local inventory_id = nil
local inventory_capacity = 20 -- A mesma que a de cima
local inventory_items = {
    ['consumable_apple'] = 5,
	['weapon_bow'] = 10,
	['generic_money'] = 500,
}
local time = GetGameTimer() - 500


Citizen.CreateThread(function()
	if time > 1 then
		local Chest = API.getChestFromChestId(chest_id)
		coords = GetEntityCoords(PlayerPedId())
		print(coords.x+20,coords.y,coords.z)
		chest_position = {coords.x,coords.y,coords.z}
		local chest_Inventory = API.Inventory(inventory_id, inventory_capacity, inventory_items)
		local Chest = API.Chest(chest_id, chest_owner_id, chest_position, chest_type, chest_capacity, chest_Inventory, chest_group)
		Chest:cache() -- Se torna disponivel para sync com os clients
		myEventChests = {}
		myEventChests[chestId] = true	
	end	
end)


function bliptreasure(x,y,z)
		RemoveBlip()
		local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, coords.x, coords.y, coords.z, 50.0)
	--	local blip = Citizen.InvokeNative(0x554d9d53f696d002, blipType, x, y, z)		
     	Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Tesouro Perdido')
end)
