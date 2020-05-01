local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    -- ["Ammunation"] = {
    --     -- Level, Dollar, Gold, Amount(optional)
    --     ["weapon_combatpistol"] = {1, 100},
    --     ["weapon_assaultrifle"] = {1, 100},
    --     ["ammo_combatpistol"] = {0, 0, 20},
    --     ["weapon_knife"] = {0, 0}
    -- },
    ["Policia"] = {
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
        ["sugarcane_seed"] = {0, 1, 1, 1},
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
                User:notify("Você não tem permissao")
                return
            end
        end

        local itemData = data[itemId]

        local itemLevel = itemData[1]

        if Character:getLevel() < itemLevel then
            User:notify("Você não tem level suficiente")
            return
        end

        local Inventory = Character:getInventory()

        local currencyItem = 'money'
        local itemPrice = itemData[2]

        if withGold then
            currencyItem = 'gold'
            itemPrice = itemData[3]
        end

        if Inventory:getItemAmount(currencyItem) < itemPrice then
            User:notify("Você não tem dinheiro suficiente")
            return
        end

        local itemAmount = itemData[4]

        if Inventory:addItem(itemId, itemAmount or 1) then
            Inventory:removeItem(-1, currencyItem, itemPrice)
            if itemPrice > 0 then
                if not withGold then
                    User:notify("- $" .. string.format("%.2f", itemPrice / 100))
                else
                    User:notify("- " .. string.format("%.2f", itemPrice / 100) .. ' ouros')
                end
            else
                User:notify(itemId)
            end
        else
            User:notify("Espaço insuficiente na bolsa!")
        end
    end
)
