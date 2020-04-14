function cAPI.Initialize(model, skin, clothing, lastPosition)
    local decodedLastPosition = json.decode(lastPosition)

    local camera = cAPI.SkyCameraAtCoords(decodedLastPosition)
    cAPI.SetModel(model)
    cAPI.SetHeadData(skin)
    cAPI.SetClothing(clothing)
    cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition, camera)

    TriggerEvent("ToogleBackCharacter")
end

