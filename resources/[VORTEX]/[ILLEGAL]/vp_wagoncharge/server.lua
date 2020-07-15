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
  [1] = {487.083,-548.132,69.308}, --strawberry
 -- [2] = {-575.34, 2033.95, 289.66}, -- montain tempest rim
--  [3] = {-4360.701, -2511.478, 1.832}, -- CHOLLA SPRINGS
 -- [4] = {-5110.177, -3745.233, -3.292}, --   benedict point
  [2] = {487.083,-548.132,69.308}, -- EMERALD STATION
  [3] = {487.083,-548.132,69.308}, -- dakota river
  [4] = {487.083,-548.132,69.308},
  [5] = {487.083,-548.132,69.308},
  [6] = {487.083,-548.132,69.308}  
}

local DESTINYWAGON = {
  [1] = {-1311.280,382.569,95.536}, --strawberry
  [2] = {-1311.280,382.569,95.536}, -- montain tempest rim
  [3] = {-1311.280,382.569,95.536}, -- CHOLLA SPRINGS
  [5] = {-1311.280,382.569,95.536}, --   benedict point
  [6] = {-1311.280,382.569,95.536}, -- EMERALD STATION
  [7] = {-1311.280,382.569,95.536}, -- dakota river
  [8] = {-1311.280,382.569,95.536},
  [9] = {-1311.280,382.569,95.536},
  [10] = {-1311.280,382.569,95.536}  
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


  end
)

RegisterCommand('testeWagon', function()
  math.randomseed(GetGameTimer())
  local r1 = math.random(1, 6)
  local r2 = math.random(1, 10)
  TriggerEvent("VP:WAGONCHARGE:create", r1, r2)

end)


RegisterNetEvent("VP:WAGONCHARGE:create")
AddEventHandler(
  "VP:WAGONCHARGE:create",
  function(id, r2)

    if not SPAWNWAGON[id] then
      return      
    end

    if not DESTINYWAGON[r2] then
      return
    end
        --print(vector3(json.encode(SPAWNWAGON[id])), DESTINYWAGON[r2])

   --local itensram = math.random(1, 6)
    
    TriggerClientEvent("VP:WAGONCHARGE:StartNotify", -1)
    TriggerClientEvent("VP:WAGONCHARGE:StartMission", GetHostId(), vector3(table.unpack(SPAWNWAGON[id])), vector3(table.unpack(DESTINYWAGON[r2])))
  --  TriggerEvent("VP:WAGONCHARGE:timeCall")
  end
)

RegisterNetEvent("VP:WAGONCHARGE:finished")
AddEventHandler(
  "VP:WAGONCHARGE:finished",
  function(id)

    if not SPAWNWAGON[id] then
      return
    end

  end
)