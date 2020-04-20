local registeredAreas = {}

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
            cAPI.RegisterAreas(registeredAreas)
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
        if areaId == "MINING:Area1" then
            local _source = source
        -- print("source " .. _source .. " entered area " .. areaId)
        end
    end
)

AddEventHandler(
    "VP:AREA:PlayerLeftArea",
    function(areaId)
        if areaId == "MINING:Area1" then
            local _source = source
        -- print("source " .. _source .. " left area " .. areaId)
        end
    end
)

-- TEST
-- Citizen.CreateThread(
--     function()
--         API.registerArea(
--             "MINING:Area1",
--             {
--                 -- fade = 400, -- The alpha value goes from the specified value to zero, where zero is reached when you are this many meters from the center point
--                 -- height = 20, -- Height of the area
--                 -- color = {255, 10, 10, 128},
--                 -- border = {255, 0, 0, 255},
--                 -- wallFade = 20, -- Overrides "fade" (except for the label) to draw the walls when within this number of meters from it. As the name implies, it fades in and out.
--                 -- numbered = true, -- Makes little numbers appear on the "fenceposts" to show which point that "fencepost" represents. Respects fade and wallFade
--                 -- label = "Bolingbroke Penetentiary", -- Text shown at the center of the area. Respects fade.
--                 vector3(1488.5379638672, 2418.0180664063, 426.50103759766),
--                 vector3(1512.1339111328, 2398.0893554688, 430.40893554688),
--                 vector3(1543.9182128906, 2440.560546875, 404.54629516602),
--                 vector3(1574.3876953125, 2407.8427734375, 413.81301879883)
--             }
--         )
--     end
-- )
