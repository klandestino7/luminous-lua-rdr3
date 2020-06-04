local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbABI = Proxy.getInterface('API_DB')

local houses = {
    ["house:1"] = {2000, 100},
    ["house:2"] = {2000, 100},
    ["house:3"] = {2000, 100},
    ["house:4"] = {2000, 100},
    ["house:5"] = {2000, 100},
    ["house:6"] = {2000, 100},
    ["house:7"] = {2000, 100}
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

        if #API.getUsersByGroup(houseId) > 0 then
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

                dbABI.execute('INSERT:house_rent', {house_id = houseId, house_next_payment = sum_to_time})
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
        local date = os.date("*t")

        local time_sum_sevendays = os.time(date) + (7 * 24 * 60 * 60)

        local date_sum_sevendays = os.date("*t", time_sum_sevendays)

        local sum_to_time = os.time(date_sum_sevendays)

        print(json.encode(date))
        print(json.encode(date_sum_sevendays))
        print(sum_to_time)

        while true do
            Citizen.Wait(1000 * 60 * 60) -- 1 Hora

            for houseId, _ in pairs(houses) do
                if HasRentBeenPaid() then
                    for _, Users in pairs(API.getUsersByGroup(houseId)) do
                        
                    end
                end
            end
        end
    end
)