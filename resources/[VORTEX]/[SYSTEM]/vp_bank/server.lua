local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("VP:BANKING:withdraw")
AddEventHandler(
    "VP:BANKING:withdraw",
    function(amount)
        local _source = source
        local base = 0
        local _amount = tonumber(amount * 100)

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = User:getCharacter():getInventory()
        local call = json.decode(Character:getData(Character:getId(), "charTable", "banco"))

        if amount ~= nil then
            if _amount == nil or _amount <= 0 or _amount > tonumber(call) then
                User:notify("error", "Quantia inválida!")
                return
            else
                Character:setData(Character:getId(), "charTable", "banco", tonumber(call - (amount * 100)))
                Wait(100)
                Inventory:addItem("money", amount * 100)
                User:notify("dollar", amount)
                Wait(100)
                -- TriggerClientEvent("redemrp_notification:start",_source, "Withdrawal made.." , 2, "success")
                Wait(1000)
                TriggerEvent("VP:BANKING:balance", _source)
            end
        end
    end
)

RegisterServerEvent("VP:BANKING:deposit")
AddEventHandler(
    "VP:BANKING:deposit",
    function(amount)
        local _source = source
        local base = 0
        local _amount = tonumber(amount * 100)
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = User:getCharacter():getInventory()
        local call = json.decode(Character:getData(Character:getId(), "charTable", "banco"))
        if amount ~= nil then
            if _amount == nil or _amount <= 0 or _amount > Inventory:getItemAmount("money") then
                User:notify("error", "Quantia inválida!")
                return
            else
                Character:setData(Character:getId(), "charTable", "banco", tonumber(call + (amount * 100)))
                Wait(100)
                Inventory:removeItem(-1, "money", amount * 100)
                User:notify("dollar", -(amount))
                Wait(100)
                -- TriggerClientEvent("redemrp_notification:start",_source, "Withdrawal made.." , 2, "success")
                Wait(1000)
                TriggerEvent("VP:BANKING:balance", _source)
            end
        end
    end
)

RegisterServerEvent("VP:BANKING:balance")
AddEventHandler(
    "VP:BANKING:balance",
    function(source)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local call = json.decode(Character:getData(Character:getId(), "charTable", "banco"))
        TriggerClientEvent("currentbalance1", _source, tonumber(call / 100), Character:getName())
    end
)

RegisterServerEvent("VP:BANKING:balance2")
AddEventHandler(
    "VP:BANKING:balance2",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local call = json.decode(Character:getData(Character:getId(), "charTable", "banco"))
        TriggerClientEvent("currentbalance1", _source, tonumber(call / 100), Character:getName())
    end
)

RegisterCommand(
    "pagar",
    function(source, args)
        local playersend
        tonumber(args[1])
        local amount = tonumber(args[2])

        if amount ~= nil and playersend ~= nil then
            TriggerServerEvent("VP:BANKING:sendmoney", source, playersend, amount)
        else
            TriggerClientEvent("chat:addMessage", source, {args = {"^1SYSTEMA", "ID ou Valor Inválido."}})
        end
    end
)

RegisterServerEvent("VP:BANKING:sendmoney")
AddEventHandler(
    "VP:BANKING:sendmoney",
    function(source, id, amount)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local name = Character:getName()
        local Inventory = User:getCharacter():getInventory()
        local call = json.decode(Character:getData(Character:getId(), "charTable", "banco"))
        local tplayer = API.getUserFromUserId(parseInt(id)):getSource()
        local tname = tplayer:getName()
        if amount ~= nil then
            if _amount == nil or _amount <= 0 or _amount > tonumber(call) then
                User:notify("error", "Quantia inválida!")
                return
            else
                Character:setData(Character:getId(), "charTable", "banco", tonumber(call - (amount * 100)))
                Wait(100)
                Inventory:removeItem(-1, "money", amount * 100)
                User:notify("dollar", -(amount))
                Wait(500)
                TriggerClientEvent("VP:BANKING:sendmoney", tplayer, amount, name)
                TriggerClientEvent("chatMessage", source, "^1SISTEMA", {255, 255, 255}, "Você deu " .. amount * 100 .. " para " .. tname .. "")
            end
        end
    end
)

RegisterServerEvent("VP:BANKING:recmoney")
AddEventHandler(
    "VP:BANKING:recmoney",
    function(source, amount, name)
        local _name = name
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = User:getCharacter():getInventory()

        if Character ~= nil then
            Inventory:addItem("money", amount * 100)
            TriggerClientEvent("chatMessage", source, "^1SISTEMA", {255, 255, 255}, "Você recebeu $" .. amount * 100 .. " de " .. _name .. "")
        end
    end
)
