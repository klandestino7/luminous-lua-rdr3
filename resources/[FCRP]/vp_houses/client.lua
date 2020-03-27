local interiors = {
    206849
}

local insideHomeInterior

local closestInteriorId
local closestOutsidePortalIndex

local outsidePortalVector

RegisterCommand(
    "interior",
    function(source, args, rawCommand)
        print(GetInteriorFromEntity(PlayerPedId()))
    end,
    false
)


Citizen.CreateThread(
    function()
        local interiorsOutsidePortals = getInteriorsOutsidePortals()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local position = GetEntityCoords(ped)

            for interiorId, portals in pairs(outsidePortals) do
                if IsInteriorReady(interiorId) then
                    local interiorPos = vec3(GetInteriorPosition(interiorId))
                    local interiorRotation = vec4(GetInteriorRotation(interiorId))

                    local outsidePortalDistance
                    local _outsidePortalVector

                    for _, portalIndex in pairs(interiorsOutsidePortals[interiorId]) do
                        local cornerPosition_topRight = interiorPos + QMultiply(interiorRotation, vec3(GetInteriorPortalCornerPosition(interiorId, portalIndex, 0)))
                        local cornerPosition_topLeft = interiorPos + QMultiply(interiorRotation, vec3(GetInteriorPortalCornerPosition(interiorId, portalIndex, 3)))

                        -- print(position, cornerPosition_topRight, #(position - cornerPosition_topRight))
                        local distRight = #(position - cornerPosition_topRight)
                        local distLeft = #(position - cornerPosition_topLeft)

                        if outsidePortalDistance == nil or (distRight <= outsidePortalDistance or distLeft <= outsidePortalDistance) then
                            outsidePortalDistance = distRight > distLeft and distRight or distLeft
                            _outsidePortalVector = (cornerPosition_topRight + cornerPosition_topLeft) / 2
                        end
                    end

                    outsidePortalVector = _outsidePortalVector

                    if insideHomeInterior == nil and GetInteriorFromEntity(ped) == interiorId then
                        SetEntityCoords(ped, outsidePortalVector, 0, 0, 0, 0)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if outsidePortalVector ~= nil then
                DrawLine(GetEntityCoords(PlayerPedId()), outsidePortalVector, 255, 0, 0, 255)

                local ped = PlayerPedId()
                local forwardVector = GetEntityForwardVector(ped)
                local position = GetEntityCoords(ped)

                local front = position + (forwardVector * 1.0)
                local back = position - (forwardVector * 1.0)

                if #(outsidePortalVector - front) < #(outsidePortalVector - back) then
                    -- print('Block W')
                    DrawLine(position, front, 0, 0, 255, 255)
                    -- DisableControlAction(0, 31,  true) -- MoveUpDown
                    DisableControlAction(0, 32, true)
                else
                    -- print('Block S')
                    DrawLine(position, back, 0, 0, 255, 255)
                    DisableControlAction(0, 33, true)
                end
            end
        end
    end
)

function getInteriorsOutsidePortals()
    outsidePortals = {}
    for _, interiorId in pairs(interiors) do
        outsidePortals[interiorId] = {}
        for i = 0, GetInteriorPortalCount(interiorId) do
            if GetInteriorPortalRoomTo(interiorId, i) == 0 and GetInteriorPortalFlag(interiorId, i) ~= 8 then
                table.insert(outsidePortals[interiorId], i)
                print(i)
            end
        end
    end
    return outsidePortals
end

function QMultiply(a, b)
    local axx = a.x * 2.0
    local ayy = a.y * 2.0
    local azz = a.z * 2.0
    local awxx = a.w * axx
    local awyy = a.w * ayy
    local awzz = a.w * azz
    local axxx = a.x * axx
    local axyy = a.x * ayy
    local axzz = a.x * azz
    local ayyy = a.y * ayy
    local ayzz = a.y * azz
    local azzz = a.z * azz
    return vec3(((b.x * ((1.0 - ayyy) - azzz)) + (b.y * (axyy - awzz))) + (b.z * (axzz + awyy)), ((b.x * (axyy + awzz)) + (b.y * ((1.0 - axxx) - azzz))) + (b.z * (ayzz - awxx)), ((b.x * (axzz - awyy)) + (b.y * (ayzz + awxx))) + (b.z * ((1.0 - axxx) - ayyy)))
end

-- -8.22,513.61,174.64