function API.getNameById(id)
    local rows = API_Database.query("FCRP/GetCharNameByCharId", {charid = id})
    if #rows > 0 then
        return rows[1].characterName
    end
    return "?"
end

--------------------------
-- Save Server Position --
--------------------------

-- serverPositions	= {}

RegisterServerEvent("updatePosOnServerForPlayer")
AddEventHandler(
    "updatePosOnServerForPlayer",
    function(x, y, z)
        local _source = source
        local User = API.getUserFromSource(_source)
        if User ~= nil then
            local Character = User:getCharacter()
            if Character ~= nil then
                Character:savePosition(x, y, z)
            end
        end
    end
)