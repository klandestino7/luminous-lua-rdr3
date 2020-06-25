local pop = {}

Citizen.CreateThread(
    function()
        local upVector = vec3(0, 0, 1.5)

        local DRAW_LINE = GetHashKey("DRAW_LINE")

        while true do
            Citizen.Wait(0)

            --[[
        for compositeHashAsString, v in pairs(popSpawns) do
            -- local compositeHash = GetHashKey(compositeHashAsString)
            compositeHash = compositeHashAsString
            local onGround = v.onGround or true

            print(compositeHash)
            if not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) then
                Citizen.InvokeNative(0x73F0D0327BFA0812, compositeHash)

                while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) do
                    Citizen.Wait(10)
                end
            end

            for index, vect in pairs(v) do
                if type(vect) == "vector3" then
                    local x, y, z = table.unpack(vect)
                    local composite = exports["vp_herb_population"]:NativeCreateComposite(compositeHash, x, y, z, onGround)

                    print(compositeHashAsString, composite)

                    if pop[compositeHashAsString] == nil then
                        pop[compositeHashAsString] = {}
                    end

                    table.insert(pop[compositeHashAsString], composite)
                end
            end
        end
        -]]
            -- for _, d in pairs(CompositeVectors2) do

            local playerPosition = GetEntityCoords(PlayerPedId())

            -- Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, playerPosition, playerPosition + upVector, 255, 0, 0, 255)

            for i = 1, #CompositeVectors2 do
                local d = CompositeVectors2[i]
                for index, v in pairs(d.vectors) do
                    local dist = #(playerPosition - v)
                    if dist < 100.0 then
                        Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, v, v + upVector, 255, 0, 0, 255)

                        local composite = GetCompositeAt(d.name, index)
                        if composite then
                            -- Citizen.InvokeNative(0x082C043C7AFC3747, composite, 1) -- DISPLAY_COMPOSITE_EAT_THIS_FRAME
                            Citizen.InvokeNative(0x40D72189F46D2E15, composite, 1) -- DISPLAY_COMPOSITE_PICKUP_THIS_FRAME
                        end
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local playerPosition = GetEntityCoords(PlayerPedId())

            for i = 1, #CompositeVectors2 do
                local d = CompositeVectors2[i]

                local compositeHash = GetHashKey(d.name)

                if not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) then
                    Citizen.InvokeNative(0x73F0D0327BFA0812, compositeHash)

                    while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) do
                        Citizen.Wait(10)
                    end
                end

                local compositeType = d.name

                for index, v in pairs(d.vectors) do
                    local dist = #(playerPosition - v)
                    if dist < 100.0 then
                        if not HasCompositeActiveAt(compositeType, index) then
                            CreateComposite(compositeType, index, v)
                        end
                    else
                        DestroyCompositeAt(compositeType, index)
                    end
                end
            end
        end
    end
)

function CreateComposite(compositeType, index, v)
    if pop[compositeType] == nil then
        pop[compositeType] = {}
    end

    local composite = exports["vp_herb_population"]:NativeCreateComposite(GetHashKey(compositeType), v.x, v.y, v.z, false)

    pop[compositeType][index] = composite
end

function DestroyCompositeAt(compositeType, index)
    if HasCompositeActiveAt(compositeType, index) then
        NativeDeleteComposite(GetCompositeAt(compositeType, index))
        pop[compositeType][index] = nil
    end
end

function GetCompositeAt(compositeType, index)
    return pop[compositeType] ~= nil and pop[compositeType][index] or nil
end

function HasCompositeActiveAt(compositeType, index)
    return pop[compositeType] ~= nil and pop[compositeType][index] ~= nil
end

function DestroyHerbs()
    for _, v in pairs(pop) do
        for index, composite in pairs(v) do
            NativeDeleteComposite(composite)
        end
    end
    pop = {}
end

function NativeDeleteComposite(composite)
    Citizen.InvokeNative(0x5758B1EE0C3FD4AC, composite, 0)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            DestroyHerbs()
        end
    end
)

-- RegisterCommand(
--     "eagleeye",
--     function()
--         Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, PlayerId(), 1) -- ENABLE_EAGLE_EYE(PLayer player, BOOL, enable)
--         Citizen.InvokeNative(0x28A13BF6B05C3D83, PlayerId(), 1) -- SETS DEADEYE/EAGLEEYE INFINITE
--     end,
--     false
-- )
