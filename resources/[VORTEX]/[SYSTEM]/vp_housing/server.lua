local doorGroupsIsOpen = {
    [1] = {
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        [10] = false,
        [11] = false,
    }
}

RegisterNetEvent("VP:HOUSING:TryToToggleDoorState")
AddEventHandler(
    "VP:HOUSING:TryToToggleDoorState",
    function(doorGroup, doorIndex, pairIndex)
        if doorGroupsIsOpen[doorGroup] == nil or doorGroupsIsOpen[doorGroup][doorIndex] == nil then
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

        doorGroupsIsOpen[doorGroup][doorIndex] = not doorGroupsIsOpen[doorGroup][doorIndex]

        if pairIndex ~= nil then
            doorGroupsIsOpen[doorGroup][pairIndex] = doorGroupsIsOpen[doorGroup][doorIndex]
        end

        TriggerClientEvent("VP:HOUSING:SetDoorIsOpen", -1, doorGroup, doorIndex, doorGroupsIsOpen[doorGroup][doorIndex])
        -- end
    end
)

RegisterNetEvent("VP:HOUSING:GetSynced")
AddEventHandler(
    "VP:HOUSING:GetSynced",
    function()
        local _source = source
        TriggerClientEvent("VP:HOUSING:SyncDoorStates", _source, doorGroupsIsOpen)
    end
)

AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, firstSpawn)
        if firstSpawn then
        end
    end
)
