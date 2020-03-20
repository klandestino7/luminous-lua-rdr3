local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('fc_heal:heallife')
AddEventHandler('fc_heal:heallife', function(price)

    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

	if Inventory:getItemAmount('generic_money') < price then
        User:notify('Dinheiro insuficiente!')
        return
	end
	User:notify('Você foi curado, pagou ~pa~' .. price ..'$')
	Inventory:removeItem('generic_money', price)
	TriggerClientEvent('heal:player', _source)	


end)