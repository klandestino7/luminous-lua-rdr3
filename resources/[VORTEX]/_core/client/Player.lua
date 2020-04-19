function cAPI.Initialize(model, skin, clothing, lastPosition)
    local decodedLastPosition = json.decode(lastPosition)

    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    -- local camera = cAPI.SkyCameraAtCoords(decodedLastPosition)
    print(model, skin, clothing, lastPosition)
    cAPI.SetModel(model)
    -- cAPI.SetSkin(skin)
    cAPI.replaceWeapons({})
  --  cAPI.SetClothing(clothing)
    Citizen.CreateThread(
        function()
            cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition)
        end
    )

    TriggerEvent("ToogleBackCharacter")
end
