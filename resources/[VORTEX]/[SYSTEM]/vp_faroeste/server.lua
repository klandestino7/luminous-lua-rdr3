local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterCommand('chartable', function(source)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

        Character:setData(Character:getId(), "charTable", "hunger", 0)
        Character:setData(Character:getId(), "charTable", "thirst", 0)
        Character:setData(Character:getId(), "charTable", "banco", 0)
end)