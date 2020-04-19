local doorStates = {
    [622733334] = 0
}
-- [doorHash] = pair

RegisterNetEvent("VP:HOUSING:TryToToggleDoorState")
AddEventHandler(
    "VP:HOUSING:TryToToggleDoorState",
    function(doorHash)

        if doorStates[doorHash] == nil then
            return
        end

        local _source = source
        -- local User = API.getUserFromUserId(_source)
        -- local Character = User:getCharacter()

        -- local character_houseid = Character.houseId

        -- if character_houseid == nil then
        --     User:notify("You cant open this door's house")
        --     return
        -- end

        -- local door_houseid = doorStates[doorId]

        -- if character_houseid == door_houseid then

        if doorStates[doorHash] == 0 then
            doorStates[doorHash] = 1
        else
            doorStates[doorHash] = 0
        end

            TriggerClientEvent('VP:HOUSING:SetDoorState', -1, doorHash, doorStates[doorHash])
        -- end
    end
)

AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, firstSpawn)
        if firstSpawn then
            AddEventHandler("VP:HOUSING:SyncDoorStates", source, doorStates)
        end
    end
)
