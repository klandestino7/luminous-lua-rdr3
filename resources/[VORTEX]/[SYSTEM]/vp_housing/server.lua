local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

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
    function(house_id, withGold)
        local _source = source

        if not houses[house_id] then
            return
        end

        local price_dollar = houses[house_id][1]
        local price_gold = houses[house_id][2]

        if price_dollar == nil or price_gold == nil then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if true then
            User:notify("error", "Não disponivel :P")
            return
        end

        if Character:hasGroupOrInheritance(house_id) then
            User:notify("error", "Você já alugou esta residência")
            return
        end

        -- if #API.getUsersByGroup(house_id) > 0 then
        local rows = dbAPI.query("SELECT:house_rent", {house_id = house_id})

        if #rows > 0 then
            User:notify("error", "Está residência já foi alugada")
            return
        end

        local Inventory = Character:getInventory()

        if not withGold then
            if Inventory:getItemAmount("money") < price_dollar then
                User:notify("error", "Você não tem doláres suficientes")
                return
            end

            if Inventory:removeItem(-1, "money", price_dollar) then
                User:notify("success", "Parábens! Agora essa residência está sobe sua gerência")
                Character:addGroup(house_id)

                local date = os.date("*t")

                local time_sum_sevendays = os.time(date) + (7 * 24 * 60 * 60)

                local date_sum_sevendays = os.date("*t", time_sum_sevendays)

                local sum_to_time = os.time(date_sum_sevendays)


                -- MUDA NA DB house_next_payment PARA INT

                dbAPI.execute("INSERT:house_rent", {house_id = house_id, house_next_payment = sum_to_time})
            end
        else
            if Inventory:getItemAmount("gold") < price_gold then
                User:notify("error", "Você não tem ouro suficiente")
                return
            end

            if Inventory:removeItem(-1, "gold", price_gold) then
                User:notify("success", "Parábens! Agora essa residência está sobe sua gerência")
                Character:addGroup(house_id)
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

                    local houseGroupBit = API.GroupNameToBit(house_id)
                    dbAPI.execute("UPDATE:character_remove_role", {role = houseGroupBit})
                end
            end
        end
    end
)

function IsRentExpired(house_id)
    local rows = dbAPI.query("SELECT:house_rent", {house_id = house_id})

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

-- AddEventHandler(
--     "VP:HOUSING:RequestAvailableHouses",
--     function()

--     end
-- )
