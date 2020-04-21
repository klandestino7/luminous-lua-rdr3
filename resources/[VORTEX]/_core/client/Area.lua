local registeredAreas = {}

local areaPlayerIsInside

RegisterNetEvent("VP:AREA:PlayerEnteredArea")
RegisterNetEvent("VP:AREA:PlayerLeftArea")

function cAPI.RegisterAreas(areas)
    for areaId, _ in pairs(areas) do
        cAPI.RegisterArea(areaId, _)
    end
end

function cAPI.RegisterArea(areaId, ...)
    local params = {}
    local vectors = {}

    for _, v in pairs(...) do
        if type(v) == "vector3" then
            table.insert(vectors, v)
        else
            params[_] = v
        end
    end

    local area = pArea(params)
    area.addBulk(table.unpack(vectors))

    registeredAreas[areaId] = area

    if areaPlayerIsInside == areaId then
        areaPlayerIsInside = nil
    end

    return area
end

function cAPI.GetAreaPlayerIsIn()
    return areaPlayerIsInside
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if areaPlayerIsInside ~= nil then
                local area = registeredAreas[areaPlayerIsInside]
                if not area.isInside() then
                    TriggerServerEvent("VP:AREA:PlayerLeftArea", areaPlayerIsInside)
                    TriggerEvent("VP:AREA:PlayerLeftArea", areaPlayerIsInside)
                    areaPlayerIsInside = nil
                end
            else
                for areaId, area in pairs(registeredAreas) do
                    if area.isInside() then
                        areaPlayerIsInside = areaId
                        TriggerServerEvent("VP:AREA:PlayerEnteredArea", areaId)
                        TriggerEvent("VP:AREA:PlayerEnteredArea", areaId)
                        break
                    end
                end
            end
        end
    end
)
