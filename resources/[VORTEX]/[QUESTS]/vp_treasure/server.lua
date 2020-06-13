local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local PlayerCount = 0
local list = {}
local bauId = {}

local inventory_items = {
  [1] = {["pigeonpost"] = 5, ["bow"] = 1, ["ammo_arrow"] = 20, ["medicine_good"] = 3},
  [2] = {["pigeonpost"] = 5, ["rifle_boltaction"] = 1, ["raw_gold"] = 5, ["raw_copper"] = 2},
  [3] = {["revolver_cattleman"] = 5, ["bow"] = 1, ["ammo_arrow"] = 20},
  [4] = {["melee_lantern_electric"] = 1, ["thrown_dynamite"] = 2, ["gold"] = 100},
  [5] = {["lasso"] = 5, ["shotgun_repeating"] = 1, ["money"] = 5000},
  [6] = {["rifle_springfield"] = 5, ["shotgun_repeating"] = 1, ["money"] = 5000}
}

local TREASURE = {
  [1] = {-921.25, -1577.69, 66.03}, --blackwater
  [2] = {-575.34, 2033.95, 289.66}, -- montain tempest rim
  [3] = {-4360.701, -2511.478, 1.832}, -- CHOLLA SPRINGS
  [4] = {-5110.177, -3745.233, -3.292}, --   benedict point
  [5] = {1887.26, 279.11, 77.11}, -- EMERALD STATION
  [6] = {-758.89, -380.43, 41.96} -- dakota river
}

RegisterServerEvent("TREASURE:playerActivated")
function ActivateTreasure()
  if (PlayerCount) >= 1 then
    TriggerEvent("TREASURE:timeCall")
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

RegisterCommand(
  "callbau",
  function()
    local random = math.random(1, 6)
    TriggerEvent("TREASURE:create", random)
  end
)

RegisterNetEvent("TREASURE:timeCall")
AddEventHandler(
  "TREASURE:timeCall",
  function()
    local hora = 60000 * 60
    local horas = 60000 * 180
    local timeram = math.random(hora, horas)

    Wait(timeram)

    local random = math.random(1, 6)
    TriggerEvent("TREASURE:create", random)
  end
)

RegisterNetEvent("TREASURE:create")
AddEventHandler(
  "TREASURE:create",
  function(id)
    if not TREASURE[id] then
      return
    end
    local x = TREASURE[id][1]
    local y = TREASURE[id][2]
    local z = TREASURE[id][3]
    local Chest = API.getChestFromChestId(chest_id)

    local inventory_capacity = 20 -- A mesma que a de cima
    local yram = math.random(2, 50)
    local xram = math.random(2, 20)

    local itensram = math.random(1, 6)

    local parsed = {}

    for itemId, itemAmount in pairs(inventory_items[itensram]) do
      local i = math.random(112, 128)
      local tries = 16
      while parsed[i] ~= nil and tries > 0 do
        i = math.random(112, 128)
        tries = tries - 1
      end

      local itemData = API.getItemDataFromId(itemId)

      if itemData:getType() == "weapon" then
        parsed[i] = {itemId, itemAmount, 0, 1}
      else
        parsed[i] = {itemId, itemAmount}
      end
    end

    local chest_id = "e:" .. math.random(9999)
    local chest_Inventory = API.Inventory("chest:" .. chest_id, 20, parsed)
    chest_Inventory:setAutoSort(false)

    local Chest = API.Chest(chest_id)
    Chest:setPosition({x + xram, y + yram, z, 10.0})
    Chest:setInventory(0, chest_Inventory)
    Chest:cache() -- Se torna disponivel para sync com os clients

    bauId[chest_id] = true

    TriggerClientEvent("TREASURE:createPedDefender", GetHostId(), x + xram, y + yram, z)
    TriggerClientEvent("TREASURE:create", -1, x, y, z)
    TriggerEvent("TREASURE:timeCall")
  end
)

AddEventHandler(
  "VP:CHESTS:Open",
  function()
    if bauId[chest_id] ~= nil then
      TriggerClientEvent("TREASURE:killblip", GetHostId())
    end
  end
)
