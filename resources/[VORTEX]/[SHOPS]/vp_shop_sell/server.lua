local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    -- ["Ammunation"] = {
    --     -- Dollar, Gold, Amount(optional)
    --     ["weapon_combatpistol"] = {1, 100},
    --     ["weapon_assaultrifle"] = {1, 100},
    --     ["ammo_combatpistol"] = {0, 0, 20},
    --     ["weapon_knife"] = { 0}
    -- },
    -- ["Policia"] = {
    --     group = "admin",
    --     -- Price, Amount(optional)
    --     ["revolver_doubleaction"] = {0, 0},
    --     ["rifle_springfield"] = {0, 0},
    --     ["shotgun_pump"] = {0, 0},
    --     ["ammo_revolver"] = {0, 0, 100},
    --     ["ammo_rifle"] = {0, 0, 75},
    --     ["ammo_shotgun"] = {0, 0, 50}
    -- },
    -- ["Mercadinho"] = {
    --     --  Price, Amount(optional)
    --     ["consumable_vodka"] = {1, 50}
    -- },
    -- ["Planeta Semente'"] = {
    --     ["tobacco_seed"] = {1, 100, 10}
    -- }

    ["Geral"] = {
        ["tobacco"] = {1, 1, 10},
        ["corn"] = {1, 1, 10},
        ["sugarcane"] = {1, 1, 10}
    }
}

RegisterNetEvent("VP:SHOP:TryToSell")
AddEventHandler(
    "VP:SHOP:TryToSell",
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

        local Inventory = Character:getInventory()

        local itemAmount = itemData[3]

        if Inventory:getItemAmount(itemId) < itemAmount then
            local idata = API.getItemDataFromId(itemId)
            User:notify("error", "Você precisa de no mínimo x" .. itemAmount .. "de " .. idata:getName() .. " para vender!")
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
            if not withGold then
                User:notify("dollar", string.format("%.2f", -(itemPrice / 100)))
            else
                User:notify("gold", string.format("%.2f", -(itemPrice / 100)))
            end
        end
    end
)
