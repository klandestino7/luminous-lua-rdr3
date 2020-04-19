local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local number = {}


--GET INVENTORY ITEM
ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getInventory', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local items   = xPlayer.inventory

  cb({items = items})

end)

--Removes item from shop
RegisterServerEvent('FRP:ADVANCEDSHOPs:RemoveItemFromShop')
AddEventHandler('FRP:ADVANCEDSHOPs:RemoveItemFromShop', function(number, count, item)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local identifier =  ESX.GetPlayerFromId(src).identifier

        MySQL.Async.fetchAll(
        'SELECT count, item FROM shops WHERE item = @item AND ShopNumber = @ShopNumber',
        {
            ['@ShopNumber'] = number,
            ['@item'] = item,
        },
        function(data)

            if count > data[1].count then

                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~You can\' t take out more than you own')
                else

                if data[1].count ~= count then

                    MySQL.Async.fetchAll("UPDATE shops SET count = @count WHERE item = @item AND ShopNumber = @ShopNumber",
                    {
                        ['@item'] = item,
                        ['@ShopNumber'] = number,
                        ['@count'] = data[1].count - count
                    }, function(result)
                    
                    xPlayer.addInventoryItem(data[1].item, count)
                end)
    
                elseif data[1].count == count then

                    MySQL.Async.fetchAll("DELETE FROM shops WHERE item = @name AND ShopNumber = @Number",
                    {
                        ['@Number'] = number,
                        ['@name'] = data[1].item
                    })

                    xPlayer.addInventoryItem(data[1].item, count)
            end
        end
    end)
end)


--Setting selling items.
RegisterServerEvent('FRP:ADVANCEDSHOPs:setToSell')
AddEventHandler('FRP:ADVANCEDSHOPs:setToSell', function(id, Item, ItemCount, Price)
  local xPlayer = ESX.GetPlayerFromId(source)
  local GetItem = xPlayer.getInventoryItem(Item)


  MySQL.Async.fetchAll(
    'SELECT label, name FROM items WHERE name = @item',
    {
        ['@item'] = Item,
    },
    function(items)
    
      MySQL.Async.fetchAll(
        'SELECT price, count FROM shops WHERE item = @items AND ShopNumber = @ShopNumber',
        {
            ['@items'] = Item,
            ['@ShopNumber'] = id,
        },
        function(data)

        if data[1] == nil then
            imgsrc = 'img/box.png'

            for i=1, #Config.Images, 1 do
                if Config.Images[i].item == Item then
                    imgsrc = Config.Images[i].src
                end
            end

            MySQL.Async.execute('INSERT INTO shops (ShopNumber, src, label, count, item, price) VALUES (@ShopNumber, @src, @label, @count, @item, @price)',
            {
                ['@ShopNumber']    = id,
                ['@src']        = imgsrc,
                ['@label']         = items[1].label,
                ['@count']         = ItemCount,
                ['@item']          = items[1].name,
                ['@price']         = Price
            })

            xPlayer.removeInventoryItem(Item, ItemCount)

            elseif data[1].price == Price then
            
                MySQL.Async.fetchAll("UPDATE shops SET count = @count WHERE item = @name AND ShopNumber = @ShopNumber",
                {
                    ['@name'] = Item,
                    ['@ShopNumber'] = id,
                    ['@count'] = data[1].count + ItemCount
                }
                )
                xPlayer.removeInventoryItem(Item, ItemCount)


            elseif data ~= nil and data[1].price ~= Price then
                Wait(250)
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~You already have a same item in your shop, ~r~but for ' .. data[1].price .. '. you put the price ' .. Price)
                Wait(250)
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Remove the item and put a new price or put the same price')
            end
        end)  
    end)
end)

-- BUYING PRODUCT
RegisterServerEvent('FRP:ADVANCEDSHOPs:Buy')
AddEventHandler('FRP:ADVANCEDSHOPs:Buy', function(id, Item, ItemCount)
  local src = source
  local identifier = ESX.GetPlayerFromId(src).identifier
  local xPlayer = ESX.GetPlayerFromId(src)

        local ItemCount = tonumber(ItemCount)

        MySQL.Async.fetchAll(
        'SELECT * FROM shops WHERE ShopNumber = @Number AND item = @item',
        {
            ['@Number'] = id,
            ['@item'] = Item,
        }, function(result)

    
        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE ShopNumber = @Number',
        {
            ['@Number'] = id,
        }, function(result2)

            if xPlayer.getMoney() < ItemCount * result[1].price then
                TriggerClientEvent('esx:showNotification', src, '~r~You don\'t have enough money.')
            elseif ItemCount <= 0 then
                TriggerClientEvent('esx:showNotification', src, '~r~invalid quantity.')
            else
                xPlayer.removeMoney(ItemCount * result[1].price)
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~You bought ' .. ItemCount .. 'x ' .. Item .. ' for $' .. ItemCount * result[1].price)
                xPlayer.addInventoryItem(result[1].item, ItemCount)

                MySQL.Async.execute("UPDATE owned_shops SET money = @money WHERE ShopNumber = @Number",
                {
                    ['@money']      = result2[1].money + (result[1].price * ItemCount),
                    ['@Number']     = id,
                })
    

                if result[1].count ~= ItemCount then
                    MySQL.Async.execute("UPDATE shops SET count = @count WHERE item = @name AND ShopNumber = @Number",
                    {
                        ['@name'] = Item,
                        ['@Number'] = id,
                        ['@count'] = result[1].count - ItemCount
                    })
                elseif result[1].count == ItemCount then
                    MySQL.Async.fetchAll("DELETE FROM shops WHERE item = @name AND ShopNumber = @Number",
                    {
                        ['@Number'] = id,
                        ['@name'] = result[1].item
                    })
                end
            end
        end)
    end)
end)

--CALLBACKS
ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getShopList', function(source, cb)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)

        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE identifier = @identifier',
        {
            ['@identifier'] = '0',
        }, function(result)

      cb(result)
    end)
end)


ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getOwnedBlips', function(source, cb)

        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE NOT identifier = @identifier',
        {
            ['@identifier'] = '0',
        }, function(results)
        cb(results)
    end)
end)

ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getAllShipments', function(source, cb, id)
  local identifier = ESX.GetPlayerFromId(source).identifier

        MySQL.Async.fetchAll(
        'SELECT * FROM shipments WHERE id = @id AND identifier = @identifier',
        {
            ['@id'] = id,
            ['@identifier'] = identifier,
        }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getTime', function(source, cb)
    cb(os.time())
end)

ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getOwnedShop', function(source, cb, id)
local src = source
local identifier = ESX.GetPlayerFromId(src).identifier

        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber AND identifier = @identifier',
        {
            ['@ShopNumber'] = id,
            ['@identifier'] = identifier,
        }, function(result)

        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getShopItems', function(source, cb, number)
  local identifier = ESX.GetPlayerFromId(source).identifier
  
        MySQL.Async.fetchAll('SELECT * FROM shops WHERE ShopNumber = @ShopNumber',
        {
            ['@ShopNumber'] = number
        }, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('FRP:ADVANCEDSHOPs:GetAllItems')
AddEventHandler('FRP:ADVANCEDSHOPs:GetAllItems', function(id)
    local _source = source
    local identifier = ESX.GetPlayerFromId(_source).identifier
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll(
    'SELECT * FROM shipments WHERE id = @id AND identifier = @identifier',
    {
        ['@id'] = id,
        ['@identifier'] = identifier
    }, function(result)

        for i=1, #result, 1 do
            xPlayer.addInventoryItem(result[i].item, result[i].count)
            MySQL.Async.fetchAll('DELETE FROM shipments WHERE id = @id AND identifier = @identifier',{['@id'] = id,['@identifier'] = identifier,})
        end
    end)
end)


RegisterServerEvent('FRP:ADVANCEDSHOPs-robbery:UpdateCanRob')
AddEventHandler('FRP:ADVANCEDSHOPs-robbery:UpdateCanRob', function(id)
    MySQL.Async.fetchAll("UPDATE owned_shops SET LastRobbery = @LastRobbery WHERE ShopNumber = @ShopNumber",{['@ShopNumber'] = id,['@LastRobbery']    = os.time(),})
end)

RegisterServerEvent('FRP:ADVANCEDSHOP:MakeShipment')
AddEventHandler('FRP:ADVANCEDSHOP:MakeShipment', function(id, item, price, count, label)
  local _source = source
  local identifier = ESX.GetPlayerFromId(_source).identifier

    MySQL.Async.fetchAll('SELECT money FROM owned_shops WHERE ShopNumber = @ShopNumber AND identifier = @identifier',{['@ShopNumber'] = id,['@identifier'] = identifier,}, function(result)

        if result[1].money >= price * count then

            MySQL.Async.execute('INSERT INTO shipments (id, label, identifier, item, price, count, time) VALUES (@id, @label, @identifier, @item, @price, @count, @time)',{['@id']       = id,['@label']      = label,['@identifier'] = identifier,['@item']       = item,['@price']      = price,['@count']      = count,['@time']       = os.time()})
            MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE ShopNumber = @ShopNumber",{['@ShopNumber'] = id,['@money']    = result[1].money - price * count,})  
            TriggerClientEvent('esx:showNotification', _source, '~g~You ordered' .. count .. ' pieces ' .. label .. ' for $' .. price * count)
        else
            TriggerClientEvent('esx:showNotification', _source, '~r~You don\'t have enough money in your shop.')
        end
    end)
end)

RegisterServerEvent('FRP:ADVANCEDSHOPs:BuyShop')
AddEventHandler('FRP:ADVANCEDSHOPs:BuyShop', function(name, price, number, hasbought)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local identifier = ESX.GetPlayerFromId(source).identifier

    MySQL.Async.fetchAll(
    'SELECT identifier FROM owned_shops WHERE ShopNumber = @ShopNumber',
    {
      ['@ShopNumber'] = number,
    }, function(result)

    if result[1].identifier == '0' then

        if xPlayer.getMoney() >= price then
            MySQL.Async.fetchAll("UPDATE owned_shops SET identifier = @identifier, ShopName = @ShopName WHERE ShopNumber = @ShopNumber",{['@identifier']  = identifier,['@ShopNumber']     = number,['@ShopName']     = name},function(result)
            xPlayer.removeMoney(price)
        end)
            TriggerClientEvent('FRP:ADVANCEDSHOPs:removeBlip', -1)
            TriggerClientEvent('FRP:ADVANCEDSHOPs:setBlip', -1)
            TriggerClientEvent('esx:showNotification', _source, '~gYou bought a shop for $' ..  price)
        else    
            TriggerClientEvent('esx:showNotification', _source, '~r~You can\'t afford this shop')
        end

    else
        TriggerClientEvent('esx:showNotification', _source, '~r~You can\'t afford this shop')
        end
    end)
end)


--BOSS MENU STUFF
RegisterServerEvent('FRP:ADVANCEDSHOPs:addMoney')
AddEventHandler('FRP:ADVANCEDSHOPs:addMoney', function(amount, number)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local identifier = ESX.GetPlayerFromId(source).identifier

    MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @Number',
        {
          ['@identifier'] = identifier,
          ['@Number'] = number,
        },
        function(result)
          
        if os.time() - result[1].LastRobbery <= 900 then
            time = os.time() - result[1].LastRobbery
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Your shop money has been locked due to robbery, please wait ' .. math.floor((900 - time) / 60) .. ' minutes')
            return
        end

        if xPlayer.getMoney() >= amount then

            MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE identifier = @identifier AND ShopNumber = @Number",
            {
                ['@money']      = result[1].money + amount,
                ['@Number']     = number,
                ['@identifier'] = identifier
            })
            xPlayer.removeMoney(amount)
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~You put in $' .. amount .. ' in your shop')
        else
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~You can\'t put in more than you own')
        end
    end)
end)

RegisterServerEvent('FRP:ADVANCEDSHOPs:takeOutMoney')
AddEventHandler('FRP:ADVANCEDSHOPs:takeOutMoney', function(amount, number)
local src = source
local identifier = ESX.GetPlayerFromId(src).identifier
local xPlayer = ESX.GetPlayerFromId(src)


  MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @Number',
    {
      ['@identifier'] = identifier,
      ['@Number'] = number,
    },

    function(result)

    if os.time() - result[1].LastRobbery <= 900 then
        time = os.time() - result[1].LastRobbery
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Your shop money has been locked due to robbery, please wait ' .. math.floor((900 - time) / 60) .. ' minutes')
        return
    end
      
        if result[1].money >= amount then
            MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE identifier = @identifier AND ShopNumber = @Number",
            {
                ['@money']      = result[1].money - amount,
                ['@Number']     = number,
                ['@identifier'] = identifier
            })
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~You took out $' .. amount .. ' from your shop')
            xPlayer.addMoney(amount)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~You can\'t put in more than you own')
        end
        
    end)
end)


RegisterServerEvent('FRP:ADVANCEDSHOPs:changeName')
AddEventHandler('FRP:ADVANCEDSHOPs:changeName', function(number, name)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)
      MySQL.Async.fetchAll("UPDATE owned_shops SET ShopName = @Name WHERE identifier = @identifier AND ShopNumber = @Number",
      {
        ['@Number'] = number,
        ['@Name']     = name,
        ['@identifier'] = identifier
      })
      TriggerClientEvent('FRP:ADVANCEDSHOPs:removeBlip', -1)
      TriggerClientEvent('FRP:ADVANCEDSHOPs:setBlip', -1)
end)

RegisterServerEvent('FRP:ADVANCEDSHOPs:SellShop')
AddEventHandler('FRP:ADVANCEDSHOPs:SellShop', function(number)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @ShopNumber',
    {
      ['@identifier'] = identifier,
      ['@ShopNumber'] = number,
    },
    function(result)
      MySQL.Async.fetchAll(
        'SELECT * FROM shops WHERE ShopNumber = @ShopNumber',
        {
          ['@ShopNumber'] = number,
        },
        function(result2)

      if result[1].money == 0 and result2[1] == nil then
        MySQL.Async.fetchAll("UPDATE owned_shops SET identifier = @identifiers, ShopName = @ShopName WHERE identifier = @identifier AND ShopNumber = @Number",
        {
            ['@identifiers'] = '0',
            ['@identifier'] = identifier,
            ['@ShopName']    = '0',
            ['@Number'] = number,
        })
            xPlayer.addMoney(result[1].ShopValue / 2)
            TriggerClientEvent('FRP:ADVANCEDSHOPs:removeBlip', -1)
            TriggerClientEvent('FRP:ADVANCEDSHOPs:setBlip', -1)
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~You sold your shop')
            else
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~You can\'t sell your shop with items or money inside of it')
            end
        end)
    end)
end)

ESX.RegisterServerCallback('FRP:ADVANCEDSHOP:getUnBoughtShops', function(source, cb)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE identifier = @identifier',
    {
      ['@identifier'] = '0',
    },
    function(result)

        cb(result)
    end)
end)

ESX.RegisterServerCallback('FRP:ADVANCEDSHOP-robbery:getOnlinePolices', function(source, cb)
  local _source  = source
  local xPlayers = ESX.GetPlayers()
  local cops = 0

    for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
        cops = cops + 1
        end
    end
    Wait(25)
    cb(cops)
end)

ESX.RegisterServerCallback('FRP:ADVANCEDSHOP-robbery:getUpdates', function(source, cb, id)

    MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber',
    {
     ['@ShopNumber'] = id,
    },
     function(result)

        if result[1].LastRobbery == 0 then
            id = id
            MySQL.Async.fetchAll("UPDATE owned_shops SET LastRobbery = @LastRobbery WHERE ShopNumber = @ShopNumber",
            {
            ['@ShopNumber'] = id,
            ['@LastRobbery']   = os.time(),
            })
        else
            if os.time() - result[1].LastRobbery >= Config.TimeBetweenRobberies then
                cb({cb = true, time = os.time() - result[1].LastRobbery, name = result[1].ShopName})
            else
                cb({cb = nil, time = os.time() - result[1].LastRobbery})
            end
        end
    end)
end)


RegisterServerEvent('FRP:ADVANCEDSHOPs-robbery:GetReward')
AddEventHandler('FRP:ADVANCEDSHOPs-robbery:GetReward', function(id)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)


        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber',
        {
            ['@ShopNumber'] = id,
        }, function(result)

        id = id
        
        MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE ShopNumber = @ShopNumber",
        {
            ['@ShopNumber'] = id,
            ['@money']     = result[1].money - result[1].money / Config.CutOnRobbery,
        })
        id = id

        xPlayer.addMoney(result[1].money / Config.CutOnRobbery)
    end)
end)

RegisterServerEvent('FRP:ADVANCEDSHOPs-robbery:NotifyOwner')
AddEventHandler('FRP:ADVANCEDSHOPs-robbery:NotifyOwner', function(msg, id)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)

    for i=1, #ESX.GetPlayers(), 1 do
        local identifier = ESX.GetPlayerFromId(ESX.GetPlayers()[i])
  
            MySQL.Async.fetchAll(
            'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber',
            {
                ['@ShopNumber'] = id,
            }, function(result)

            if result[1].identifier == identifier.identifier then
                TriggerClientEvent('esx:showNotification', identifier.source, msg)
            end

        end)
    end
end)
