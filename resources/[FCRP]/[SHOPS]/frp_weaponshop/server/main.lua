local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local shopItems = {}

-- local weapons = {
--     [id] = {item_id, price, img},
--     [1] = {'weapon_melee_hatchet', 5, '/html/itens/weapon_combatpistol.png'},
--     [2] = {'weapon_thrown_throwing_knives', 2, '/html/itens/weapon_combatpistol.png'},
--     [3] = {'weapon_lasso', 30, '/html/itens/weapon_combatpistol.png'},
--     [4] = {'weapon_melee_torch', 5, '/html/itens/weapon_combatpistol.png'},
--     [5] = {'weapon_fishingrod', 15, '/html/itens/weapon_combatpistol.png'},
--     [6] = {'weapon_melee_electric_lantern', 10, '/html/itens/weapon_combatpistol.png'},
--     [7] = {'weapon_bow', 25, '/html/itens/weapon_combatpistol.png'},
--     [8] = {'weapon_revolver_cattleman', 20, '/html/itens/weapon_combatpistol.png'},
--     [9] = {'weapon_repeater_carbine', 80, '/html/itens/weapon_combatpistol.png'},
--     [10] = {'weapon_rifle_springfield', 120, '/html/itens/weapon_combatpistol.png'},
-- }

-- local ammo = {
--     [id] = {item_id, ammoAmount, price},
--     [1] = {'ammo_revolver', 20, 10},
--     [2] = {'ammo_pistol', 20, 15},
--     [3] = {'ammo_repeater', 10, 20},
--     [4] = {'ammo_rifle', 10, 25},
--     [5] = {'ammo_arrow', 20, 30},
--     [6] = {'ammo_shotgun', 10, 35},
-- }


RegisterNetEvent('FC:WEAPONSHOP:BuyWeapon')
AddEventHandler('FC:WEAPONSHOP:BuyWeapon', function(data)

    local itemId = data.itemId    
    local amount = data.amount
    local dolar = data.dolar
    local gold = data.gold

    print(itemId, amount, dolar, gold)
    if not data then
        return
    end
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

    local ItemData = API.getItemDataFromId(tostring(itemId))

    local level = User:getCharacter():getLevel()

    if level < tonumber(price*100) then
        print(Inventory:getItemAmount('generic_money'))
        User:notify('Dinheiro insuficiente!')
        TriggerClientEvent('Message:cancel', source)
        return
    end

    if Inventory:getItemAmount('generic_money') < tonumber(dolar) then
        print(Inventory:getItemAmount('generic_money'))
        User:notify('Dinheiro insuficiente!')
        return
    end

    if Inventory:getItemAmount('generic_gold') < tonumber(gold) then
        User:notify('Gold insuficiente!')
        return
    end

    if Inventory:getWeight() + (ItemData:getWeight() * 1) > Inventory:getCapacity() then
        User:notify('Mochila no limite de peso!')
        return
    end

    Inventory:addItem(itemId, tonumber(amount))
    Inventory:removeItem('generic_money', tonumber(dolar))
    Inventory:removeItem('generic_gold', tonumber(gold))
    User:notify(ItemData:getName() .. ' comprada!')
end)

RegisterNetEvent('FC:WEAPONSHOP:BuyAmmo')
AddEventHandler('FC:WEAPONSHOP:BuyAmmo', function(id)
    
    if not weapons[id] then
        return
    end

    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

    local muni = ammo[id][1]
    local amount = ammo[id][2]
    local price = ammo[id][3]

    local ItemData = API.getItemDataFromId(muni)

    if Inventory:getItemAmount('generic_money') < price then
        User:notify('Dinheiro insuficiente!')
        return
    end

    if Inventory:getWeight() + (ItemData:getWeight() * amount) > Inventory:getCapacity() then
        User:notify('Mochila no limite de peso!')
        return
    end

    Inventory:addItem(muni, amount)
    Inventory:removeItem('generic_money', price)
    User:notify(ItemData:getName() .. ' comprado!')
end)