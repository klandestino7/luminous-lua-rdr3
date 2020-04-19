function cAPI.Initialize(model, skin, clothing, lastPosition)
    print("initialize")
    local decodedLastPosition = json.decode(lastPosition)

    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    -- local camera = cAPI.SkyCameraAtCoords(decodedLastPosition)
    cAPI.SetModel(model)
    cAPI.replaceWeapons({})
    cAPI.SetClothing(clothing)
    Citizen.CreateThread(
        function()
            -- Citizen.Wait(10000)
            cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition)
        end
    )

    TriggerEvent("ToogleBackCharacter")
end
