local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")
cAPI = Tunnel.getInterface("API")

local loadedFromDatabase = {}
local farmsInfo = {}

RegisterNetEvent("VP:FARM:TryToPlantSeed")
AddEventHandler(
    "VP:FARM:TryToPlantSeed",
    function(seedTryingToPlant, farmAreaId, slot_id)
        local _source = source
        if not farmsInfo[farmAreaId] then
            return
        end

        local User = API.getUserFromSource(_source)

        if farmsInfo[farmAreaId][slot_id] ~= nil then
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

        local seedItem = farmAreaId .. "_seed"
        if Inventory:getItemAmount(seedItem) <= 0 then
            User:notify("Você precisa de uma semente para plantar!")
            return
        end

        local time_next_water = os.time() + 2

        Inventory:removeItem(-1, seedItem, 1)
        farmsInfo[farmAreaId][slot_id] = {0, time_next_water}
        -- Age, timesWatered

        User:notify("Semente plantada!")
        TriggerClientEvent("VP:FARM:SetSpot", _source, farmAreaId, slot_id, 0)

        dbAPI.execute("INSERT:crop_insert_slot", {crop_id = farmAreaId, slot_id = slot_id, crop_min_time_water = time_next_water})
    end
)

RegisterNetEvent("VP:FARM:TryToWaterCrop")
AddEventHandler(
    "VP:FARM:TryToWaterCrop",
    function(farmAreaId, slot_id)
        local _source = source

        if farmsInfo[farmAreaId] == nil or farmsInfo[farmAreaId][slot_id] == nil then
            return
        end

        local User = API.getUserFromSource(_source)
        if farmsInfo[farmAreaId][slot_id][2] > os.time() then
            print("Cuidado! se você regar demais a planta pode morrer")
            User.notify("Cuidado! se você regar demais a planta pode morrer")
            return
        end

        local currentgrowth = farmsInfo[farmAreaId][slot_id][1]

        if currentgrowth >= 99 then
            print("Está planta já está pronta para ser colhida")
            User.notify("Está planta já está pronta para ser colhida")
            return
        end

        local newgrowth = currentgrowth + 33
        local time_next_water = os.time() + 2

        farmsInfo[farmAreaId][slot_id] = {newgrowth, time_next_water}
        TriggerClientEvent("VP:FARM:SetSpot", _source, farmAreaId, slot_id, newgrowth)

        dbAPI.execute("UPDATE:crop_update_slot", {crop_id = farmAreaId, slot_id = slot_id, crop_percent_grown = newgrowth, crop_min_time_water = time_next_water})

        -- Citizen.CreateThread(
        --     function()
        --         Citizen.Wait(10000)

        --     end
        -- )

        -- TriggerClientEvent('VP:FARM:WaterPlantAnimation', _source, ...)
    end
)

RegisterNetEvent("VP:FARM:TryToHarvestCrop")
AddEventHandler(
    "VP:FARM:TryToHarvestCrop",
    function(farmAreaId, slot_id)
        local _source = source

        if farmsInfo[farmAreaId] == nil or farmsInfo[farmAreaId][slot_id] == nil then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()
        local plantItem = farmAreaId ~= 'sugarcane' and farmAreaId or 'sugar'
        print(plantItem)

        if Inventory:addItem(plantItem, 1) then
            farmsInfo[farmAreaId][slot_id] = nil
            TriggerClientEvent("VP:FARM:SetSpot", _source, farmAreaId, slot_id, nil)
            dbAPI.execute("UPDATE:crop_remove_slot", {crop_id = farmAreaId, slot_id = slot_id})
        else
            User:notify("Inventário cheio!")
        end
    end
)

RegisterNetEvent("VP:FARM:AskForFarmsInfo")
AddEventHandler(
    "VP:FARM:AskForFarmsInfo",
    function(farmAreaId)
        local _source = source

        if loadedFromDatabase[farmAreaId] == nil then
            local query = dbAPI.query("SELECT:get_crop_slots", {crop_id = farmAreaId})

            farmsInfo[farmAreaId] = {}

            if #query > 0 then
                for _, v in pairs(query) do
                    farmsInfo[farmAreaId][v.slot_id] = {v.crop_percent_grown, v.crop_min_time_water}
                end
            end

            loadedFromDatabase[farmAreaId] = true
        end

        local t = {}
        for k, v in pairs(farmsInfo[farmAreaId]) do
            t[k] = {v[1]}
        end

        TriggerClientEvent("VP:FARM:SetFarmsInfo", _source, farmAreaId, farmsInfo[farmAreaId])
    end
)

function getFarmAreaType(farmAreaId)
    local farmtype = farmAreaId
    return farmtype
end

function getFarmAreaMaxAge(farmAreaId)
    local farmtype = farmAreaId

    -- if farmtype == "tobacco" then
    return 3
    -- end
end

Citizen.CreateThread(function()
    print(GetHashKey('LOCO_BAIT_BUCKET'))
end)