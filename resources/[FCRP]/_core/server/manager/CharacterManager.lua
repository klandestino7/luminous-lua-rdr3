function API.getNameById(id)
    local rows = dbAPI.query("FCRP/GetCharNameByCharId", {charid = id})
    if #rows > 0 then
        return rows[1].characterName
    end
    return "?"
end