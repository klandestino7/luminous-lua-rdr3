local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("VP:STABLE:UpdateHorseComponents")
AddEventHandler(
    "VP:STABLE:UpdateHorseComponents",
    function(components)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Horse = Character:getHorse()

        if Horse == nil then
            return
        end

        print(components)
        Horse:setComponents(components)
        cAPI.setHorseComponents(_source, components)
    end
)

RegisterNetEvent("VP:STABLE:AskForMyHorses")
AddEventHandler(
    "VP:STABLE:AskForMyHorses",
    function()
        print('VP:STABLE:AskForMyHorses')
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local horses = Character:getHorses() or {}

        if #horses <= 0 then
            return
        end

        local Horse = Character:getHorse()
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

        for k,v in pairs(horses) do
            print(k,v)
        end
        TriggerClientEvent("VP:STABLE:ReceiveHorsesData", _source, horses)
        -- TriggerClientEvent("VP:STABLE:callhorse", _source)
    end
)



RegisterNetEvent("VP:STABLE:BuyHorse")
AddEventHandler(
    "VP:STABLE:BuyHorse",
    function(data, name)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Horse = Character:getHorse()


       -- Character:setHorse(id)


        Character:createHorse(data, name)


    end
)
