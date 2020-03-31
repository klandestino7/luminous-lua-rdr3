local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


RegisterServerEvent('bberry:buyvehicle')
AddEventHandler('bberry:buyvehicle', function(price, vehicle, level)
    local _vehicle = vehicle
    local _level = level

    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    local Character = User:getCharacter()

    if Inventory:getItemAmount('generic_money') < tonumber(price*100) then
        print(Inventory:getItemAmount('generic_money'))
        User:notify('Dinheiro insuficiente!')
        TriggerClientEvent('Message:cancel', source)
        return
    end
    Inventory:removeItem('generic_money', tonumber(price*100))
    TriggerClientEvent('spawn:vehicle', _source, vehicle)
end)
