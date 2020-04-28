local weatherTypes = {
    ["WINDYSNOW"] = 0x27EA2814, -- SNOW
    ["RAINY"] = 0x995C7F44, --RAIN
    ["FOGGY"] = 0xD61BDE01, --FOGGY
    ["BLIZZARD"] = 0x7F622122, --SNOW BLIZZARD
    ["WINDYRAIN"] = 0x320D0951, --RAINING CLOUDY WINDY
    ["SFOGGY"] = 0x5974E8E5, --LIL FOGGY
    ["CLODU"] = 0x19D4F1D9, --CLOUDY
    ["SUNNYRAIN"] = 0x54A69840, -- RAINING SUNNY
    ["WINDYCLEAR"] = 0xB17F6111, -- WINDY CLEAR
    ["SNOWY"] = 0xEFB6EFF6, -- SNOW NO WINDY
    ["CLEAR"] = 0x614A1F91, --CLEAR
    ["THUNDER"] = 0xB677829F, -- THUNDER
    ["CLOUDYTHUNDER"] = 0x7C1C4A13, -- DARK CLOUDY THUNDER
    ["WINDYSNOW"] = 0x2B402288 -- SNOW WINDY
}

local regionsWeather = {}
local transitioning = {}

RegisterNetEvent("VP:W:SetRegionWeather")
AddEventHandler(
    "VP:W:SetRegionWeather",
    function(region, weather)
        local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, GetEntityCoords(PlayerPedId()), 10)
        if town_hash == GetHashKey(region) then
            local weather_hash = weatherTypes[weather]

            local old_weather = weather_hash
            if regionsWeather[region] then
                old_weather = weatherTypes[regionsWeather[region]]
                transitioning[region] = true
            end

            regionsWeather[region] = weather

            SetWeatherTypeTransition(weather_hash, old_weather, 8.4)
            Citizen.Wait(5000)
            SetWeatherTypeTransition(weather_hash, old_weather, 6.8)
            Citizen.Wait(5000)
            SetWeatherTypeTransition(weather_hash, old_weather, 5.2)
            Citizen.Wait(5000)
            SetWeatherTypeTransition(weather_hash, old_weather, 3.6)
            Citizen.Wait(5000)
            SetWeatherTypeTransition(weather_hash, old_weather, 2.0)
            Citizen.Wait(5000)
            SetWeatherTypeTransition(weather_hash, weather_hash, 0.0)
            transitioning[region] = false
        end
    end
)

Citizen.CreateThread(
    function()
        local currentRegion
        while true do
            Citizen.Wait(1000)
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(PlayerId())))
            local region = GetCurrentRegionName()

            if region ~= currentRegion and regionsWeather[region] and not transitioning[region] then
                local weather_hash = weatherTypes[regionsWeather[region]]
                SetWeatherTypeTransition(weather_hash, weather_hash, 1.0)
                currentRegion = region
            end
        end
    end
)

function GetCurrentRegionName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)

    if town_hash == GetHashKey("GuarmaD") then
        return "GuarmaD"
    elseif town_hash == GetHashKey("BayouNwa") then
        return "BayouNwa"
    elseif town_hash == GetHashKey("bigvalley") then
        return "bigvalley"
    elseif town_hash == GetHashKey("BluewaterMarsh") then
        return "BluewaterMarsh"
    elseif town_hash == GetHashKey("ChollaSprings") then
        return "ChollaSprings"
    elseif town_hash == GetHashKey("Cumberland") then
        return "Cumberland"
    elseif town_hash == GetHashKey("DiezCoronas") then
        return "DiezCoronas"
    elseif town_hash == GetHashKey("GaptoothRidge") then
        return "GaptoothRidge"
    elseif town_hash == GetHashKey("greatPlains") then
        return "greatPlains"
    elseif town_hash == GetHashKey("GrizzliesEast") then
        return "GrizzliesEast"
    elseif town_hash == GetHashKey("GrizzliesWest") then
        return "GrizzliesWest"
    elseif town_hash == GetHashKey("HennigansStead") then
        return "HennigansStead"
    elseif town_hash == GetHashKey("Perdido") then
        return "Perdido"
    elseif town_hash == GetHashKey("PuntaOrgullo") then
        return "PuntaOrgullo"
    elseif town_hash == GetHashKey("RioBravo") then
        return "RioBravo"
    elseif town_hash == GetHashKey("roanoke") then
        return "roanoke"
    elseif town_hash == GetHashKey("scarlettMeadows") then
        return "scarlettMeadows"
    elseif town_hash == GetHashKey("TallTrees") then
        return "TallTrees"
    elseif town_hash == GetHashKey("Heartlands") then
        return "Heartlands"
    elseif town_hash == false then
        return "unknown"
    end
end


AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerServerEvent('VP:W:AskForSync')
    end
end)

RegisterNetEvent('VP:W:Sync')
AddEventHandler('VP:W:Sync', function(data)
    regionsWeather = data
end)