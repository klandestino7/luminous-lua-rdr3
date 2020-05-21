local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local ReviveEnable = false
local target = nil

RegisterCommand(
    "checar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local Inventory = User:getCharacter():getInventory()

        if medic then
			TriggerClientEvent('VP:MEDIC:checkdeath', _source)
			ReviveEnable = false
		end
    end
)

RegisterCommand(
    "reanimar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local Inventory = User:getCharacter():getInventory()

		if medic then
			if ReviveEnable then
				TriggerClientEvent('VP:MEDIC:revivecheck', _source)
			end
		end
    end
)

RegisterCommand(
    "tratar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local Inventory = User:getCharacter():getInventory()

		if medic then
			TriggerClientEvent('VP:MEDIC:TreatmentCheck', _source)
		end
    end
)

RegisterServerEvent('VP:MEDIC:checkcallback')
AddEventHandler('VP:MEDIC:checkcallback', function(target)
	TriggerClientEvent('VP:RESPAWN:CheckDeath', target)
end)

RegisterServerEvent('VP:MEDIC:TreatmentCallback')
AddEventHandler('VP:MEDIC:TreatmentCallback', function(target)
	TriggerClientEvent('VP:RESPAWN:Treatment', target)
end)

RegisterServerEvent('VP:MEDIC:revivecallback')
AddEventHandler('VP:MEDIC:revivecallback', function(target)
	TriggerClientEvent('VP:RESPAWN:revive', target)
end)

RegisterServerEvent('VP:MEDIC:StatusDeath')
AddEventHandler('VP:MEDIC:StatusDeath', function(target, data)
	TriggerEvent('VP:MEDIC:ReceiveStatus', target, data)
end)

RegisterServerEvent('VP:MEDIC:ReceiveStatus')
AddEventHandler('VP:MEDIC:ReceiveStatus', function(target, data)
	local sort = math.random(1,5)
	if data.InstaDeath ~= nil then
		if data.InstaDeath then
			if sort == 1 then
				ReviveEnable = true			
				print('Com sorte o médico realizou operação com sucesso.')
				-- função de reviver 
			else
				ReviveEnable = false			
				print('este player está sem batimentos.')
				-- animação de reviver 
				return
			end
		else
			print('O médico realizou operação com sucesso.')
			ReviveEnable = true	
		end
	else
		print('não identificado. CombatLog')
		ReviveEnable = false
	end
	
	--TriggerClientEvent('VP:MEDIC:ReceiveStatus', target, data)

end)


RegisterServerEvent('VP:MEDIC:revive')
AddEventHandler('VP:MEDIC:revive', function(target)	
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()
	local Inventory = User:getCharacter():getInventory()

	if ReviveEnable then
		TriggerClientEvent('VP:MEDIC:revive', _source)
		Wait(10000)
		TriggerClientEvent('VP:RESPAWN:PlayerUp', target)
		User:addXp(10)
		Inventory:addItem('money', 5)	
		print('Reanimado com sucesso.')
	else
		TriggerClientEvent('VP:MEDIC:revive', _source)
		Wait(10000)
		TriggerClientEvent('VP:RESPAWN:PlayerUp', target)
		print('Infelizmente faleceu.')
	end
end)



