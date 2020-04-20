function cAPI.Initialize(model, skin, clothing, lastPosition)
    local decodedLastPosition = json.decode(lastPosition)
    print(lastPosition)
    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    -- local camera = cAPI.SkyCameraAtCoords(decodedLastPosition)
    cAPI.SetModel(model)
    cAPI.SetSkin(skin)
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