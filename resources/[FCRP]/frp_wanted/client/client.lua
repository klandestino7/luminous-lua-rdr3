local towns = {
    [1] = { ["distance"] = 160.0, ["x"] = -300.00, ["y"] = 790.00, ["z"] = 117.00, ["name"] = "Valentine"},
    [2] = { ["distance"] = 60.0, ["x"] = -1790.00, ["y"] = -404.00, ["z"] = 117.00, ["name"] = "Strawberry"},
    [3] = { ["distance"] = 60.0, ["x"] = -812.00, ["y"] = -1294.00, ["z"] = 61.00, ["name"] = "Blackwater"},
    [4] = { ["distance"] = 60.0, ["x"] = -3676.00, ["y"] = -2601.00, ["z"] = 00.00, ["name"] = "Armadillo"},
    [5] = { ["distance"] = 180.0, ["x"] = -5510.00, ["y"] = -2939.00, ["z"] = 10.00, ["name"] = "Tumbleweed"},
    [6] = { ["distance"] = 200.0, ["x"] = 1353.00, ["y"] = -1268.00, ["z"] = 80.00, ["name"] = "Rhodes"},
    [7] = { ["distance"] = 500.0, ["x"] = 2604.00, ["y"] = -1177.00, ["z"] = 117.00, ["name"] = "Saint Denis"},
}

function GetCurentTownName()
  local pedCoords = GetEntityCoords(PlayerPedId())
  local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    end
end

local NotifyIn = false
local NotifyOut = false

Citizen.CreateThread(function()
    while true do
        for i = 1, #towns do
            Wait(500)
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            local myV = vector3(coords.x, coords.y, coords.z)
            local dst = #(vector3(towns[i]["x"], towns[i]["y"], towns[i]["z"]) - myV)
            if dst < towns[i]["distance"] then
                if not NotifyIn then    
                    insideTown = true
                   -- TriggerEvent("redemrp_notification:start", 'Bienvenido a '..towns[i]["name"], 5)
                   print(dst) 
                   NotifyIn = true
                    NotifyOut = false
                elseif dst > towns[i]["distance"] then
                    insideTown = false
                end
                else
                if not NotifyOut then
                    NotifyIn = false
                    NotifyOut = true
                end
            end
        end
    end
    return
end)