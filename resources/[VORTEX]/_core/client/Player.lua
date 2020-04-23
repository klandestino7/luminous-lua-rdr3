function cAPI.Initialize(model, clothing, lastPosition)
    local decodedLastPosition = json.decode(lastPosition)
    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    cAPI.SetModel(model.model)
    Wait(130)
    cAPI.SetBodyType(PlayerPedId(), model.model, model.bodySize)
    cAPI.SetSkin(PlayerPedId(), model.modSkin) 
    Wait(300)
    cAPI.SetFaceFeature(PlayerPedId(), json.decode(model.features))
    Wait(30)
    cAPI.SetPedSize(PlayerPedId(), model.pedSize)    


    cAPI.replaceWeapons({})
    cAPI.SetCloth(clothing)
    Citizen.CreateThread(
        function()
            cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition)
        end
    )

    TriggerEvent("ToogleBackCharacter")

    initializedPlayer = true
end

function cAPI.setAsInitialized(bool)
    initializedPlayer = bool
end