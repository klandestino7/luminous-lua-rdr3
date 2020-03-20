local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('FCRP:Respawn:_Dead')
AddEventHandler('FCRP:Respawn:_Dead', function()
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    Inventory:deleteInventory()
end)


RegisterServerEvent('FCRP:Respawn:checkgroup')
AddEventHandler('FCRP:Respawn:checkgroup', function()
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

    if Character:hasGroup("vip") then
        TriggerClientEvent('FRP_respawn:respawnvip', _source)
    else
        TriggerClientEvent('FRP_respawn:respawn', _source)
    end
end)