local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local sellables = {
    [-2011226991] = 175, -- eastern wild turkey black
    [-466054788] = 175, -- eastern wild turkey white
    [1458540991] = 200, -- Racoon
    [90267823] = 300, -- Cougar
    [1110710183] = 500, -- whitetail deer
    [-1963605336] = 500, -- whitetail buck
    [480688259] = 300,  -- california valley coyote
    [-1414989025] = 175, -- virginia opossum
    [-2063183075] = 175, -- Dominique Chicken
    [-1170118274] = 175, -- American Badger
    [-1458540991] = 200, -- North American Raccoon
    [1755643085] = 500,  -- American Pronghorn Doe
    [-1464167925] = 175,  -- Southern Copperhead Snake
    [-723190474] = 175, -- Canada Goose
    [-8651544272] = 150, -- Great Horned Owl
    [-1465438313] = 300,  -- American Red Squirrel
    [-1568716381] = 500, -- Rocky Mountain Bighorn Ram
    [-885451903] = 175, -- Timber Wolf
    [-541762431] = 175, -- Black-Tailed Jackrabbit
    [252669332] = 125,-- American Red Fox
    [-861544272] = 200, -- Coastal Horned Owl
    [-1003616053] = 200, -- Pekin Duck
    [-829273561] = 300, -- gray wolf
    [-885451903] = 300,  -- gray wolf
    [-1143398950] = 300, -- gray wolf
    [-214589097] = 300, -- Red-Tailed Hawk
    [-2145890973] = 300, -- ferruginous hawk
}

RegisterNetEvent("VP:BUTCHER:TryToSell")
AddEventHandler(
    "VP:BUTCHER:TryToSell",
    function(entType, entModel, entity, quality)
        local _source = source
        
        local payment = sellables[entModel]

        if payment == nil then
            TriggerClientEvent('VP:BUTCHER:EntityNotAccepted', _source, entity)
            print('nao vendivel')
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        Inventory:addItem('money', payment)

        local text = 'este animal'
    
        if entType == 3 then
            text = 'esta pele'
        end

        User:notify('Você recebeu $' .. payment .. ' por ' .. text .. '!')
        TriggerClientEvent('VP:BUTCHER:EntityAccepted', _source, entity)
    end
)
