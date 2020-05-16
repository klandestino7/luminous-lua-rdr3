local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("VP:HOUSING:TryToBuyHouse")
AddEventHandler(
    "VP:HOUSING:TryToBuyHouse",
    function(houseId, withGold)
        local _source = source

        local price_dollar
        local price_gold

        if houseId == "house:1" then
            price_dollar = 2000
            price_gold = 100
        elseif houseId == "house:2" then
            price_dollar = 2000
            price_gold = 100
        elseif houseId == "house:3" then
            price_dollar = 2000
            price_gold = 100
        -- elseif houseId == "house:4" then
        --     price_dollar = 2000
        --     price_gold = 100
        end

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
            Citizen.Wait(60000 * 60) -- 1 Hora
        end
    end
)
