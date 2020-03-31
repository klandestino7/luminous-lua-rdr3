local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local prices = {
    ['A_C_HORSE_TENNESSEEWALKER_CHESTNUT'] = {
        priceMoney = 40,
        priceGold = 1
    },
    ['A_C_HORSE_SHIRE_RAVENBLACK'] = {
        priceMoney = 60,
        priceGold = 1
    },
    ['A_C_HORSE_APPALOOSA_LEOPARD]'] = {
        priceMoney = 100,
        priceGold = 2
    },
    ['A_C_HORSE_GANG_BILL'] = {
        priceMoney = 150,
        priceGold = 10
    },
    ['A_C_HORSE_KENTUCKYSADDLE_BLACK'] = {
        priceMoney = 35,
        priceGold = 1
    },
    ['A_C_HORSE_THOROUGHBRED_BRINDLE'] = {
        priceMoney = 150,
        priceGold = 10
    },
    ['A_C_HORSE_TURKOMAN_DARKBAY'] = {
        priceMoney = 3500,
        priceGold = 30
    },
    ['A_C_HORSE_ARABIAN_BLACK'] = {
        priceMoney = 7000,
        priceGold = 70
    },
    ['A_C_HORSE_ARABIAN_ROSEGREYBAY'] = {
        priceMoney = 10000,
        priceGold = 10
    },
    ['A_C_HORSE_MUSTANG_GRULLODUN'] = {
        priceMoney = 250,
        priceGold = 2
    },
    ['A_C_HORSE_MUSTANG_WILDBAY'] = {
        priceMoney = 250,
        priceGold = 2
    },
    ['A_C_HORSE_MISSOURIFOXTROTTER_AMBERCHAMPAGNE'] = {
        priceMoney = 350,
        priceGold = 3
    },
    ['A_C_HORSE_TURKOMAN_GOLD'] = {
        priceMoney = 3500,
        priceGold = 35
    },
    ['A_C_HORSE_AMERICANSTANDARDBRED_PALOMINODAPPLE'] = {
        priceMoney = 350,
        priceGold = 3
    }
}

RegisterNetEvent('FCRP:HORSESHOP:Buy')
AddEventHandler(
    'FCRP:HORSESHOP:Buy',
    function(model, name)
        if not prices[model] then
            return
        end

        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        print('User ' .. User:getId() .. ' tentou comprar um cavalo (' .. model .. ',' .. name .. ')')

     

        if Character:getHorses() ~= nil then
            if #Character:getHorses() > nil then
                User:notify('Limite de cavalos alcançado.')
                return
            end
        end

        local priceMoney = prices[model].priceMoney
        local priceGold = prices[model].priceGold
        print(priceMoney)

        if Character:getInventory():removeItem('generic_money', priceMoney) or Character:getInventory():removeItem('generic_gold', priceGold) then
            Character:createHorse(model, name)
            User:notify('Você comprou o ' .. name .. ' por ' .. priceMoney or priceGold)
        else
            User:notify('Você não tem dolar ou outro suficiente.')
        end
    end
)

RegisterNetEvent('FCRP:HORSESHOP:AskForMyHorses')
AddEventHandler(
    'FCRP:HORSESHOP:AskForMyHorses',
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local horses = Character:getHorses() or {}

        if #horses <= 0 then
            return
        end

        local Horse = Character:getHorse()
        Horse:getId() 
        local selectedHorseId
        if Horse ~= nil then
            selectedHorseId = Horse:getId() 
        end

        for _, data in pairs(horses) do

            if selectedHorseId ~= nil and data.id == selectedHorseId then
                data.selected = true
            end

            data.charid = nil
        end

        TriggerClientEvent('FCRP:HORSESHOP:ReceiveHorsesData', _source, horses)
    end
)

RegisterNetEvent('FCRP:HORSESHOP:SelectHorseWithId')
AddEventHandler(
    'FCRP:HORSESHOP:SelectHorseWithId',
    function(horseId)
    
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Horse = Character:setHorse(horseId)
        if Horse then
            cAPI.setHorse(User:getSource(), Horse:getModel(), Horse:getName(), Horse:getComponents())   
        end
    end
)