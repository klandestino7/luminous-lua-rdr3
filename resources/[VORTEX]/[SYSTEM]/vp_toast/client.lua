
-- VP:TOAST:New -> "speech", "Simular a fala de um personagem"
-- VP:TOAST:New -> "dev", "Mensagem com intuito de ser para Devs"
-- VP:TOAST:New -> "alert", "Você é viado"
-- VP:TOAST:New -> "alert", "Você é viado"
-- VP:TOAST:New -> "success", "Você é viado"
-- VP:TOAST:New -> "error", "Você é viado"
-- VP:TOAST:New -> "gold", 10
-- VP:TOAST:New -> "gold", -10
-- VP:TOAST:New -> "dollar", 10
-- VP:TOAST:New -> "dollar", -10
-- VP:TOAST:New -> "item", "Pistola Vulcan", 10
-- VP:TOAST:New -> "item", "Pistola Vulcan", -10
-- VP:TOAST:New -> "longer_alert", "Toast que demora mais tempo para sumir, funciona para todos",

RegisterNetEvent("VP:TOAST:New")
AddEventHandler(
    "VP:TOAST:New",
    function(type, text, quantity)

        if tonumber(text) then
            quantity = text
            text = nil
        end

        SendNUIMessage(
            {
                type = type,
                text = text,
                quantity = quantity
            }
        )
    end
)

RegisterCommand('notifica', function()
    TriggerEvent('VP:TOAST:New', "longer_error", "Você tomou o estouro.")
    Wait(1000)
    TriggerEvent('VP:TOAST:New', "dev", "Mensagem com intuito de ser para Devs")
    Wait(1000)
	TriggerEvent('VP:TOAST:New', "alert", "Você foi libertado.")
end)