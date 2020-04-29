local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local shopItems = {}

local buyableData = {
    -- [id] = {amount, level, money, gold},
    ["revolver_lemat"] = {1, 7, 317, 13},
    ["revolver_cattleman"] = {1, 1, 50, 2},
    ["REVOLVER_NAVY"] = {1, 5, 257, 11},
    -- PISTOL
    ["pistol_volcanic"] = {1, 24, 300, 14},
    --shotgun
    ["shotgun_sawedoff"] = {1, 5, 111, 13},
    -- repeater
    ["repeater_carbine"] = {1, 2, 90, 4},
    ["repeater_henry"] = {1, 17, 234, 10},
    -- precision rifle 
    ["sniperrifle_rollingblock"] = {1, 15, 500, 20},
    -- MELEE
  --  ["BOLAS"] = {1, 1, 30, 2},
    ["thrown_throwing_knives"] = {1, 1, 2.5, 0.5},
    ["melee_cleaver"] = {1, 5, 8, 1},  
    ["melee_knife"] = {1, 1, 0.5, 0.1},     
    -- manual rifle
    ["rifle_varmint"] = {1, 7, 72, 3},
    ["rifle_boltaction"] = {1, 9, 216, 9},

    -- Ammo
    ["ammo_revolver"] = {20, 1, 10, 2},
    ["ammo_pistol"] = {20, 1, 10, 2},
    ["ammo_repeater"] = {20, 1, 10, 2},
    ["ammo_rifle"] = {20, 1, 10, 2},
    ["ammo_shotgun"] = {20, 1, 10, 2},
}

RegisterNetEvent("FC:WEAPONSHOP:BuyWeapon")
AddEventHandler(
    "FC:WEAPONSHOP:BuyWeapon",
    function(item_id, gold, money)

        if not buyableData[item_id] then
            return
        end
 
        local amount = buyableData[item_id][1]
        local level = buyableData[item_id][2]
        local price_dolar = buyableData[item_id][3]
        local price_gold = buyableData[item_id][4]

        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()


        local ItemData = API.getItemDataFromId(tostring(item_id))

        local userlevel = User:getCharacter():getLevel()
        if userlevel < level then
            User:notify('Level insuficiente!')
            return
        end

        if gold ~= nil then   
            if Inventory:getItemAmount("gold") < tonumber(price_gold*100) then
                User:notify("Dinheiro insuficiente!")
                return
            end
        else
            if Inventory:getItemAmount("money") < tonumber(price_dolar*100) then
                User:notify("Dinheiro insuficiente!")
                return
            end
        end        

        if Inventory:getWeight() + (ItemData:getWeight() * 1) > Inventory:getCapacity() then
            User:notify("Mochila no limite de peso!")
            return
        end
        print(gold, money)

        if gold ~= nil then             
            Inventory:addItem(item_id, amount)
            Inventory:removeItem(-1, "gold", tonumber(price_gold*100))   
            User:notify("Comprado!")
        else
            Inventory:addItem(item_id, amount)
            Inventory:removeItem(-1, "money", tonumber(price_dolar*100)) 
            User:notify("Comprado!")
        end    

        User:notify(ItemData:getName() .. " comprada!")
    end
)

RegisterNetEvent("FC:WEAPONSHOP:BuyAmmo")
AddEventHandler(
    "FC:WEAPONSHOP:BuyAmmo",
    function(item_id, gold)

        if not buyableData[item_id] then
            return
        end

        local amount = buyableData[item_id][1]
        local level = buyableData[item_id][2]
        local price_dolar = buyableData[item_id][3]
        local price_gold = buyableData[item_id][4]

        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local ItemData = API.getItemDataFromId(muni)

        local userlevel = User:getCharacter():getLevel()
        if userlevel < level then
            User:notify('Level insuficiente!')
            return
        end

        if gold ~= nil then   
            if Inventory:getItemAmount("gold") < tonumber(price_gold*100) then
                User:notify("Dinheiro insuficiente!")
                return
            end
        else
            if Inventory:getItemAmount("money") < tonumber(price_dolar*100) then
                User:notify("Dinheiro insuficiente!")
                return
            end
        end  

        if Inventory:getWeight() + (ItemData:getWeight() * amount) > Inventory:getCapacity() then
            User:notify("Mochila no limite de peso!")
            return
        end

        if gold ~= nil then             
            Inventory:addItem(item_id, amount)
            Inventory:removeItem(-1, "gold", tonumber(price_gold*100))   
        else
            Inventory:addItem(item_id, amount)
            Inventory:removeItem(-1, "money", tonumber(price_dolar*100)) 
        end               

        User:notify(ItemData:getName() .. " comprado!")
    end
)
