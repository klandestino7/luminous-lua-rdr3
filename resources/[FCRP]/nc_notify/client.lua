RegisterNetEvent("CK:NOTIFY:Notification")
AddEventHandler(
    "CK:NOTIFY:Notification",
    function(icon, header, text)
        SendNUIMessage(
            {
                icon = icon,
                header = header,
                text = text
            }
        )
    end
)

RegisterCommand(
    "notify",
    function(source, args, rawCommand)
        TriggerEvent('CK:NOTIFY:Notification', args[1], args[2], args[3])
    end,
    false
)
