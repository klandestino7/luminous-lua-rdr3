local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('VP:CHARCREATION:saveCreation')
AddEventHandler('VP:CHARCREATION:saveCreation', function(characterName, dados)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:createCharacter(characterName)
    if Character ~= nil then
        for k, v in pairs(dados) do
            Character:setData(Character:getId(), 'charTable', k, v)
        end
        User:setCharacter(Character:getId()) -- Will draw itself
    end
end)