local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('fcrp_creator:saveCreator')
AddEventHandler('fcrp_creator:saveCreator', function(charName, age, saves, clothes)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:createCharacter(charName, age, json.encode(saves), json.encode(clothes))
    User:setCharacter(Character:getId())
    -- TriggerEvent('fcrp_identity:charList', _source)
end)
