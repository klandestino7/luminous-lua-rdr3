Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)

            local ped = PlayerPedId()
            local temp = GetTemperatureAtCoords(GetEntityCoords(ent))

            if GetEntityHealth(ped) <= 5 then
                -- print('chegou')
            else
                if temp < -5 then
                    Wait(5000)
                    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "Cold_Stamina", 1, -1)
                    NativeApplyDamageToPed(ped, 5)
                else
                    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "Cold_Stamina", 0, 0)
                end
                
                if temp > 42 then
                    Wait(5000)
                    NativeApplyDamageToPed(ped, 5)
                end
            end
        end
    end
)

function NativeApplyDamageToPed(ped, damage)
    Citizen.InvokeNative(0x697157CED63F18D4, ped, damage, false, true, true)
end
