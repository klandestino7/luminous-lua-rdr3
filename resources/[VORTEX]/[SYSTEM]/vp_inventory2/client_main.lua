ItemPoolHash = {}

function joaat(t)
    return exports["vp_inventory2"]:js_joaat(t)
end

Citizen.CreateThread(
    function()
        for itemId, _ in pairs(ItemPool) do
            ItemPoolHash[joaat(itemId)] = itemId
        end

        print(json.encode(ItemPoolHash))

        Wait(1000)

        SendNUIMessage(
            {
                messageType = "updateItemPool",
                message = ItemPool,
                message2 = ItemPoolHash
            }
        )
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SetNuiFocus(false, false)
            SendNUIMessage(
                {
                    messageType = "hide"
                }
            )
        end
    end
)
