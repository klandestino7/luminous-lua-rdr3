adding = true
creator = false
inCustomization = false
cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = nil
sex = nil
--
--[[ Male {}
A_M_M_CHELONIAN_01
A_M_M_FOREMAN
]] local light = {
    {x = -561.86, y = -3776.757, z = 238.59, r = 50.0, f = 50.0},
    {x = -559.59, y = -3780.757, z = 238.59, r = 50.0, f = 50.0}
}

local peds = {
    {genrer = 'mp_male', x = -558.9098, y = -3775.616, z = 238.59, h = 137.98},
    {genrer = 'mp_female', x = -558.9098, y = -3776.978, z = 238.59, h = 47.11}
}

local cams = {
    {
        type = 'customization',
        x = -561.8157,
        y = -3780.966,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    },
    {
        type = 'selection',
        x = -562.8157,
        y = -3776.266,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    }
}

Citizen.CreateThread(
    function()
        RequestImap(-1699673416)
        RequestImap(1679934574)
        RequestImap(183712523)
        while true do
            Citizen.Wait(0)
            if creator and not inCustomization then
                if cam == nil then
                    createCam('selection')
                else
                    for k, v in pairs(choosePed) do
                        if IsControlJustReleased(0, 0xA65EBAB4) and GetEntityModel(choosePed[k]) == GetHashKey('mp_male') then -- male
                            AttachCamToEntity(cam, choosePed[k], -3.5, 0.0, 0.5, false)
                            PlaySoundFrontend('gender_left', 'RDRO_Character_Creator_Sounds', true, 0)
                            pedSelected = choosePed[k]
                            sex = 'mp_male'
                        elseif IsControlJustReleased(0, 0xDEB34313) and GetEntityModel(choosePed[k]) == GetHashKey('mp_female') then --female
                            AttachCamToEntity(cam, choosePed[k], -3.5, 0.0, 0.5, false)
                            PlaySoundFrontend('gender_right', 'RDRO_Character_Creator_Sounds', true, 0)
                            pedSelected = choosePed[k]
                            sex = 'mp_female'
                        end
                    end
                    if IsControlJustReleased(0, 0xC7B5340A) and pedSelected ~= nil then
                        DoScreenFadeOut(1800)
                        Wait(2000)
                        SetEntityCoords(pedSelected, -558.56, -3781.16, 237.59)
                        SetEntityHeading(pedSelected, 87.21)
                        inCustomization = true
                        DoScreenFadeIn(3000)
                    end
                end
            end
            if inCustomization and not hided then
                SetNuiFocus(true, true)
                SendNUIMessage(
                    {
                        action = 'showCreate',
                        gender = sex
                    }
                )
            end
            if creator then
                for k, v in pairs(light) do
                    DrawLightWithRange(light[k].x, light[k].y, light[k].z, 255, 255, 255, light[k].r, light[k].f)
                end
            end
        end
    end
)

RegisterNetEvent('crz_creator:starting')
AddEventHandler(
    'crz_creator:starting',
    function()
        creator = true
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
        SetEntityVisible(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), -561.8157, -3780.966, 239.0805)
    end
)

AddEventHandler(
    'onResourceStop',
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = 'hideOnly'
            }
        )
    end
)

function createCam(creatorType)
    for k, v in pairs(cams) do
        if cams[k].type == creatorType then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', cams[k].x, cams[k].y, cams[k].z, cams[k].rx, cams[k].ry, cams[k].rz, cams[k].fov, false, 0) -- CAMERA COORDS
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 3000, true, false)
            createPeds()
        end
    end
end

function createPeds()
    for k, v in pairs(peds) do
        if choosePed[k] == nil then
            local waiting = 0
            local hash = GetHashKey(peds[k].genrer)
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(10)
            end
            choosePed[k] = CreatePed(GetHashKey(peds[k].genrer), peds[k].x, peds[k].y, peds[k].z - 0.5, peds[k].h, false, 0)
            Citizen.InvokeNative(0x283978A15512B2FE, choosePed[k], true)
            Citizen.InvokeNative(0x58A850EAEE20FAA3, choosePed[k])
            NetworkSetEntityInvisibleToNetwork(choosePed[k], true)
            SetVehicleHasBeenOwnedByPlayer(choosePed[k], true)
            SetModelAsNoLongerNeeded(choosePed[k])
            if peds[k].genrer == 'mp_female' then
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x10F5497A,true,true,true) -- PANTS
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x14511493,true,true,true) -- COAT
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0xD03D522,true,true,true) -- BOOT
            else
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x10051C7,true,true,true) -- PANTS
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x12E51663,true,true,true) -- COAT
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x192C2A4B,true,true,true) -- BOOT
            end
        end
    end
end

RegisterNUICallback(
    'CloseCreator',
    function()
        SendNUIMessage(
            {
                action = 'hideCreate'
            }
        )
        inCustomization = false
        creator = false
        SetEntityVisible(PlayerPedId(), true)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        for k, v in pairs(choosePed) do
            DeleteEntity(choosePed[k])
        end
        choosePed = {}
        cam = nil
    end
)

CharacterName = nil
CharacterAge = 18
HeadUsing = nil
HairUsing = nil
TorsoUsing = nil
LegsUsing = nil
EyesUsing = nil
PorteUsing = nil
TeethUsing = nil
MustacheUsing = nil
RegisterNUICallback(
    'nm',
    function()
        Citizen.CreateThread(
            function()
                AddTextEntry('FMMC_MPM_NA', 1)
                DisplayOnscreenKeyboard(1, 'FMMC_MPM_NA', 'Insira o nome do personagem:', '', '', '', '', 20)
                while (UpdateOnscreenKeyboard() == 0) do
                    Citizen.Wait(0)
                    DisableAllControlActions(0)
                    SetNuiFocus(false, false)
                    SendNUIMessage(
                        {
                            action = 'hideOnly'
                        }
                    )
                    hided = true
                end
                if (GetOnscreenKeyboardResult() ~= nil) then
                    SendNUIMessage(
                        {
                            action = 'name',
                            name = GetOnscreenKeyboardResult()
                        }
                    )
                    hided = false
                    CharacterName = GetOnscreenKeyboardResult()
                    SetNuiFocus(true, true)
                end
            end
        )
    end
)

RegisterNUICallback(
    'CameraManagement',
    function(data)
        local pedCoord = GetEntityCoords(pedSelected)
        if spawnedCamera == nil then
            spawnedCamera = CreateCam('DEFAULT_SCRIPTED_CAMERA', 1)
        end
        if data.type == 'Rosto' or data.type == 'Cor dos Olhos' then
            SetCamCoord(spawnedCamera, pedCoord.x - 0.5, pedCoord.y + 0.2, pedCoord.z + 0.7)
            SetCamRot(spawnedCamera, 168.5682, 180.0, -89.01, 1)
        elseif data.type == 'Cabelos' or data.type == 'Cabelo' then
            SetCamCoord(spawnedCamera, pedCoord.x - 0.5, pedCoord.y + 0.2, pedCoord.z + 0.7)
            SetCamRot(spawnedCamera, 168.5682, 180.0, -89.01, 1)
        elseif data.type == 'Dentes' or data.type == 'BarbaMenu' then
            SetCamCoord(spawnedCamera, pedCoord.x - 0.3, pedCoord.y + 0.2, pedCoord.z + 0.6)
            SetCamRot(spawnedCamera, 168.5682, 180.0, -89.01, 1)
        elseif data.type == 'TomPele' then
            SetCamCoord(spawnedCamera, pedCoord.x - 0.9, pedCoord.y + 0.2, pedCoord.z + 0.5)
            SetCamRot(spawnedCamera, 168.5682, 180.0, -89.01, 1)
        else
            SetCamCoord(spawnedCamera, pedCoord.x - 0.9, pedCoord.y + 0.2, pedCoord.z + 0.5)
            SetCamRot(spawnedCamera, 168.5682, 180.0, -89.01, 1)
        end
        ClearPedSecondaryTask(pedSelected)
        StopAnimTask(pedSelected, 'FACE_HUMAN@GEN_MALE@BASE', 'Face_Dentistry_Loop', 1.0)
    end
)

RegisterNUICallback(
    'Rosto',
    function(data)
        if sex == 'mp_male' then
            for k, v in pairs(MaleHeads) do
                if MaleHeads[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleHeads[k].hash, true, true, true) -- FACE
                    HeadUsing = MaleHeads[k].hash
                end
            end
        else
            for k, v in pairs(FemaleHeads) do
                if FemaleHeads[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleHeads[k].hash, true, true, true) -- FACE
                    HeadUsing = FemaleHeads[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    'TomPele',
    function(data)
        if sex == 'mp_male' then
            for k, v in pairs(MaleTorsos) do
                if MaleTorsos[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleTorsos[k].hash, true, true, true)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleLegs[k].hash, true, true, true)
                    TorsoUsing = MaleTorsos[k].hash
                    LegsUsing = MaleLegs[k].hash
                end
            end
        else
            for k, v in pairs(FemaleTorsos) do
                if FemaleTorsos[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleTorsos[k].hash, true, true, true)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleLegs[k].hash, true, true, true)
                    TorsoUsing = FemaleTorsos[k].hash
                    LegsUsing = FemaleLegs[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    'Idade',
    function(data)
        for k, v in pairs(Age) do
            if Age[k].id == tonumber(data.id) then
                CharacterAge = tonumber(Age[k].age)
            end
        end
    end
)

RegisterNUICallback(
    'Olhos',
    function(data)
        if sex == 'mp_male' then
            for k, v in pairs(MaleEyes) do
                if MaleEyes[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleEyes[k].hash, true, true, true)
                    EyesUsing = MaleEyes[k].hash
                end
            end
        else
            for k, v in pairs(FemaleEyes) do
                if FemaleEyes[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleEyes[k].hash, true, true, true)
                    EyesUsing = FemaleEyes[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    'Porte',
    function(data)
        if sex == 'mp_male' then
            Citizen.InvokeNative(0xA5BAE410B03E7371, pedSelected, math.floor(tonumber(data.id + 124)), true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, HeadUsing, true, true, true)
            PorteUsing = math.floor(tonumber(data.id + 124))
        else
            Citizen.InvokeNative(0xA5BAE410B03E7371, pedSelected, math.floor(tonumber(data.id + 110)), true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, HeadUsing, true, true, true)
            PorteUsing = math.floor(tonumber(data.id + 124))
        end
    end
)

RegisterNUICallback(
    'Dentes',
    function(data)
        if sex == 'mp_male' then
            for k, v in pairs(MaleTeeth) do
                if MaleTeeth[k].id == tonumber(data.id) then
                    RequestAnimDict('FACE_HUMAN@GEN_MALE@BASE')
                    while not HasAnimDictLoaded('FACE_HUMAN@GEN_MALE@BASE') do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(pedSelected, 'FACE_HUMAN@GEN_MALE@BASE', 'Face_Dentistry_Loop', 1090519040, -4, -1, 17, 0, 0, 0, 0, 0, 0)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleTeeth[k].hash, true, true, true)
                    TeethUsing = MaleTeeth[k].hash
                end
            end
        else
            for k, v in pairs(FemaleTeeth) do
                if FemaleTeeth[k].id == tonumber(data.id) then
                    RequestAnimDict('FACE_HUMAN@GEN_MALE@BASE')
                    while not HasAnimDictLoaded('FACE_HUMAN@GEN_MALE@BASE') do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(pedSelected, 'FACE_HUMAN@GEN_MALE@BASE', 'Face_Dentistry_Loop', 1090519040, -4, -1, 17, 0, 0, 0, 0, 0, 0)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleTeeth[k].hash, true, true, true)
                    TeethUsing = FemaleTeeth[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    'Cabelos',
    function(data)
        if sex == 'mp_male' then
            for k, v in pairs(MaleHairs) do
                if MaleHairs[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleHairs[k].hash, true, true, true)
                    HairUsing = MaleHairs[k].hash
                end
            end
        else
            for k, v in pairs(FemaleHairs) do
                if FemaleHairs[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleHairs[k].hash, true, true, true)
                    HairUsing = FemaleHairs[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    'BarbaMenu',
    function(data)
        if sex == 'mp_male' then
            for k, v in pairs(MaleMustache) do
                if MaleMustache[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleMustache[k].hash, true, true, true)
                    MustacheUsing = MaleMustache[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    'Confirm',
    function()
        local dados = {
            ['model'] = sex,
            ['age'] = CharacterAge,
            ['head'] = HeadUsing,
            ['hair'] = HairUsing,
            ['torso'] = TorsoUsing,
            ['legs'] = LegsUsing,
            ['eyes'] = EyesUsing,
            ['bodySize'] = PorteUsing,
            ['teeth'] = TeethUsing,
            ['mustache'] = MustacheUsing
        }
        TriggerServerEvent('crz_creator:saveCreation', CharacterName, dados)
        closeAll()
    end
)

function closeAll()
    SetNuiFocus(false, false)
    SendNUIMessage(
        {
            action = 'hideOnly'
        }
    )
    creator = false
    inCustomization = false
    choosePed = {}
    for k, v in pairs(choosePed) do
        DeleteEntity(choosePed[k])
    end
    local ped = PlayerPedId()
    SetEntityVisible(ped, true)
    NetworkSetEntityInvisibleToNetwork(ped, false)
    local coords = {
        x = 2835.56,
        y = -1408.2,
        z = 45.39
    }
    TriggerEvent('redemrp_respawn:camera', coords)
end
