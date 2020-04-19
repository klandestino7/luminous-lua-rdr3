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