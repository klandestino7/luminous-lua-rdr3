local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:MEDIC:checkjob')
AddEventHandler('FRP:MEDIC:checkjob', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local job = Character:hasGroup('medic')	
	local Inventory = User:getCharacter():getInventory()

	if job then
		TriggerClientEvent('FRP:MEDIC:revivecheck', _source)
		User:addXp(10)
		Inventory:addItem('money', 5)
	else
		TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um médico')
	end

end)

RegisterServerEvent('FRP:MEDIC:revivecallback')
AddEventHandler('FRP:MEDIC:revivecallback', function(target)
	--TriggerClientEvent('FRP:MEDIC:revive', target)
	TriggerClientEvent('FRP:RESPAWN:revive', target)
end)


RegisterServerEvent('FRP:MEDIC:revive2')
AddEventHandler('FRP:MEDIC:revive2', function(target)
	TriggerClientEvent('FRP:MEDIC:revive2', target)
end)