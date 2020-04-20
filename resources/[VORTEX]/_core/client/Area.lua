local registeredAreas = {}

local areaPlayerIsInside

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
            table.insert(params, v)
        end
    end

    local area = pArea(params)
    area.addBulk(table.unpack(vectors))

    registeredAreas[areaId] = area
end

function cAPI.GetAreaIsIn()
    return areaPlayerIsInside
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for areaId, area in pairs(registeredAreas) do
                if area.isInside() then
                    if areaPlayerIsInside ~= areaId then
                        areaPlayerIsInside = areaId
                        TriggerServerEvent("VP:AREA:PlayerEnteredArea", areaId)
                    end
                else
                    if areaPlayerIsInside ~= nil then
                        if areaPlayerIsInside == areaId then
                            TriggerServerEvent("VP:AREA:PlayerLeftArea", areaPlayerIsInside)
                            areaPlayerIsInside = nil
                        end
                    end
                end
            end
        end
    end
)
