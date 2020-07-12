local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local PlayerCount = 0
local list = {}

local reward_itens = {
  [1] = {["melee_hatchet_hunter_rusted"] = 2, ["bow"] = 1, ["ammo_arrow"] = 20, ["medicine_good"] = 3},
  [2] = {["melee_knife_vampire"] = 1, ["revolver_cattleman_john"] = 1, ["raw_gold"] = 5, ["stimulant_good"] = 2},
  [3] = {["revolver_cattleman"] = 3, ["bow"] = 2, ["ammo_arrow"] = 20},
  [4] = {["medicine_good"] = 1, ["repeater_henry"] = 2, ["gold"] = 100},
  [5] = {["lasso"] = 3, ["repeater_winchester"] = 1, ["money"] = 5000},
  [6] = {["rifle_springfield"] = 1, ["repeater_winchester"] = 1, ["money"] = 5000}
}

local SPAWNWAGON = {
  [1] = {-1629.949,-394.500,178.458}, --strawberry
 -- [2] = {-575.34, 2033.95, 289.66}, -- montain tempest rim
--  [3] = {-4360.701, -2511.478, 1.832}, -- CHOLLA SPRINGS
 -- [4] = {-5110.177, -3745.233, -3.292}, --   benedict point
  [2] = {1887.26, 279.11, 77.11}, -- EMERALD STATION
  [3] = {-758.89, -380.43, 41.96}, -- dakota river
  [4] = {1829.993, -1633.500, 45.707},
  [5] = {2336.198,-751.916,41.709},
  [6] = {1399.832,1320.947,164.975}  
}

local DESTINYWAGON = {
  [1] = {-1629.949,-394.500,178.458}, --strawberry
 -- [2] = {-575.34, 2033.95, 289.66}, -- montain tempest rim
--  [3] = {-4360.701, -2511.478, 1.832}, -- CHOLLA SPRINGS
 -- [4] = {-5110.177, -3745.233, -3.292}, --   benedict point
  [2] = {1887.26, 279.11, 77.11}, -- EMERALD STATION
  [3] = {-758.89, -380.43, 41.96}, -- dakota river
  [4] = {1829.993, -1633.500, 45.707},
  [5] = {2336.198,-751.916,41.709},
  [6] = {1399.832,1320.947,164.975}
  
}

RegisterServerEvent("VP:WAGONCHARGE:playerActivated")
function ActivateWAGONCHARGE()
  if (PlayerCount) >= 1 then
    TriggerEvent("VP:WAGONCHARGE:timeCall")
  else
    SetTimeout(1000, ActivateWAGONCHARGE)
  end
end

AddEventHandler(
  "VP:WAGONCHARGE:playerActivated",
  function()
    if not list[source] then
      PlayerCount = PlayerCount + 1
      list[source] = true
      if (PlayerCount) == 1 then
        SetTimeout(15000, ActivateWAGONCHARGE)
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

-- RegisterCommand(
--   "callbau",
--   function()
--     local random = math.random(1, 6)
--     TriggerEvent("VP:WAGONCHARGE:create", random)
--   end
-- )

RegisterNetEvent("VP:WAGONCHARGE:timeCall")
AddEventHandler(
  "VP:WAGONCHARGE:timeCall",
  function()
    local hora = 60000 * 60
    local TimeSpawnMax = hora * 10
    local TimeSpawnMin = hora * 6

    local timeram = math.random(TimeSpawnMin, TimeSpawnMax)

    print(timeram)    

    Wait(timeram)

    local random = math.random(1, 6)
    TriggerEvent("VP:WAGONCHARGE:create", random)
  end
)

RegisterNetEvent("VP:WAGONCHARGE:create")
AddEventHandler(
  "VP:WAGONCHARGE:create",
  function(id)

    if not SPAWNWAGON[id] then
      return
    end

    local x = SPAWNWAGON[id][1]
    local y = SPAWNWAGON[id][2]
    local z = SPAWNWAGON[id][3]

    local itensram = math.random(1, 6)
    
    TriggerClientEvent("VP:WAGONCHARGE:startMission", -1, x, y, z)
    TriggerClientEvent("VP:WAGONCHARGE:createWagon", GetHostId(), x + xram, y + yram, z, AnimalHash, Quantity)
    TriggerEvent("VP:WAGONCHARGE:timeCall")
  end

)