local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    ["Ammunation"] = {
        -- Level, Price, Amount(optional)
        ["weapon_combatpistol"] = {1, 100},
        ["weapon_assaultrifle"] = {1, 100},
        ["ammo_combatpistol"] = {0, 0, 20},
        ["weapon_knife"] = {0, 0}
    },
    ["Policia"] = {
        group = "admin",
        -- Level, Price, Amount(optional)
        ["weapon_combatpistol"] = {0, 0},
        ["weapon_assaultrifle"] = {0, 0},
        ["ammo_combatpistol"] = {0, 0, 20},
        ["weapon_knife"] = {0, 0}
    },
    ["Mercadinho"] = {
        -- Level, Price, Amount(optional)
        ["consumable_vodka"] = {1, 50}
    }
}

RegisterNetEvent("CK:SHOP:TryToBuy")
AddEventHandler(
    "CK:SHOP:TryToBuy",
    function(shopId, itemId)
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

        local itemPrice = itemData[2]

        local Inventory = Character:getInventory()

        if Inventory:getItemAmount("generic_money") < itemPrice then
            User:notify("Você não tem dinheiro suficiente")
            return
        end

        local itemAmount = itemData[3]

        Inventory:removeItem("generic_money", itemPrice)
        Inventory:addItem(itemId, itemAmount or 1)

        User:notify("- $" .. itemPrice .. ",00")
        if itemId:find("weapon_") or itemId:find("ammo_") then
            TriggerClientEvent("CK:SHOP:BoughtItem", _source, itemId)
        else
            TriggerClientEvent("CK:SHOP:BoughtItem", _source, nil)
        end
    end
)
