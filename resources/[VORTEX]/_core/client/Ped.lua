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
            SetModelAsNoLongerNeeded(model)
        end
    )
    return true
end

function cAPI.SetPedSize(pedenti, num)
    local ped = pedenti
    SetPedScale(ped, tonumber(num))
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

local Tableff = {}

function cAPI.SetFaceFeature(pedenti, ff)
    local ped = pedenti
    for index, hash in pairs(faceFeatures) do
        local value = ff[index]
        Citizen.InvokeNative(0x5653AB26C82938CF, ped, tonumber(hash), value)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
    end
end

function cAPI.SetBodyType(pedenti, data)
    local ped = pedenti
    if IsPedMale(ped) then
        Citizen.InvokeNative(0xA5BAE410B03E7371, ped, tonumber(data), true, true, true)
    else
        Citizen.InvokeNative(0xA5BAE410B03E7371, ped, tonumber(data), true, true, true)
    end
end

function cAPI.SetSkin(pedenti, encoded)
    local ped = pedenti
    local decoded = json.decode(encoded)
    for _, hash in pairs(decoded) do
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true)
    end
end

function cAPI.SetCloth(hash)
    local Clothe = json.decode(hash)
    if hash ~= "{}" then
        for k, v in pairs(Clothe) do
            local modelHash = tonumber(v)
            cAPI.LoadModel(modelHash)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), modelHash, true, true, true)
            SetModelAsNoLongerNeeded(modelHash)
        end
    else
        -- Load default clothing
        print("default")
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

function cAPI.TaskAnimalInteraction(interaction)
    local ped = PlayerPedId()

    local interactions = {
        -- interactionId      interactionAnimation    propId
        ["injection"] = {"INTERACT_INJECTION", "p_cs_syringe01x"}
    }

    if interactions[interaction] then
        local playerHorse = cAPI.GetPlayerHorse()
        if playerHorse ~= nil and playerHorse ~= 0 then
            local v = interactions[interaction]
            TaskAnimalInteraction(ped, playerHorse, GetHashKey(v[1]), v[2] ~= nil and GetHashKey(v[2]) or 0, 0)
        end
    end
end

function cAPI.TaskInteraction(interaction)
    local ped = PlayerPedId()
    local hasWeaponInHead = GetCurrentPedWeapon(ped, 0)

    local unk1 = 1 -- 1 or 3
    local unk2 = 0 -- always
    local unk3 = -1.0

    local interactions = {
        -- p_cs_bottleslim01x
        -- interactionId       propId              promptName     propSlot            interactionAnimation
        ["drink_tonic"] = {"s_inv_antidote01x", -1199896558, "PrimaryItem", "USE_TONIC_SATCHEL_UNARMED_QUICK"},
        ["injection"] = {"s_immunitybooster01x", -1199896558, "PrimaryItem", "USE_STIMULANT_INJECTION_QUICK_LEFT_HAND"}
    }

    if interactions[interaction] then
        local v = interactions[interaction]

        local propEntity = 0
        if v[1] ~= nil then
            propEntity = CreateObject(GetHashKey(v[1]), GetEntityCoords(ped), false, true, false, false, true)
        end

        TaskItemInteraction_2(ped, GetHashKey(v[2]), propEntity, GetHashKey(v[3]), GetHashKey(v[4]), unk1, unk2, unk3)
    end
end
