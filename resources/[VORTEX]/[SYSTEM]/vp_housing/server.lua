local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbABI = Proxy.getInterface("API_DB")

local houses = {
    -- price_dollar, price_gold
    ["house:1"] = {20000, 8000},
    ["house:2"] = {20000, 8000},
    ["house:3"] = {20000, 8000},
    ["house:4"] = {20000, 8000},
    ["house:5"] = {20000, 8000},
    ["house:6"] = {20000, 8000},
    ["house:7"] = {20000, 8000}
}

RegisterNetEvent("VP:HOUSING:TryToBuyHouse")
AddEventHandler(
    "VP:HOUSING:TryToBuyHouse",
    function(houseId, withGold)
        local _source = source

        if not houses[houseId] then
            return
        end

        local price_dollar = houses[houseId][1]
        local price_gold = houses[houseId][2]

        if price_dollar == nil or price_gold == nil then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        if Character:hasGroupOrInheritance(houseId) then
            User:notify("error", "Você já alugou esta residência")
            return
        end

        -- if #API.getUsersByGroup(houseId) > 0 then
        local rows = dbABI.query("SELECT:house_rent", {house_id = houseId})

        if #rows > 0 then
            User:notify("error", "Está residência já foi alugada")
            return
        end

        if not withGold then
            if Inventory:getItemAmount("money") < price_dollar then
                User:notify("error", "Você não tem doláres suficientes")
                return
            end

            if Inventory:removeItem(-1, "money", price_dollar) then
                User:notify("success", "Parábens! Agora essa residência está sobe sua gerência")
                Character:addGroup(houseId)

                local date = os.date("*t")

                local time_sum_sevendays = os.time(date) + (7 * 24 * 60 * 60)

                local date_sum_sevendays = os.date("*t", time_sum_sevendays)

                local sum_to_time = os.time(date_sum_sevendays)

                dbABI.execute("INSERT:house_rent", {house_id = houseId, house_next_payment = sum_to_time})
            end
        else
            if Inventory:getItemAmount("gold") < price_gold then
                User:notify("error", "Você não tem ouro suficiente")
                return
            end

            if Inventory:removeItem(-1, "gold", price_gold) then
                User:notify("success", "Parábens! Agora essa residência está sobe sua gerência")
                Character:addGroup(houseId)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000 * 60 * 60) -- 1 Hora

            for house_id, _ in pairs(houses) do
                if IsRentExpired(house_id) then
                    for _, User in pairs(API.getUsersByGroup(house_id)) do
                        User:removeGroup(house_id)
                    end
                    dbAPI.execute("DELETE:house_rent", {house_id = house_id})
                end
            end
        end
    end
)

function IsRentExpired(house_id)
    local rows = dbABI.query("SELECT:house_rent", {house_id = house_id})

    if #rows > 0 then
        local date = os.date("*t")
        local time = os.time(date)

        local house_next_payment = tonumber(rows[1].house_next_payment)

        if house_next_payment > time then
            return true
        end
    end

    return false
end
