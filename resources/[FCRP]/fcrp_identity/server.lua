local Tunnel = module("_core","libs/Tunnel")
local Proxy = module("_core","libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('fcrp_identity:charList')
AddEventHandler('fcrp_identity:charList', function(source)
    local _source = source

    if _source == nil then
        return
    end

    local User = API.getUserFromSource(_source)
 
    if User:getId() then
        TriggerClientEvent('fcrp_identity:charList', _source, User:getCharacters())
    end
end)

RegisterServerEvent('fcrp_identity:charListWithUser')
AddEventHandler('fcrp_identity:charListWithUser', function(User)
    if User:getId() then
        TriggerClientEvent('fcrp_identity:charList', User:getSource(), User:getCharacters())
    end
end)

RegisterNetEvent("showPicture")
AddEventHandler("showPicture", function(src)
    local _source = source

    TriggerClientEvent("showPictureOfPlayer", _source, _source)
end)

RegisterServerEvent('fcrp_identity:selectCharacter')
AddEventHandler('fcrp_identity:selectCharacter', function(cid) 
    print('server  selectcharacter')
    local _source = source
    -- cAPI.camera
    local User = API.getUserFromSource(_source) 
    User:setCharacter(cid) 
end)

RegisterServerEvent('FCRP:SENDMUGS')
AddEventHandler('FCRP:SENDMUGS', function(mug)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

    Character:setData(Character:getId(), 'skin', 'mug', mug)
end)


function doSpawnPlayer(source,user_id,firstspawn)
    local _source = source
  --  TriggerClientEvent("fcrp_character:normalSpawn",source,firstspawn)
end




RegisterServerEvent('fcrp_identity:deleteCharacter')
AddEventHandler('fcrp_identity:deleteCharacter', function(cid)
    local _source = source
    local User = API.getUserFromSource(_source)
    User:deleteCharacter(cid)
    TriggerEvent('fcrp_identity:charList', _source, _source)
end)
