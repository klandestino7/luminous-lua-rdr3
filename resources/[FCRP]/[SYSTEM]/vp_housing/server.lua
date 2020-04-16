local doorStates = {
    [1] = {false, 1},
    [2] = {false, 2, 3},
    [3] = {false, 2, 2}
}
-- [doorId] = {doorState, houseId, doorPair}

RegisterNetEvent("VP:HOUSING:TryToToggleDoorState")
AddEventHandler(
    "VP:HOUSING:TryToToggleDoorState",
    function(doorId)

        if doorStates[doorId] == nil then
            return
        end

        local _source = source
        local User = API.getUserFromUserId(_source)
        local Character = User:getCharacter()

        local character_houseid = Character.houseId

        if character_houseid == nil then
            User:notify("You cant open this door's house")
            return
        end

        local door_houseid = doorStates[doorId]

        if character_houseid == door_houseid then
            TriggerClientEvent('VP:HOUSING:SetDoorState', -1, doorId, not doorStates[doorId][1])
        end
    end
)

AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, firstSpawn)
        if firstSpawn then
            local statesOnly = {}

            for _, values in pairs(doorStates) do
                table.insert(values[1])
            end

            AddEventHandler("VP:HOUSING:SyncDoorStates", source, statesOnly)
        end
    end
)
