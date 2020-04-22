local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local farmsInfo = {}

RegisterNetEvent("VP:FARM:TryToPlantSeed")
AddEventHandler(
    "VP:FARM:TryToPlantSeed",
    function(seedTryingToPlant, farmAreaId, spotId)
        print(seedTryingToPlant, farmAreaId, spotId)
        local _source = source
        if not farmsInfo[farmAreaId] then
            return
        end

        local User = API.getUserFromSource(_source)

        if farmsInfo[farmAreaId][spotId] ~= nil then
            User:notify("Procure outro lugar para plantar!")
            return
        end

        local type = getFarmAreaType(farmAreaId)

        if seedTryingToPlant ~= type then
            User:notify("Você não pode plantar esse tipo de semente aqui!")
            return
        end

        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        local seedItem = getFarmAreaSeed(farmAreaId)
        if Inventory:getItemAmount(seedItem) <= 0 then
            User:notify("Você precisa de uma semente para plantar!")
            return
        end

        Inventory:removeItem(-1, seedItem, 1)
        farmsInfo[farmAreaId][spotId] = {1, 0}
        -- Age, timesWatered

        User:notify("Semente plantada!")
        TriggerClientEvent("VP:FARM:SetSpot", -1, farmAreaId, spotId, 1, 0)
    end
)

RegisterNetEvent("VP:FARM:AskForFarmsInfo")
AddEventHandler(
    "VP:FARM:AskForFarmsInfo",
    function()
        local _source = source
        TriggerClientEvent('VP:FARM:SetFarmsInfo', _source, farmsInfo)
    end
)

function getFarmAreaType(farmAreaId)
    local farmtype = farmAreaId:sub(0, farmAreaId:find(":") - 1)
    return farmtype
end

function getFarmAreaSeed(farmAreaId)
    local farmtype = farmAreaId:sub(0, farmAreaId:find(":") - 1)
    return farmtype .. "_seed"
end

function getFarmAreaMaxAge(farmAreaId)
    local farmtype = farmAreaId:sub(0, farmAreaId:find(":") - 1)

    if farmtype == "tobacco" then
        return 3
    end
end

Citizen.CreateThread(
    function()
        init()
    end
)

function init()
    farmsInfo["tobacco:1"] = {
        [1] = {2, 0}
    }
end
