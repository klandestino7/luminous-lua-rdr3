local doorGroupsIsOpen = {
    [1] = { -- BraitWaite Mansion
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        [10] = false,
        [11] = false,
    },
    [2] = { -- Mattock House
        [1] = false,
        [2] = false,
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
        local User = API.getUserFromUserId(_source)
        local Character = User:getCharacter()


        if not Character:hasGroupOrInheritance('house:' .. doorGroup) then
            User:notify('Você não tem permissão!')
            return
        end

        doorGroupsIsOpen[doorGroup][doorIndex] = not doorGroupsIsOpen[doorGroup][doorIndex]

        if pairIndex ~= nil then
            doorGroupsIsOpen[doorGroup][pairIndex] = doorGroupsIsOpen[doorGroup][doorIndex]
        end

        TriggerClientEvent("VP:HOUSING:SetDoorIsOpen", -1, doorGroup, doorIndex, doorGroupsIsOpen[doorGroup][doorIndex])
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