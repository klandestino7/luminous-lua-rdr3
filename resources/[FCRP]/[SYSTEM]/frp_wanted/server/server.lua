local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:WANTED:checkJOB')
AddEventHandler('FRP:WANTED:checkJOB', function()
    local _source = source
    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    if Character:hasGroup("user") then        
        return true
    end
end)

RegisterServerEvent('FRP:WANTED:gunshotInProgress')
AddEventHandler('FRP:WANTED:gunshotInProgress', function(targetCoords, CityName, playerGender)
    local _source = source
    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    if Character:hasGroup("user") then
        if playerGender == -171876066 then
            playerGender = 'homem'
        else
            playerGender = 'mulher'
        end
        TriggerClientEvent('FRP:WANTED:outlawNotify', -1, 'Disparos por ' .. playerGender .. ' foram relatados em ' .. CityName)
        TriggerClientEvent('FRP:WANTED:gunshotInProgress', -1, targetCoords)
    end
end)

RegisterServerEvent('FRP:WANTED:RewardNotify')
AddEventHandler('FRP:WANTED:RewardNotify', function(id, reward, city)
    local tplayer = API.getUserFromUserId(parseInt(id)):getSource()

    local User = API.getUserFromSource(tplayer)      

    local Character = User:getCharacter()
    local pname = Character:getName()
    local charid = Character:getId()
    local wan = Character:getData(charid, "wanted", city)

    if wan ~= nil then  
        local wantedvalue = json.decode(wan)
        TriggerClientEvent('FRP:WANTED:RewardNotify', -1, reward+wantedvalue, pname, city)
    else
        TriggerClientEvent('FRP:WANTED:RewardNotify', -1, reward, pname, city) 
    end


end)

RegisterServerEvent('FRP:WANTED:RewardSERVER')
AddEventHandler('FRP:WANTED:RewardSERVER', function(id, value, city)
    local tplayer = API.getUserFromUserId(parseInt(id)):getSource()
    local User = API.getUserFromSource(tplayer)

    local Character = User:getCharacter()
    local charid = Character:getId()
    local wan = Character:getData(charid, "wanted", city)
    
    if wan ~= nil then    
        local wantedvalue = json.decode(wan)
        local wanted = {
            [city] = value
        }    
        Character:setData(charid, "wanted", city, value+wantedvalue)
    else       
        local wanted = {
            [city] = value
        }    
        Character:setData(charid, "wanted", city, value)
    end

 --   Character:setWanted(charid, json.encode(wanted))
end)
        

RegisterCommand('gwanted2', function(source)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()
    local charid = Character:getId()

    local wan = Character:getData(charid, "wanted", nil)
    local wanted = json.decode(wan)
    TriggerClientEvent('FRP:WANTED:GetWanted', _source, wanted)
end)