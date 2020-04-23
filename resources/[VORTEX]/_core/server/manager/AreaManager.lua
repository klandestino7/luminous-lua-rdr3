local registeredAreas = {}
local playersAreas = {}

function API.registerArea(areaId, ...)
    registeredAreas[areaId] = ...

    cAPI.RegisterArea(-1, ...)
end

RegisterNetEvent("VP:AREA:PlayerEnteredArea")
RegisterNetEvent("VP:AREA:PlayerLeftArea")

AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            cAPI.RegisterAreas(source, registeredAreas)
        end
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName ~= GetCurrentResourceName() then
            return
        end

        Citizen.Wait(2000)

        cAPI.RegisterAreas(-1, registeredAreas)
    end
)

AddEventHandler(
    "VP:AREA:PlayerEnteredArea",
    function(areaId)
        local _source = source
    end
)

AddEventHandler(
    "VP:AREA:PlayerLeftArea",
    function(areaId)
        local _source = source
    end
)
