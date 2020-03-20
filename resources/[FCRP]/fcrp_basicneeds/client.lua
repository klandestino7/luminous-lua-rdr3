myHealth = 0
updateValue = false

Citizen.CreateThread(function() -- ESCONDER E MOSTRAR ALGUMAS HUDS

    --   Citizen.InvokeNative(0x12769EEB8DBD7A7B)
    --     Wait(300)
    --     local cyka =  Citizen.InvokeNative(0x96FD694FE5BE55DC, 'character_creator', 811893989)
    --     Citizen.InvokeNative(0x7B2027BAC5C8EC89, 'character_creator')
    --     print(cyka)
    -- Citizen.InvokeNative(0xA9C8960E8684C1B5,PlayerId(), 300)
    --  Citizen.InvokeNative(0x384D4765395E006C,PlayerId(), 3, true)
    --  local cyka = Citizen.InvokeNative(0xABC532F9098BFD9D,PlayerId())
    --   print(cyka)
    --   DisplayHud(true)
end)

RegisterCommand('nuioff', function()
    SetNuiFocus(false,false)
end)


RegisterNetEvent("crz_inventory:updateNeeds")
AddEventHandler(
    "crz_inventory:updateNeeds",
    function(hunger, thirst)
        if hunger == 0 then
            hunger = hunger
            SendNUIMessage(
                {
                    action = "changeHunger",
                    fome = hunger
                }
            )
        end
        if thirst == 0 then
                thirst = thirst   
                SendNUIMessage(
                    {
                        action = "changeThirst",
                        sede = thirst
                    }
                )
        end
        updateValue = true
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if not IsPedOnMount(PlayerPedId()) and not IsPedSittingInAnyVehicle(PlayerPedId()) then
                DisplayRadar(true)
                SendNUIMessage(
                    {
                        action = "isMounted"
                    }
                )
            else
                DisplayRadar(true)
                SendNUIMessage(
                    {
                        action = "notMounted"
                    }
                )
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)
            if updateValue then
                myHealth = GetEntityHealth(PlayerPedId())
                SendNUIMessage(
                    {
                        action = "changeHealth",
                        health = myHealth
                    }
                )
            end
        end
    end
)

RegisterNetEvent("fc_basicneeds:startUI")
AddEventHandler(
    "fc_basicneeds:startUI",
    function()
        SendNUIMessage(
            {
                action = "showHud"
            }
        )
        TriggerEvent('crz_inventory:updateNeeds', 0, 0)
    end
)