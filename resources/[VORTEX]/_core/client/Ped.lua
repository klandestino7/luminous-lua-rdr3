function cAPI.SetModel(hash)
    cAPI.RequestModel(hash)

    Wait(500)
    SetPlayerModel(PlayerId(), hash)

    -- SetPedDefaultComponentVariation(PlayerPedId(), true)
    Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
end

function cAPI.SetSkin(encoded)
    local decoded = json.decode(encoded)

    for _, hash in pairs(decoded) do
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
    end
end

function cAPI.SetClothing(encoded)
    local decoded = json.decode(encoded)

    local ped = PlayerPedId()

    if #decoded > 0 then
        for _, hash in pairs(decoded) do
            hash = tonumber(hash)
            -- cAPI.RequestModel(hash)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, hash, true, true, true)
        end
    else
        -- Load default clothing
        if IsPedMale(ped) then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x1B164391, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x10B87936, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x11B7CAB1, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x1526EAB7, true, true, true)
        else
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x15B760CE, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x1178F4F4, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x141281DC, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x1945CE44, true, true, true)
        end
    end
end