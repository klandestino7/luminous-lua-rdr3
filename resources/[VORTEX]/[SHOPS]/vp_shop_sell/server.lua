local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    ["Mercado Geral"] = {
        ["tobacco"] = {1, 1, 10},
        ["corn"] = {1, 1, 10},
        ["sugarcane"] = {1, 1, 10},
        ["feather_1"] = {100, 25, 5},
    },
    ["Acogueiro"] = {
        ["meat"] = {75, 1, 1},
        ["meat_poor"] = {75, 1, 1},
        ["meat_good"] = {137, 1, 1},
        ["meat_perfect"] = {356, 1, 1},
        ["feather_1"] = {100, 1, 5},
        ["feather_2"] = {100, 1, 5},
    },
    ["Posto de Troca"] = {
        ["raw_coal"] = {100, 40, 2},
        ["raw_iron"] = {200, 80, 2},
        ["raw_copper"] = {300, 120, 2},
    }
}

RegisterNetEvent("VP:SHOP:TryToSell")
AddEventHandler(
    "VP:SHOP:TryToSell",
    function(shopId, itemId, withGold)
        local _source = source

        if not verificationData[shopId] or not verificationData[shopId][itemId] then
            -- User:notify("error", "Item não registrado, contate um ADMIN")
            return
        end

        local data = verificationData[shopId]

        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        if data.group then
            if not Character:hasGroupOrInheritance(data.group) then
                User:notify("error", "Você não tem permissao")
                return
            end
        end

        local itemData = data[itemId]

        local Inventory = Character:getInventory()

        local itemAmount = itemData[3]

        if Inventory:getItemAmount(itemId) < itemAmount then
            local idata = API.getItemDataFromId(itemId)
            User:notify("error", "Você precisa de no mínimo x" .. itemAmount .. " " .. idata:getName() .. " para vender!")
            return
        end

        local currencyItem = "money"
        local itemPrice = itemData[1]

        if withGold then
            currencyItem = "gold"
            itemPrice = itemData[2]
        end

        if Inventory:removeItem(-1, itemId, itemAmount) then
            Inventory:addItem(currencyItem, itemPrice)
            User:notify("item", API.getItemDataFromId(itemId):getName(), -(itemAmount))
            if not withGold then
                User:notify("dollar", string.format("%.2f", (itemPrice / 100)))
            else
                User:notify("gold", string.format("%.2f", (itemPrice / 100)))
            end
        end
    end
)
