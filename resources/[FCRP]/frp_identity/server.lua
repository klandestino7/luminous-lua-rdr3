local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('FCRP:IDENTITY:charList')
AddEventHandler(
    'FCRP:IDENTITY:charList',
    function(User)
        if User == nil then
            return
        end

        TriggerClientEvent('FCRP:IDENTITY:charList', User:getSource(), User:getCharacters())
    end
)

RegisterServerEvent('FCRP:IDENTITY:charListWithUser')
AddEventHandler(
    'FCRP:IDENTITY:charListWithUser',
    function(User)
        if User == nil then
            return
        end

        TriggerClientEvent('FCRP:IDENTITY:charList', User:getSource(), User:getCharacters())
    end
)

RegisterServerEvent('FCRP:IDENTITY:selectCharacter')
AddEventHandler(
    'FCRP:IDENTITY:selectCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:setCharacter(cid)
    end
)

RegisterServerEvent('FCRP:IDENTITY:deleteCharacter')
AddEventHandler(
    'FCRP:IDENTITY:deleteCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:deleteCharacter(cid)
        TriggerEvent('FCRP:IDENTITY:charList', source, _source)
    end
)
