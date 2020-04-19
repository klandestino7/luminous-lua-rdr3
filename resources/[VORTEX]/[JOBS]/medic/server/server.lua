local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('VP:MEDIC:checkjob')
AddEventHandler('VP:MEDIC:checkjob', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local job = Character:hasGroup('medic')	
	local Inventory = User:getCharacter():getInventory()

	if job then
		TriggerClientEvent('VP:MEDIC:revivecheck', _source)
		User:addXp(10)
		Inventory:addItem('money', 5)
	else
		TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um médico')
	end

end)

RegisterServerEvent('VP:MEDIC:revivecallback')
AddEventHandler('VP:MEDIC:revivecallback', function(target)
	--TriggerClientEvent('VP:MEDIC:revive', target)
	TriggerClientEvent('VP:RESPAWN:revive', target)
end)


RegisterServerEvent('VP:MEDIC:revive2')
AddEventHandler('VP:MEDIC:revive2', function(target)
	TriggerClientEvent('VP:MEDIC:revive2', target)
end)