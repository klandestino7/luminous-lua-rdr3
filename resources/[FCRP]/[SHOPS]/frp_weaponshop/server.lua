local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local shopItems = {}

local buyableData = {
    -- [id] = {amount, level, money, gold},
    ["weapon_pistol_semiauto"] = {1, 1, 100, 2},
    ["weapon_revolver_cattleman"] = {1, 1, 100, 2},
    ["weapon_repeater_carbine"] = {1, 1, 100, 2},
    -- Ammo
    ["ammo_pistol"] = {20, 1, 10, 2},
    ["ammo_repeater"] = {20, 1, 10, 2},
    -- Melee
    ["weapon_melee_knife"] = {1, 1, 10, 2}
}

RegisterNetEvent("FC:WEAPONSHOP:BuyWeapon")
AddEventHandler(
    "FC:WEAPONSHOP:BuyWeapon",
    function(item_id, gold)

        if not buyableData[item_id] then
            return
        end

        local amount = buyableData[item_id][1]
        local level = buyableData[item_id][3]
        local price_dolar = buyableData[item_id][3]
        local price_gold = buyableData[item_id][3]

        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        print(item_id, gold)

        local ItemData = API.getItemDataFromId(tostring(item_id))

        local userlevel = User:getCharacter():getLevel()

        if userlevel < level then
            User:notify('Level insuficiente!')
            return
        end

        if gold ~= nil then   
            if Inventory:getItemAmount("generic_gold") < price_gold then
                User:notify("Dinheiro insuficiente!")
                return
            end
        else
            if Inventory:getItemAmount("generic_money") < price_dolar then
                User:notify("Dinheiro insuficiente!")
                return
            end
        end        

        if Inventory:getWeight() + (ItemData:getWeight() * 1) > Inventory:getCapacity() then
            User:notify("Mochila no limite de peso!")
            return
        end

        if gold ~= nil then             
            Inventory:addItem(item_id, amount)
            Inventory:removeItem("generic_gold", price_gold)   
        else
            Inventory:addItem(item_id, amount)
            Inventory:removeItem("generic_money", price_dolar) 
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
        local price_dolar = buyableData[item_id][3]
        local price_gold = buyableData[item_id][4]

        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local ItemData = API.getItemDataFromId(muni)

        if gold ~= nil then   
            if Inventory:getItemAmount("generic_gold") < price_gold then
                User:notify("Dinheiro insuficiente!")
                return
            end
        else
            if Inventory:getItemAmount("generic_money") < price_dolar then
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
            Inventory:removeItem("generic_gold", price_gold)   
        else
            Inventory:addItem(item_id, amount)
            Inventory:removeItem("generic_money", price_dolar) 
        end               

        User:notify(ItemData:getName() .. " comprado!")
    end
)
