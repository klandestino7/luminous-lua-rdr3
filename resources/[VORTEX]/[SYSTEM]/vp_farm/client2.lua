local SCOPE_RANGE = 10.0

local areasSpots = {}

local pop = {}

Citizen.CreateThread(
    function()
        local DRAW_LINE = GetHashKey("DRAW_LINE")

        computeSpots()

        WrapperRequestComposite(GetHashKey("COMPOSITE_LOOTABLE_WINTERGREEN_BERRY_DEF"))

        for areaId, t in pairs(areasSpots) do
            for _, vec in pairs(t) do
                local composite = exports["research"]:NativeCreateComposite(GetHashKey("COMPOSITE_LOOTABLE_WINTERGREEN_BERRY_DEF"), vec.x, vec.y, vec.z, true)
                table.insert(pop, composite)
            end
        end

        while true do
            Citizen.Wait(0)

            local pedCoords = GetEntityCoords(PlayerPedId())

            for areaId, t in pairs(areasSpots) do
                for _, vec in pairs(t) do
                    -- Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, vec, vec + vec3(0, 0, 0.7), 230, 122, 122, 255)
                    local dist = #(pedCoords - vec)
                    if dist <= SCOPE_RANGE then
                        Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, vec, vec + vec3(0, 0, 0.7), 122, 230, 122, 255)
                    end

                    if dist > SCOPE_RANGE then
                        -- Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, vec, vec + vec3(0, 0, 0.7), 230, 122, 122, 255)
                        
                    end
                end
            end

            for _, composite in pairs(pop) do
            end
        end
    end
)

function computeSpotsBetweenTwoPointsAddToTable(t, spacing, a, b)
    local d = math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)) / spacing
    local fi = math.atan2(b.y - a.y, b.x - a.x)

    for i = 0, spacing do
        local x = a.x + i * d * math.cos(fi)
        local y = a.y + i * d * math.sin(fi)
        local _, z, _ = GetGroundZAndNormalFor_3dCoord(x, y, a.z)

        table.insert(t, vec3(x, y, z))
    end
end

function computeSpots()
    for areaId, t in pairs(farmsRows) do
        if areasSpots[areaId] == nil then
            areasSpots[areaId] = {}
        end

        local spacing = t.numSpots

        for key, v in pairs(t) do
            if key ~= "numSpots" and key ~= "type" then
                local pointA = v[1]
                local pointB = v[2]

                print(v, pointA, pointB)

                local spots = computeSpotsBetweenTwoPointsAddToTable(areasSpots[areaId], spacing, pointA, pointB)
            end
        end
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, composite in pairs(pop) do
                NativeDeleteComposite(composite)
            end
        end
    end
)

function NativeDeleteComposite(composite)
    Citizen.InvokeNative(0x5758B1EE0C3FD4AC, composite, 0)
end

function WrapperRequestComposite(compositeHash)
    if not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) then
        Citizen.InvokeNative(0x73F0D0327BFA0812, compositeHash)

        while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) do
            print('waiting')
            Citizen.Wait(0)
        end
    end
end
