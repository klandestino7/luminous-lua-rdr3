local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local PlayerCount = 0
local list = {}
local bauId = {}

local inventory_items = {
   [1] = {['consumable_apple'] = 5, ['weapon_bow'] = 1, ['ammo_arrow'] = 20,  ['tonic_medicine'] = 500},
   [2] = {['consumable_apple'] = 5, ['weapon_rifle_boltaction'] = 1,  ['generic_provision_rf_wood_minor'] = 5, ['generic_cobrebruto'] = 2},
   [3] = {['weapon_revolver_cattleman'] = 5, ['weapon_bow'] = 1,  ['ammo_arrow'] = 20},
   [4] = {['weapon_melee_lantern_electric'] = 1, ['weapon_thrown_dynamite'] = 2,  ['generic_gold'] = 100},
   [5] = {['weapon_lasso'] = 5, ['weapon_shotgun_repeating'] = 1,  ['generic_money'] = 500},
   [6] = {['weapon_rifle_springfield'] = 5, ['weapon_shotgun_repeating'] = 1,  ['generic_money'] = 500}
}

local TREASURE = {
    [1] = {-921.25,-1577.69,66.03}, --val
    [2] = {-921.25,-1577.69,66.03},  --blackwater
    [3] = {-921.25,-1577.69,66.03},  --rhodes
    [4] = {-921.25,-1577.69,66.03},  --strawberry
    [5] = {-921.25,-1577.69,66.03},  --tumbleweed
    [6] = {-921.25,-1577.69,66.03},  --saintdenis
}

RegisterServerEvent("TREASURE:playerActivated")
function ActivateTreasure()
  if (PlayerCount) == 1 then
    local random = math.random(1, 6)
    TriggerEvent("TREASURE:create", random)
  else
    SetTimeout(1000, ActivateTreasure)
  end
end

AddEventHandler(
  "TREASURE:playerActivated",
  function()
    if not list[source] then
      PlayerCount = PlayerCount + 1
      list[source] = true
      if (PlayerCount) == 1 then
        SetTimeout(15000, ActivateTreasure)
      end
    end
  end
)

AddEventHandler(
  "playerDropped",
  function()
    if list[source] then
      PlayerCount = PlayerCount - 1
      list[source] = nil
    end
  end
)


RegisterNetEvent('TREASURE:timeCall')
AddEventHandler('TREASURE:timeCall', function()

    local hora = 60000*60
    local horas = 60000*180
    local timeram = math.random(hora,horas)

    Wait(timeram)

    local random = math.random(1, 6)
    TriggerEvent("TREASURE:create", random)
end)

RegisterNetEvent('TREASURE:create')
AddEventHandler('TREASURE:create', function(id)
    if not TREASURE[id] then
        return
    end
    local x = TREASURE[id][1]
    local y = TREASURE[id][2]
    local z = TREASURE[id][3] 
    local Chest = API.getChestFromChestId(chest_id)

    local chest_id = 'e.' .. math.random(9999)
    local chest_owner_id = 0 -- Não tem dono, então o id é 0, irrelevante
    local chest_type = 0 -- Global, os items são sempre os mesmos
    local chest_capacity = 20 -- Capacidade maxima de peso
    local chest_group = nil -- Grupo necessaria para abrir o baú(nenhum)
    local inventory_id = nil
    local inventory_capacity = 20 -- A mesma que a de cima        
    local yram = math.random(2, 50)
    local xram = math.random(2, 20)

    chest_position = {x,y,z,10.0}

    local itensram = math.random(1, 6)

    local chest_Inventory = API.Inventory(inventory_id, inventory_capacity, inventory_items[itensram])
    local Chest = API.Chest(chest_id, chest_owner_id, chest_position, chest_type, chest_capacity, chest_Inventory, chest_group)
    Chest:cache() -- Se torna disponivel para sync com os clients

    bauId[chest_id] = true

    TriggerClientEvent("TREASURE:createPedDefender", GetHostId(), x,y,z)   
    TriggerClientEvent("TREASURE:create", GetHostId(), x+xram,y+yram,z) 
    TriggerEvent("TREASURE:timeCall")       
end)


AddEventHandler('FCRP:CHESTS:Open', function()
    if bauId[chest_id] ~= nil then
        TriggerClientEvent("TREASURE:killblip", GetHostId())
    end
end)
