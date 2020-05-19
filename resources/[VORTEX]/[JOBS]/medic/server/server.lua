local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterCommand(
    "reviver",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local Inventory = User:getCharacter():getInventory()

        if medic then
			TriggerClientEvent('VP:MEDIC:revivecheck', _source)
		end
    end
)

RegisterServerEvent('VP:MEDIC:revivecallback')
AddEventHandler('VP:MEDIC:revivecallback', function(target)
	print(target)

	TriggerClientEvent('VP:RESPAWN:CheckDeath', target)

	--TriggerClientEvent('VP:MEDIC:revive', target)
	--TriggerClientEvent('VP:RESPAWN:revive', target)
end)


RegisterServerEvent('VP:MEDIC:StatusDeath')
AddEventHandler('VP:MEDIC:StatusDeath', function(target, data)
	print(target, data)
	if data.InstaDeath ~= nil then
		print(data.InstaDeath)
	end

	if data.deathCause ~= nil then
		print(data.deathCause)
	end

	if data.BodyPartDamage ~= nil then
		print(data.BodyPartDamage)
	end
	TriggerEvent('VP:MEDIC:ReceiveStatus', target, data)

end)


RegisterServerEvent('VP:MEDIC:ReceiveStatus')
AddEventHandler('VP:MEDIC:ReceiveStatus', function(target, data)
	print('chegou', json.encode(data))

	if data.InstaDeath ~= nil then
		print(data.InstaDeath)
	end

	if data.deathCause ~= nil then
		print(data.deathCause)
	end

	if data.BodyPartDamage ~= nil then
		print(data.BodyPartDamage)
	end

	TriggerClientEvent('VP:MEDIC:ReceiveStatus', target, data)
end)


RegisterServerEvent('VP:MEDIC:revive')
AddEventHandler('VP:MEDIC:revive', function(target)
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()
	local Inventory = User:getCharacter():getInventory()

	User:addXp(10)
	Inventory:addItem('money', 5)

	TriggerClientEvent('VP:RESPAWN:revive', target)		
end)


