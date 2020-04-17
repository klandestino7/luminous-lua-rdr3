local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')
API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('FRP:STORECLOTHES:checkmoney')
AddEventHandler('FRP:STORECLOTHES:checkmoney', function(price)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

	if Inventory:getItemAmount('money') < 200 then
        User:notify('Dinheiro insuficiente!')
        return
	end
	TriggerClientEvent('FRP:STORECLOTHES:open', _source)	
end)



RegisterServerEvent('FRP:STORECLOTHES:buy')
AddEventHandler('FRP:STORECLOTHES:buy', function(price)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

	if Inventory:getItemAmount('money') < price*100 then
        User:notify('Dinheiro insuficiente!')
        return
	end
	User:notify('Você pagou ~pa~' .. price*100 ..'$')

	Inventory:removeItem('money', price*100)

end)


