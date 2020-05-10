local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    -- min_level, price_dollar, price_gold
    ["revolver_lemat"] = {0, 317, 13},
    ["revolver_cattleman"] = {0, 50, 2},
    -- ["revolver_navy"] = {0, 257, 11},
    ["pistol_volcanic"] = {0, 300, 14},
    ["shotgun_sawedoff"] = {0, 65, 15},
    ["repeater_carbine"] = {0, 90, 4},
    ["repeater_henry"] = {0, 234, 10},
    ["sniperrifle_rollingblock"] = {0, 500, 20},
    ["rifle_varmint"] = {0, 72, 3},
    ["rifle_boltaction"] = {0, 216, 9},
    -- AMMO
    ["ammo_revolver"] = {0, 10, 2, 20},
    ["ammo_pistol"] = {0, 10, 2, 20},
    ["ammo_repeater"] = {0, 10, 2, 20},
    ["ammo_rifler"] = {0, 10, 2, 20},
    ["ammo_shotgun"] = {0, 10, 2, 20}
}

-- ["revolver_lemat"] = {1, 7, 317, 13},
-- ["revolver_cattleman"] = {1, 1, 50, 2},
-- ["REVOLVER_NAVY"] = {1, 5, 257, 11},
-- -- PISTOL
-- ["pistol_volcanic"] = {1, 24, 300, 14},
-- --shotgun
-- ["shotgun_sawedoff"] = {1, 5, 111, 13},
-- -- repeater
-- ["repeater_carbine"] = {1, 2, 90, 4},
-- ["repeater_henry"] = {1, 17, 234, 10},
-- -- precision rifle 
-- ["sniperrifle_rollingblock"] = {1, 15, 500, 20},
-- -- MELEE
-- --  ["BOLAS"] = {1, 1, 30, 2},
-- ["thrown_throwing_knives"] = {1, 1, 2.5, 0.5},
-- ["melee_cleaver"] = {1, 5, 8, 1},  
-- ["melee_knife"] = {1, 1, 0.5, 0.1},     
-- -- manual rifle
-- ["rifle_varmint"] = {1, 7, 72, 3},
-- ["rifle_boltaction"] = {1, 9, 216, 9},


RegisterNetEvent("VP:GUNSMITH:TryToBuy")
AddEventHandler(
    "VP:GUNSMITH:TryToBuy",
    function(itemId, withGold)
        local _source = source

        if not verificationData[itemId] then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        local itemData = verificationData[itemId]
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
            User:notify("error", "Você não tem dinheiro suficiente")
            return
        end

        local itemAmount = itemData[4] or 1

        if Inventory:addItem(itemId, itemAmount) then
            Inventory:removeItem(-1, currencyItem, itemPrice)
            if itemPrice > 0 then
                if not withGold then
                    User:notify("dollar", string.format("%.2f", -(itemPrice / 100)))
                else
                    User:notify("gold", string.format("%.2f", -(itemPrice / 100)))
                end
            end
            User:notify('item', API.getItemDataFromId(itemId):getName(), itemAmount)
        else
            User:notify("error", "Espaço insuficiente na bolsa!")
        end
    end
)
