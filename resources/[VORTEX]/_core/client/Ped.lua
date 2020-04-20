function cAPI.SetModel(hash)
    Citizen.CreateThread(
        function()
            local model = GetHashKey(hash)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(100)
            end
            SetPlayerModel(PlayerId(), model, true)
            Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
        end
    )
    return true
end

function cAPI.SetSkin(encoded)
    local decoded = json.decode(encoded) or {}
    for _, hash in pairs(decoded) do
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
    end
end

local faceFeatures = {
    0x84D6,
    0x3303,
    0x2FF9,
    0x4AD1,
    0xC04F,
    0xB6CE,
    0x2844,
    0xED30,
    0x6A0B,
    0xABCF,
    0x358D,
    0x8D0A,
    0xEBAE,
    0x1DF6,
    0x3C0F,
    0xC3B2,
    0xE323,
    0x8B2B,
    0x1B6B,
    0xEE44,
    0xD266,
    0xA54E,
    0xDDFB,
    0x6E7F,
    0x3471,
    0x03F5,
    0x34B1,
    0xF156,
    0x561E,
    0xF065,
    0xAA69,
    0x7AC3,
    0x410D,
    0x1A00,
    0x91C1,
    0xC375,
    0xBB4D,
    0xB0B0,
    0x5D16
}

function cAPI.SetFaceFeatures(encoded)
    local decoded = json.decode(encoded)
    for _, hash in pairs(faceFeatures) do
        for _, values in pairs(decoded) do
            for i = 1, 39 do
                print(tonumber(hash)[i], values)
                -- Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), tonumber(hash)[i], values)
                --   Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), false, true, true, true, false)
            end
        end
    end
end

function cAPI.SetCloth(hash)
    local Clothe = json.decode(hash)
    if hash ~= "{}" then
        for k, v in pairs(Clothe) do
            local modelHash = tonumber(v)
            cAPI.LoadModel(modelHash)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), modelHash, true, true, true)
        end
    else
        -- Load default clothing
        if IsPedMale(PlayerPedId()) then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x1B164391, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x10B87936, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x11B7CAB1, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x1526EAB7, true, true, true)
        else
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x15B760CE, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x1178F4F4, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x141281DC, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x1945CE44, true, true, true)
        end
    end
end