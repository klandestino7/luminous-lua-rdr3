local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local wantedUserIds = {}

RegisterServerEvent("VP:WANTED:checkJOB")
AddEventHandler(
    "VP:WANTED:checkJOB",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        if Character:hasGroup("user") then
            return true
        end
    end
)

RegisterServerEvent("VP:WANTED:gunshotInProgress")
AddEventHandler(
    "VP:WANTED:gunshotInProgress",
    function(targetCoords, CityName, playerGender)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if playerGender == -171876066 then
            playerGender = "homem"
        else
            playerGender = "mulher"
        end

        local PoliceON = API.getUsersByGroup("trooper")

        for i = 1, #PoliceON do
            TriggerClientEvent("VP:WANTED:outlawNotify", PoliceON[i].getSource(), "Disparos por " .. playerGender .. " foram relatados em " .. CityName)
            TriggerClientEvent("VP:WANTED:gunshotInProgress", PoliceON[i].getSource(), targetCoords)
        end
    end
)

RegisterServerEvent("VP:WANTED:RewardNotify")
AddEventHandler(
    "VP:WANTED:RewardNotify",
    function(id, reward, city)
        local tplayer = API.getUserFromUserId(parseInt(id)):getSource()

        local User = API.getUserFromSource(tplayer)

        local Character = User:getCharacter()
        local pname = Character:getName()
        local charid = Character:getId()
        local wan = Character:getData(charid, "wanted", city)

        local PoliceON = API.getUsersByGroup("trooper")

        for i = 1, #PoliceON do
            if wan ~= nil then
                if wan == "{}" then
                    local wantedvalue = 0
                    TriggerClientEvent("VP:WANTED:RewardNotify", PoliceON[i].getSource(), reward + wantedvalue, pname, city)
                else
                    local wantedvalue = json.decode(wan)
                    TriggerClientEvent("VP:WANTED:RewardNotify", PoliceON[i].getSource(), reward + wantedvalue, pname, city)
                end
            else
                TriggerClientEvent("VP:WANTED:RewardNotify", PoliceON[i].getSource(), reward, pname, city)
            end
        end
    end
)

RegisterServerEvent("VP:WANTED:RewardSERVER")
AddEventHandler(
    "VP:WANTED:RewardSERVER",
    function(id, value, city)
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
            Character:setData(charid, "wanted", city, value + wantedvalue)
        else
            local wanted = {
                [city] = value
            }
            Character:setData(charid, "wanted", city, value)
        end

        --   Character:setWanted(charid, json.encode(wanted))
    end
)

RegisterCommand(
    "gwanted2",
    function(source)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local charid = Character:getId()

        local wan = Character:getData(charid, "wanted", nil)
        local wanted = json.decode(wan)
        TriggerClientEvent("VP:WANTED:GetWanted", _source, wanted)
    end
)

RegisterNetEvent("VP:WANTED:MarkAsWanted")
AddEventHandler(
    "VP:WANTED:MarkAsWanted",
    function(asWanted)
        local _source = source

        local v = asWanted == true and true or nil

        local User = API.getUserFromSource(_source)

        if User then
            wantedUserIds[User:getId()] = v

            for _, User in pairs(API.getUsersByGroup("trooper")) do
                local uSource = User:getSource()

                TriggerClientEvent("VP:WANTED:SyncWantedOrNotPlayer", uSource, v)
            end
        end
    end
)

AddEventHandler(
    "API:OnUserCharacterInitialization",
    function(User, character_id)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("trooper") then
            local r = {}

            for _, uid in pairs(wantedUserIds) do
                local sUser = API.getUserFromUserId(uid)
                local sSource = User:getSource()
                table.insert(r, sSource)
            end

            TriggerClientEvent("VP:WANTED:SyncWantedPlayers", source, r)
        end
    end
)
