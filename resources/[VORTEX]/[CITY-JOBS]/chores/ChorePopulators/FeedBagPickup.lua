local positions = {
    vec3(-742.337, -1366.698, 43.357)
}

local scenarios = {}

function PopulateFeedBagPickup()
    local ped = PlayerPedId()
    local pedPosition = GetEntityCoords(ped)

    local scenarioType = "WORLD_HUMAN_FEEDBAG_PICKUP"
    local scenarioTypeHash = GetHashKey(scenarioType)

    for _, position in pairs(positions) do
        local hasCollision, groundZ, normal = GetGroundZAndNormalFor_3dCoord(position.x, position.y, position.z)

        if hasCollision then
            position = vec3(position.xy, groundZ)
            if NativeFindClosestActiveScenarioPointOfType(scenarioTypeHash, position, 2.0) == 0 then
                local scenario = NativeCreateScenarioPoint(scenarioTypeHash, position, 180.0)
                table.insert(scenarios, scenario)
            end
        end
    end
end

function GetPopulationFeedBagPickup()
    return scenarios
end
