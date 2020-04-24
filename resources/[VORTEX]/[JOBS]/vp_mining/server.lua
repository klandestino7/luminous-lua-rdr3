local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("VP:MINING:TryToStartMining")
AddEventHandler(
    "VP:MINING:TryToStartMining",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local a = Inventory:getItemAmount("pickaxe")
        local ItemData = API.getItemDataFromId("pickaxe")
        if a <= 0 then
            User:notify("Você nao possui uma " .. ItemData:getName())
        else
            TriggerClientEvent("VP:MINING:StartMiningAnimation", _source)
        end
    end
)

local weightTotal = 0
local r = {}

Citizen.CreateThread(
    function()
        r = {
            {"stone", 0.3, 5},
            {"raw_coal", 0.3, 5},
            {"raw_copper", 0.3, 5},
            {"raw_gold", 0.1, 2},
            {"ammolite", 0.01, 1},
            {"flourite", 0.01, 1}
        }

        weightTotal = 0

        for _, v in pairs(r) do
            weightTotal = weightTotal + v[2]
        end
    end
)

local found = {}

RegisterServerEvent("VP:MINING:CollectMineral")
AddEventHandler(
    "VP:MINING:CollectMineral",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        math.randomseed(os.time())

        local at = math.random() * weightTotal

        local where = 0
        for i, v in pairs(r) do
            if at < v[2] then
                where = i
                break
            end
            at = at - v[2]
        end

        local mineral_item = r[where][1]
        local itemData = API.getItemDataFromId(mineral_item)

        User:notify("Você achou " .. itemData:getName() .. "!")

        if found[_source] == nil then
            found[_source] = {}
        end

        local prev = found[_source][mineral_item] or 0

        found[_source][mineral_item] = prev + 1

        TriggerClientEvent("VP:MINING:DropMineral", _source, mineral_item)
    end
)

RegisterServerEvent("VP:MINING:TryToGetMineral")
AddEventHandler(
    "VP:MINING:TryToGetMineral",
    function(mineral_item)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        if not found[_source] or not found[_source][mineral_item] then
            return
        end

        local prev = found[_source][mineral_item]

        if prev > 1 then
            found[_source][mineral_item] = prev - 1
        else
            found[_source][mineral_item] = nil
            if #found[_source] <= 0 then
                found[_source] = nil
            end
        end

        local a = 0
        for i, v in pairs(r) do
            if mineral_item == v[1] then
                math.randomseed(os.time())
                a = math.random(v[3])
                break
            end
        end

        Inventory:addItem(mineral_item, a)
    end
)

RegisterServerEvent("VP:MINING:checkprocess")
AddEventHandler(
    "VP:MINING:checkprocess",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local pedra = Inventory:getItemAmount("generic_pedra")
        local pedraData = API.getItemDataFromId("generic_pedra")
        if pedra >= 1 then
            TriggerEvent("VP:MINING:checknum", _source, 1)
            User:notify("Você está processando " .. pedraData:getName())
            return
        end
        local carvao = Inventory:getItemAmount("generic_carvaobruto")
        local carvaoData = API.getItemDataFromId("generic_carvaobruto")
        if carvao >= 1 then
            TriggerEvent("VP:MINING:checknum", _source, 2)
            User:notify("Você está processando " .. carvaoData:getName())
            return
        end
        local cobre = Inventory:getItemAmount("generic_cobrebruto")
        local cobreData = API.getItemDataFromId("generic_cobrebruto")
        if cobre >= 1 then
            TriggerEvent("VP:MINING:checknum", _source, 3)
            User:notify("Você está processando " .. cobreData:getName())
            return
        end
        local ouro = Inventory:getItemAmount("generic_ourobruto")
        local ouroData = API.getItemDataFromId("generic_ourobruto")
        if ouro >= 3 then
            TriggerEvent("VP:MINING:checknum", _source, 4)
            User:notify("Você está processando " .. cobreData:getName())
            return
        -- else
        --     User:notify('Precisa de 3 ouro Bruto para minerar')
        --     return
        end
        -- TriggerClientEvent('VP:MINING:nothaveitem', _source)
        User:notify("Você não possuí item para minerar")
    end
)

RegisterServerEvent("VP:MINING:checknum")
AddEventHandler(
    "VP:MINING:checknum",
    function(source, num)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        if num == 0 or num == nil then
            User:notify("Erro no processamento")
            return
        end
        if num >= 4 or num == 0 then
            if Character:hasGroup("ourives") then
            else
                User:notify("Você não pode processar esse minério")
                return
            end
        end
        TriggerClientEvent("VP:MINING:processanim", _source, num)
    end
)

RegisterServerEvent("VP:MINING:processitem")
AddEventHandler(
    "VP:MINING:processitem",
    function(num)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local Character = User:getCharacter()
        local count = math.random(1, 5)

        if num == 1 then
            Inventory:removeItem("generic_pedra", 1)
            User:notify("Você processou [X" .. count .. "] pedras")
            Wait(1000)
            Inventory:addItem("generic_pedralavada", count)
            User:notify("Você recebeu [X" .. count .. "] de Pedra Lavada")
            return
        end
        if num == 2 then
            Inventory:removeItem("generic_carvaobruto", 1)
            User:notify("Você processou [X1] de Carvão")
            Wait(1000)
            Inventory:addItem("generic_carvaorefi", count)
            User:notify("Você recebeu [X" .. count .. "] de Carvão Refinado")
            return
        end
        if num == 3 then
            Inventory:removeItem("generic_cobrebruto", 1)
            User:notify("Você processou [X" .. count .. "] de cobre")
            Wait(1000)
            Inventory:addItem("generic_provision_disco_ammolite", count)
            User:notify("Você recebeu [X" .. count .. "] de Barra de Cobre")
            return
        end
        if num == 4 then
            Inventory:removeItem("generic_ourobruto", 3)
            User:notify("Você processou [X" .. count .. "] ouro")
            Wait(1000)
            print(count * 10)
            Inventory:addItem("generic_gold", count * 10)
            User:notify("Você recebeu [X" .. count .. "] de Ouro")
            return
        end
    end
)
