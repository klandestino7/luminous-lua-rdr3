local function checkExistenceClothes(cid, cb)
    exports.ghmattimysql:execute("SELECT cid FROM character_current WHERE cid = @cid LIMIT 1;", {["cid"] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

local function checkExistenceFace(cid, cb)
    exports.ghmattimysql:execute("SELECT cid FROM character_face WHERE cid = @cid LIMIT 1;", {["cid"] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

RegisterServerEvent("nc_clothes:insert_character_current")
AddEventHandler("nc_clothes:insert_character_current",function(data)
    if not data then return end
    local _source = source
    local User = API.getUserFromSource(_source)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if not Character then return end
    checkExistenceClothes(Character, function(exists)
        local values = {
            ["cid"] = Character,
            ["model"] = json.encode(data.model),
            ["drawables"] = json.encode(data.drawables),
            ["props"] = json.encode(data.props),
            ["drawtextures"] = json.encode(data.drawtextures),
            ["proptextures"] = json.encode(data.proptextures),
        }

        if not exists then
            local cols = "cid, model, drawables, props, drawtextures, proptextures"
            local vals = "@cid, @model, @drawables, @props, @drawtextures, @proptextures"

            exports.ghmattimysql:execute("INSERT INTO character_current ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
        exports.ghmattimysql:execute("UPDATE character_current SET "..set.." WHERE cid = @cid", values)
    end)
end)

RegisterServerEvent("nc_clothes:insert_character_face")
AddEventHandler("nc_clothes:insert_character_face",function(data)
    if not data then return end
    local _source = source
    local User = API.getUserFromSource(_source)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if not Character then return end

    checkExistenceFace(Character, function(exists)
        if data.headBlend == "null" or data.headBlend == nil then
            data.headBlend = '[]'
        else
            data.headBlend = json.encode(data.headBlend)
        end
        local values = {
            ["cid"] = Character,
            ["hairColor"] = json.encode(data.hairColor),
            ["headBlend"] = data.headBlend,
            ["headOverlay"] = json.encode(data.headOverlay),
            ["headStructure"] = json.encode(data.headStructure),
        }

        if not exists then
            local cols = "cid, hairColor, headBlend, headOverlay, headStructure"
            local vals = "@cid, @hairColor, @headBlend, @headOverlay, @headStructure"

            exports.ghmattimysql:execute("INSERT INTO character_face ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "hairColor = @hairColor,headBlend = @headBlend, headOverlay = @headOverlay,headStructure = @headStructure"
        exports.ghmattimysql:execute("UPDATE character_face SET "..set.." WHERE cid = @cid", values )
    end)
end)

RegisterServerEvent("nc_clothes:get_character_face")
AddEventHandler("nc_clothes:get_character_face",function(pSrc)
    local src = (not pSrc and source or pSrc)
    
    local _source = source
    local User = API.getUserFromSource(_source)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if not Character then return end

    exports.ghmattimysql:execute("SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure FROM character_face cf INNER JOIN character_current cc on cc.cid = cf.cid WHERE cf.cid = @cid", {['cid'] = Character}, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local temp_data = {
                hairColor = json.decode(result[1].hairColor),
                headBlend = json.decode(result[1].headBlend),
                headOverlay = json.decode(result[1].headOverlay),
                headStructure = json.decode(result[1].headStructure),
            }
            local model = tonumber(result[1].model)
            if model == 1885233650 or model == -1667301416 then
                TriggerClientEvent("nc_clothes:setpedfeatures", src, temp_data)
            end
        else
            TriggerClientEvent("nc_clothes:setpedfeatures", src, false)
        end
	end)
end)

RegisterServerEvent("nc_clothes:get_character_current")
AddEventHandler("nc_clothes:get_character_current",function(pSrc)
    local src = (not pSrc and source or pSrc)
 --  local _source = source
    local User = API.getUserFromSource(src)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if not Character then return end

    exports.ghmattimysql:execute("SELECT * FROM character_current WHERE cid = @cid", {['cid'] = Character}, function(result)
        local temp_data = {
            model = result[1].model,
            drawables = json.decode(result[1].drawables),
            props = json.decode(result[1].props),
            drawtextures = json.decode(result[1].drawtextures),
            proptextures = json.decode(result[1].proptextures),
        }
        TriggerClientEvent("nc_clothes:setclothes", src, temp_data,0)
	end)
end)

RegisterServerEvent("nc_clothes:retrieve_tats")
AddEventHandler("nc_clothes:retrieve_tats", function(pSrc)
    local src = (not pSrc and source or pSrc)
	--local user = exports["np-base"]:getModule("Player"):GetUser(src)
    --ocal char = user:getCurrentCharacter()
--	exports.ghmattimysql:execute("SELECT * FROM playersTattoos WHERE identifier = @identifier", {['identifier'] = char.id}, function(result)
       -- if(#result == 1) then
		--	TriggerClientEvent("nc_clothes:settattoos", src, json.decode(result[1].tattoos))
		--else
		--	local tattooValue = "{}"
		--	exports.ghmattimysql:execute("INSERT INTO playersTattoos (identifier, tattoos) VALUES (@identifier, @tattoo)", {['identifier'] = char.id, ['tattoo'] = tattooValue})
			TriggerClientEvent("nc_clothes:settattoos", src, {})
		--end
	--end)
end)

RegisterServerEvent("nc_clothes:set_tats")
AddEventHandler("nc_clothes:set_tats", function(tattoosList)
	local src = source
	local User = API.getUserFromSource(src)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if not Character then return end
	exports.ghmattimysql:execute("UPDATE playersTattoos SET tattoos = @tattoos WHERE identifier = @identifier", {['tattoos'] = json.encode(tattoosList), ['identifier'] = char.id})
end)


RegisterServerEvent("nc_clothes:get_outfit")
AddEventHandler("nc_clothes:get_outfit",function(slot)
    if not slot then return end
    local src = source

    local User = API.getUserFromSource(src)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if not Character then return end

    exports.ghmattimysql:execute("SELECT * FROM character_outfits WHERE cid = @cid and slot = @slot", {
        ['cid'] = Character,
        ['slot'] = slot
    }, function(result)
        if result and result[1] then
            if result[1].model == nil then
                TriggerClientEvent("DoLongHudText", src, "Can not use.",2)
                return
            end

            local data = {
                model = result[1].model,
                drawables = json.decode(result[1].drawables),
                props = json.decode(result[1].props),
                drawtextures = json.decode(result[1].drawtextures),
                proptextures = json.decode(result[1].proptextures),
                hairColor = json.decode(result[1].hairColor)
            }

            TriggerClientEvent("nc_clothes:setclothes", src, data,0)

            local values = {
                ["cid"] = Character,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
            }

            local set = "model = @model, drawables = @drawables, props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
            exports.ghmattimysql:execute("UPDATE character_current SET "..set.." WHERE cid = @cid",values)
        else
            TriggerClientEvent("DoLongHudText", src, "No outfit on slot " .. slot,2)
            return
        end
	end)
end)

RegisterServerEvent("nc_clothes:set_outfit")
AddEventHandler("nc_clothes:set_outfit",function(slot, name, data)
    if not slot then return end
    local src = source
    local User = API.getUserFromSource(src)
    if User == nil then
        return
    end
    local Character = User:getCharacter()

    if not Character then return end

    exports.ghmattimysql:execute("SELECT slot FROM character_outfits WHERE cid = @cid and slot = @slot", {
        ['cid'] = Character,
        ['slot'] = slot
    }, function(result)
        if result and result[1] then
            local values = {
                ["cid"] = Character,
                ["slot"] = slot,
                ["name"] = name,
                ["model"] = json.encode(data.model),
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor),
            }

            local set = "model = @model,name = @name,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures,hairColor = @hairColor"
            exports.ghmattimysql:execute("UPDATE character_outfits SET "..set.." WHERE cid = @cid and slot = @slot",values)
        else
            local cols = "cid, model, name, slot, drawables, props, drawtextures, proptextures, hairColor"
            local vals = "@cid, @model, @name, @slot, @drawables, @props, @drawtextures, @proptextures, @hairColor"

            local values = {
                ["cid"] = Character,
                ["name"] = name,
                ["slot"] = slot,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor)
            }

            exports.ghmattimysql:execute("INSERT INTO character_outfits ("..cols..") VALUES ("..vals..")", values, function()
                TriggerClientEvent("DoLongHudText", src, name .. " stored in slot " .. slot,1)
            end)
        end
	end)
end)


RegisterServerEvent("nc_clothes:remove_outfit")
AddEventHandler("nc_clothes:remove_outfit",function(slot)

    local src = source
    local User = API.getUserFromSource(src)
    if User == nil then
        return
    end
    local Character = User:getCharacter()

    if not Character then return end

    exports.ghmattimysql:execute( "DELETE FROM character_outfits WHERE cid = @cid AND slot = @slot", { ['cid'] = cid,  ["slot"] = slot } )
    TriggerClientEvent("DoLongHudText", src,"Removed slot " .. slot .. ".",1)
end)

RegisterServerEvent("nc_clothes:list_outfits")
AddEventHandler("nc_clothes:list_outfits",function()
    local src = source
    local User = API.getUserFromSource(src)
    if User == nil then
        return
    end
    local Character = User:getCharacter()

    if not Character then return end

    exports.ghmattimysql:execute("SELECT slot, name FROM character_outfits WHERE cid = @cid", {['cid'] = cid}, function(skincheck)
    	TriggerClientEvent("hotel:listSKINSFORCYRTHESICKFUCK",src, skincheck)
	end)
end)


RegisterServerEvent("clothing:checkIfNew")
AddEventHandler("clothing:checkIfNew", function()
    local src = source
    local User = API.getUserFromSource(src)
    if User == nil then
        return
    end
    local Character = User:getCharacter()

    if not Character then return end

    exports.ghmattimysql:execute("SELECT count(rank) whitelist FROM jobs_whitelist WHERE cid = @cid LIMIT 1", {
        ['cid'] = cid
    }, function(isWhitelisted)
        exports.ghmattimysql:scalar("SELECT count(model) FROM character_current WHERE cid = @cid LIMIT 1", {
            ['cid'] = cid
        }, function(result)
            local isService = false;
            if(isWhitelisted[1].whitelist >= 1) then isService = true end


            if result == 0 then
                exports.ghmattimysql:execute("select count(cid) assExist from (select cid  from character_current union select cid from characters_clothes) a where cid =  @cid", {['cid'] = cid}, function(clothingCheck)
                    local existsClothing = clothingCheck[1].assExist
                    TriggerClientEvent('nc_clothes:setclothes',src,{},existsClothing)
                end)
                return
            else
                TriggerEvent("nc_clothes:get_character_current", src)
            end
            TriggerClientEvent("nc_clothes:inService",src,isService)
    	end)
    end)
end)

RegisterServerEvent("clothing:checkMoney")
AddEventHandler("clothing:checkMoney", function(menu,askingPrice)
    local src = source
    
    local User = API.getUserFromSource(src)
    if User == nil then
        return
    end
    local Character = User:getCharacter()

    if not Character then return end

    if not askingPrice
    then
        askingPrice = 0
    end

  --  if (tonumber(target:getCash()) >= askingPrice) then
      --  target:removeMoney(askingPrice)
        print("DoShortHudText",src, "You Paid $"..askingPrice,8)
        TriggerClientEvent("DoShortHudText",src, "You Paid $"..askingPrice,8)
        TriggerClientEvent("nc_clothes:hasEnough",src,menu)
  --  else
   --     TriggerClientEvent("DoShortHudText",src, "You need $"..askingPrice.." + Tax.",2)
  --  end
end)