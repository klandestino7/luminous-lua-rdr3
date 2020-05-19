local herbsScenarios = {}
local pop = {}

local numPopOnCooldown = 0

local minRadius = 50

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            if numPopOnCooldown > 0 then
                numPopOnCooldown = numPopOnCooldown - 1
            end

            if #pop < 25 and #pop + numPopOnCooldown < 25 then
                local newPosition = GetRandomPositionInRadius()

                -- print(newPosition)

                while IsPointOnRoad(newPosition, 0) do
                    Citizen.Wait(0)
                    newPosition = GetRandomPositionInRadius()
                end

                local carrotModel = "wildcarrot_p"
                if not HasModelLoaded(carrotModel) then
                    RequestModel(carrotModel)
                    while not HasModelLoaded(carrotModel) do
                        Citizen.Wait(10)
                    end
                end

                local obj = CreateObject(carrotModel, newPosition, 0, 0, 0)

                table.insert(pop, obj)

            -- WB_HORSE_HERB_WILD_CARROTS

            -- Citizen.InvokeNative(0x19A6BE7D9C6884D3, GetHashKey("WB_ORCHID_SPIDER"), 15, 0, 0)

            -- while not Citizen.InvokeNative(0x9427C94D2E4094A4, GetHashKey("WB_ORCHID_SPIDER")) do
            --     Wait(10)
            -- end

            -- local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey("WB_HORSE_HERB_WILD_CARROTS"), coords, 0.0, 0.0, 0, 0)

            -- local scenario = Citizen.InvokeNative(0x794AB1379A74064D, obj, GetHashKey("WB_HORSE_HERB_WILD_CARROTS"), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0)

            -- print(scenario, "created", GetEntityCoords(PlayerPedId()), Citizen.InvokeNative(0xA8452DD321607029, scenario, true, Citizen.ResultAsVector()))

            -- Wait(1000)
            -- TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, 0, 0, 0, 0, 0)

            -- table.insert(herbsScenarios, scenario)
            end
            local pPosition = GetEntityCoords(PlayerPedId())

            for _, object in pairs(pop) do
                if #(pPosition - GetEntityCoords(object)) > minRadius then
                    pop[_] = nil
                    DeleteEntity(object)
                    numPopOnCooldown = numPopOnCooldown + 1
                end
            end
        end
    end
)


function GetRandomPositionInRadius()
    local r = math.random(0, minRadius)

    local deg = math.random(0, 360)

    local center = GetEntityCoords(PlayerPedId())

    local xDeg0 = center.x + (r * math.cos(deg))
    local yDeg0 = center.y + (r * math.sin(deg))

    local retval, groundZ, normal = GetGroundZAndNormalFor_3dCoord(xDeg0, yDeg0, center.z)

    local newPosition = vec3(xDeg0, yDeg0, center.z)

    if retval ~= false then
        newPosition = vec3(newPosition.xy, groundZ)
    end

    return newPosition
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local pPosition = GetEntityCoords(PlayerPedId())

            for _, object in pairs(pop) do
                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pPosition, GetEntityCoords(object),255, 0, 0, 255)
            end
        end
    end
)

function DestroyHerbs()
    -- for _, herbScenario in pairs(herbsScenarios) do
    --     -- DeleteEntity(herb)
    --     -- Citizen.InvokeNative(0x81948DFE4F5A0283, herbScenario)
    -- end

    for _, object in pairs(pop) do
        DeleteEntity(object)
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            DestroyHerbs()
        end
    end
)
