-- 1006.160,-1772.393,47.620

local windows = {
    {-1484366741, vec3(-5206.49, -3493.25, -21.63)},
    {-1484366741, vec3(-5207.82, -3488.29, -21.63)},
    {1757176412, vec3(1365.99, -874.96, 70.09)}
}

local cDoorGroup
local cDoorIndex

Citizen.CreateThread(
    function()
        local ped = PlayerPedId()
        local pedVec3 = GetEntityCoords(ped)

        for _, v in pairs(windows) do
            local windowModel = v[1]
            local windowVec3 = v[2]

            -- if #(pedVec3 - windowVec3) <= 100 then
            local window = GetClosestObjectOfType(windowVec3, 1.0, windowModel, false, 0, 0)
            if window ~= 0 then
                SetEntityInvincible(window, true)
            end
            -- end
        end

        while true do
            Citizen.Wait(1000)

            for _, v in pairs(windows) do
                local windowModel = v[1]
                local windowVec3 = v[2]

                local window = GetClosestObjectOfType(windowVec3, 1.0, windowModel, false, 0, 0)
                if window ~= 0 then
                    SetEntityInvincible(window, true)
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            TriggerServerEvent("VP:HOUSING:GetSynced")
        end
    end
)
