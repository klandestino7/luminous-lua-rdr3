local weatherPerRegion = {
    ["greatPlains"] = {
        ["RAINY"] = 0.1,
        ["WINDYCLEAR"] = 0.3,
        ["CLEAR"] = 0.7
    },
    ["TallTrees"] = {
        ["RAINY"] = 0.25,
        ["CLEAR"] = 0.3,
        ["FOGGY"] = 0.05,
        ["WINDYRAIN"] = 0.1,
        ["SUNNYRAIN"] = 0.3
    },
    ["scarlettMeadows"] = {
        ["RAINY"] = 0.25,
        ["CLEAR"] = 0.25,
        ["WINDYRAIN"] = 0.15,
        ["SUNNYRAIN"] = 0.3,
        ["SNOWY"] = 0.1
    },
    ["HeartLands"] = {
        ["RAINY"] = 0.1,
        ["CLEAR"] = 0.5,
        ["SUNNYRAIN"] = 0.2,
        ["WINDYRAIN"] = 0.1
    },
    ["GrizzliesEast"] = {
        ["RAINY"] = 0.15,
        ["CLEAR"] = 0.7,
        ["SUNNYRAIN"] = 0.2,
        ["WINDYRAIN"] = 0.1,
        ["SNOWY"] = 0.05
    }
}

local currentRegionWeather = {}

local weightPerRegion = {}

Citizen.CreateThread(
    function()
        for region, weathers in pairs(weatherPerRegion) do
            local total = 0
            for weather, weight in pairs(weathers) do
                total = total + weight
            end

            weightPerRegion[region] = total
        end
        while true do
            Citizen.Wait(60000 * 15)
            for region, weathers in pairs(weatherPerRegion) do
                local total = weightPerRegion[region]
                local at = math.random() * total
                local choosen
                for weather, weight in pairs(weathers) do
                    if at < weight then
                        choosen = weather
                        break
                    end
                    at = at - weight
                end

                if currentRegionWeather[region] == nil or choosen ~= currentRegionWeather[region] then
                    currentRegionWeather[region] = choosen
                    TriggerClientEvent("VP:W:SetRegionWeather", -1, region, choosen)
                end
            end
        end
    end
)

RegisterNetEvent("VP:W:AskForSync")
AddEventHandler(
    "VP:W:AskForSync",
    function()
        local _source = source
        if #currentRegionWeather > 0 then
            TriggerClientEvent("VP:W:Sync", _source, currentRegionWeather)
        else
            for region, weathers in pairs(weatherPerRegion) do
                local total = weightPerRegion[region]
                local at = math.random() * total
                local choosen
                for weather, weight in pairs(weathers) do
                    if at < weight then
                        choosen = weather
                        break
                    end
                    at = at - weight
                end

                if currentRegionWeather[region] == nil or choosen ~= currentRegionWeather[region] then
                    currentRegionWeather[region] = choosen
                    TriggerClientEvent("VP:W:SetRegionWeather", -1, region, choosen)
                end
            end
        end
    end
)
