local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('VP:IDENTITY:charList')
AddEventHandler(
    'VP:IDENTITY:charList',
    function(User)
        if User == nil then
            return
        end
     
        TriggerClientEvent('VP:IDENTITY:charList', User:getSource(), User:getCharacters())
    end
)

RegisterServerEvent('VP:IDENTITY:charListWithUser')
AddEventHandler(
    'VP:IDENTITY:charListWithUser',
    function(User)
        if User == nil then
            return
        end
        TriggerClientEvent('VP:IDENTITY:charList', User:getSource(), User:getCharacters())
    end
)

RegisterServerEvent('VP:IDENTITY:selectCharacter')
AddEventHandler(
    'VP:IDENTITY:selectCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:setCharacter(cid)
    end
)

RegisterServerEvent('VP:IDENTITY:deleteCharacter')
AddEventHandler(
    'VP:IDENTITY:deleteCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:deleteCharacter(cid)
        TriggerEvent('VP:IDENTITY:charList', source, _source)
    end
)
