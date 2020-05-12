local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('VP:Respawn:_Dead')
AddEventHandler('VP:Respawn:_Dead', function()
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    Inventory:deleteInventory()
    TriggerEvent('VP:SYSTEMPAY:removedeath', _source)
end)


RegisterServerEvent('VP:RESPAWN:onPlayerDeath')
AddEventHandler('VP:RESPAWN:onPlayerDeath', function(data)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

    if data ~= nil then
        Character:setDeath(1)
    else
        Character:setDeath(0)
    end

    Wait(1500)

    print(Character:getDeath())
end)

RegisterServerEvent('VP:RESPAWN:CheckDeath')
AddEventHandler('VP:RESPAWN:CheckDeath', function()
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

    if Character:getDeath() == 1 then
        TriggerClientEvent('VP:RESPAWN:PlayerDead', _source)
    end

end)


RegisterServerEvent('VP:Respawn:checkgroup')
AddEventHandler('VP:Respawn:checkgroup', function()
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

  --  if (Character:hasGroup("vip1") or Character:hasGroup("vip2") or Character:hasGroup("vip3")) then
   --     TriggerClientEvent('FRP_respawn:respawnvip', _source)
    --else
        TriggerClientEvent('FRP_respawn:respawn', _source)
   --end
end)