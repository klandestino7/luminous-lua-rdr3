local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    -- ["Armeiro"] = {
    --     -- Level, Dollar, Gold, Amount(optional)
    --     ["revolver_lemat"] = {0, 317, 13},
    --     ["revolver_cattleman"] = {0, 50, 2},
    --     ["revolver_navy"] = {0, 257, 11},
    --     ["pistol_volcanic"] = {0, 300, 14},
    --     ["shotgun_sawedoff"] = {0, 65, 15},
    --     ["repeater_carbine"] = {0, 90, 4},
    --     ["repeater_henry"] = {0, 234, 10},
    --     ["sniperrifle_rollingblock"] = {0, 500, 20},
    --     ["rifle_varmint"] = {0, 72, 3}
    -- },
    ["Arsenal"] = {
        group = "admin",
        -- Level, Price, Amount(optional)
        ["revolver_doubleaction"] = {0, 0, 0},
        ["rifle_springfield"] = {0, 0, 0},
        ["shotgun_pump"] = {0, 0, 0},
        ["ammo_revolver"] = {0, 0, 0, 100},
        ["ammo_rifle"] = {0, 0, 0, 75},
        ["ammo_shotgun"] = {0, 0, 0, 50}
    },
    -- ["Mercadinho"] = {
    --     -- Level, Price, Amount(optional)
    --     ["consumable_vodka"] = {1, 50}
    -- },
    -- ["Planeta Semente'"] = {
    --     ["tobacco_seed"] = {1, 100, 10}
    -- }

    ["Geral"] = {
        ["tobacco_seed"] = {0, 1, 1, 1},
        ["corn_seed"] = {0, 1, 1, 1},
        ["sugarcane_seed"] = {0, 1, 1, 1}
    }
}

RegisterNetEvent("VP:SHOP:TryToBuy")
AddEventHandler(
    "VP:SHOP:TryToBuy",
    function(shopId, itemId, withGold)
        local _source = source

        if not verificationData[shopId] or not verificationData[shopId][itemId] then
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

        local itemLevel = itemData[1]

        if Character:getLevel() < itemLevel then
            User:notify("error", "Você não tem level suficiente")
            return
        end

        local Inventory = Character:getInventory()

        local currencyItem = "money"
        local itemPrice = itemData[2]

        if withGold then
            currencyItem = "gold"
            itemPrice = itemData[3]
        end

        if Inventory:getItemAmount(currencyItem) < itemPrice then
            if currencyItem == "money" then
                User:notify("error", "Doláres insuficientes")
            else
                User:notify("error", "Ouros insuficientes")
            end
            return
        end

        local itemAmount = itemData[4]

        if Inventory:addItem(itemId, itemAmount or 1) then
            Inventory:removeItem(-1, currencyItem, itemPrice)
            if itemPrice > 0 then
                if not withGold then
                    User:notify("dollar", string.format("%.2f", -(itemPrice / 100)))
                else
                    User:notify("gold", string.format("%.2f", -(itemPrice / 100)))
                end
            end
                User:notify("item", API.getItemDataFromId(itemId):getName(), itemAmount or 1)
        else
            User:notify("error", "Espaço insuficiente na bolsa!")
        end
    end
)
