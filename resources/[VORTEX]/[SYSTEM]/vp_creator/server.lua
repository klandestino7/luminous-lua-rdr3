local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('VP:CREATOR:saveCreation')
AddEventHandler('VP:CREATOR:saveCreation', function(characterName, Age, SkinMdf)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:createCharacter(characterName, Age)
    if Character ~= nil then
    
        Character:setSkinData(Character:getId(), json.encode(SkinMdf))

        Character:setData(Character:getId(), "charTable", "hunger", 0)
        Character:setData(Character:getId(), "charTable", "thirst", 0)
        Character:setData(Character:getId(), "charTable", "banco", 0)

        local encoded = json.encode({-299.22,749.49,117.96})
        Character:setData(Character:getId(), "charTable", "position", encoded)       
        User:setCharacter(Character:getId()) -- Will draw itself

        Wait(5000)
        TriggerClientEvent('VP:CREATOR:FirstSpawn', _source)
    end
end)