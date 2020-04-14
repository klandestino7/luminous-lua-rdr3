function cAPI.SetModel(hash)
    cAPI.RequestModel(hash)

    SetPlayerModel(PlayerId(), hash)

    SetPedDefaultComponentVariation(PlayerPedId(), true)
end

function cAPI.SetClothing(encoded)
    local decoded = json.decode(encoded)

    local ped = PlayerPedId()

    local drawablesTable = decoded.drawables
    local texturesTable = decoded.drawTextures

    local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}

    for i = 1, #drawable_names do
        if drawablesTable[0] == nil then
            if drawable_names[i] == "undershirts" and drawablesTable[tostring(i - 1)][2] == -1 then
                SetPedComponentVariation(ped, i - 1, 15, 0, 2)
            else
                SetPedComponentVariation(ped, i - 1, drawablesTable[tostring(i - 1)][2], texturesTable[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawablesTable[i - 1][2] == -1 then
                SetPedComponentVariation(ped, i - 1, 15, 0, 2)
            else
                SetPedComponentVariation(ped, i - 1, drawablesTable[i - 1][2], texturesTable[i][2], 2)
            end
        end
    end

    local hairTable = decoded.getHair

    SetPedHairColor(player, tonumber(hairTable[0]), tonumber(hairTable[1]))
end

function cAPI.SetHeadData(encoded)
    local decoded = json.decode(encoded)

    local ped = PlayerPedId()
    if decoded ~= nil and #decoded > 0 then
        local headBlendTable = decoded.headBlend
        SetPedHeadBlendData(
            ped,
            tonumber(headBlendTable["shapeFirst"]),
            tonumber(headBlendTable["shapeSecond"]),
            tonumber(headBlendTable["shapeThird"]),
            tonumber(headBlendTable["skinFirst"]),
            tonumber(headBlendTable["skinSecond"]),
            tonumber(headBlendTable["skinThird"]),
            tonumber(headBlendTable["shapeMix"]),
            tonumber(headBlendTable["skinMix"]),
            tonumber(headBlendTable["thirdMix"]),
            false
        )

        local overlayTable = decoded.overlayHead

        if overlayTable ~= nil and #overlayTable > 0 then
            for i = 1, 13 do
                SetPedHeadOverlay(ped, i - 1, tonumber(overlayTable[i].overlayValue), tonumber(overlayTable[i].overlayOpacity))
                -- SetPedHeadOverlayColor(ped, i-1, overlayTable[i].colourType, overlayTable[i].firstColour, overlayTable[i].secondColour)
            end

            SetPedHeadOverlayColor(ped, 0, 0, tonumber(overlayTable[1].firstColour), tonumber(overlayTable[1].secondColour))
            SetPedHeadOverlayColor(ped, 1, 1, tonumber(overlayTable[2].firstColour), tonumber(overlayTable[2].secondColour))
            SetPedHeadOverlayColor(ped, 2, 1, tonumber(overlayTable[3].firstColour), tonumber(overlayTable[3].secondColour))
            SetPedHeadOverlayColor(ped, 3, 0, tonumber(overlayTable[4].firstColour), tonumber(overlayTable[4].secondColour))
            SetPedHeadOverlayColor(ped, 4, 2, tonumber(overlayTable[5].firstColour), tonumber(overlayTable[5].secondColour))
            SetPedHeadOverlayColor(ped, 5, 2, tonumber(overlayTable[6].firstColour), tonumber(overlayTable[6].secondColour))
            SetPedHeadOverlayColor(ped, 6, 0, tonumber(overlayTable[7].firstColour), tonumber(overlayTable[7].secondColour))
            SetPedHeadOverlayColor(ped, 7, 0, tonumber(overlayTable[8].firstColour), tonumber(overlayTable[8].secondColour))
            SetPedHeadOverlayColor(ped, 8, 2, tonumber(overlayTable[9].firstColour), tonumber(overlayTable[9].secondColour))
            SetPedHeadOverlayColor(ped, 9, 0, tonumber(overlayTable[10].firstColour), tonumber(overlayTable[10].secondColour))
            SetPedHeadOverlayColor(ped, 10, 1, tonumber(overlayTable[11].firstColour), tonumber(overlayTable[11].secondColour))
            SetPedHeadOverlayColor(ped, 11, 0, tonumber(overlayTable[12].firstColour), tonumber(overlayTable[12].secondColour))
        end

        local faceFeatureTable = decoded.headStruct

        for i = 1, 20 do
            SetPedFaceFeature(ped, i - 1, faceFeatureTable[i])
        end
    end

    cAPI.OutFade(500)
end
