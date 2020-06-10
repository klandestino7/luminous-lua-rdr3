API_Database = {}
local API = exports['GHMattiMySQL']

---------------------------------------------
---------------DATABASE SYSTEM---------------
---------------------------------------------
DBConnect = {
	driver = 'ghmattimysql',
	host = '127.0.0.1',
	database = 'redm',
	user = 'root',
	password = '@#$#@%aihsdj'
}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local prepared_queries = {}
local db_initialized = false

function API_Database.registerDBDriver(name, on_init, on_prepare, on_query)
	if not db_drivers[name] then
		db_drivers[name] = {on_init, on_prepare, on_query}

		if name == DBConnect.driver then
			db_driver = db_drivers[name]

			local ok = on_init(DBConnect)
			if ok then
				db_initialized = true
				for _, prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare, 1, table.maxn(prepare)))
				end

				for _, query in pairs(cached_queries) do
					async(
						function()
							query[2](on_query(table.unpack(query[1], 1, table.maxn(query[1]))))
						end
					)
				end

				cached_prepares = nil
				cached_queries = nil
			else
				error('Conexão com o banco de dados perdida.')
			end
		end
	else
		error('Banco de dados registrado.')
	end
end

function API_Database.format(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end

function API_Database.prepare(name, query)
	prepared_queries[name] = true

	if db_initialized then
		db_driver[2](name, query)
	else
		table.insert(cached_prepares, {name, query})
	end
end

function API_Database.query(name, params, mode)
	if not prepared_queries[name] then
		error('query ' .. name .. " doesn't exist.")
	end

	if not mode then
		mode = 'query'
	end

	if db_initialized then
		return db_driver[3](name, params or {}, mode)
	else
		local r = async()
		table.insert(cached_queries, {{name, params or {}, mode}, r})
		return r:wait()
	end
end

function API_Database.execute(name, params)
	return API_Database.query(name, params, 'execute')
end

---------------------------------------------
---------------EXECUTE  SYSTEM---------------
---------------------------------------------
local queries = {}

local function on_init(cfg)
	return API ~= nil
end

local function on_prepare(name, query)
	queries[name] = query
end

local function on_query(name, params, mode)
	local query = queries[name]
	local _params = {}
	_params._ = true

	for k, v in pairs(params) do
		_params['@' .. k] = v
	end

	local r = async()

	if mode == 'execute' then
		API:QueryAsync(
			query,
			_params,
			function(affected)
				r(affected or 0)
			end
		)
	elseif mode == 'scalar' then
		API:QueryScalarAsync(
			query,
			_params,
			function(scalar)
				r(scalar)
			end
		)
	else
		API:QueryResultAsync(
			query,
			_params,
			function(rows)
				r(rows, #rows)
			end
		)
	end
	return r:wait()
end

Citizen.CreateThread(
	function()
		API:Query('SELECT 1')
		API_Database.registerDBDriver('ghmattimysql', on_init, on_prepare, on_query)
	end
)
----------	USER QUERIES -------------
API_Database.prepare('FCRP/CreateUser', 'INSERT INTO users(identifier, name, banned) VALUES(@identifier, @name, 0); SELECT LAST_INSERT_ID() AS id')
API_Database.prepare('FCRP/SelectUser', 'SELECT * from users WHERE identifier = @identifier')
API_Database.prepare('FCRP/BannedUser', 'SELECT banned from users WHERE user_id = @user_id')
API_Database.prepare('FCRP/SetBanned', 'UPDATE users SET banned = 1, reason = @reason WHERE user_id = @user_id')
API_Database.prepare('FCRP/UnBan', 'UPDATE users SET banned = 0, reason = "" WHERE user_id = @user_id')
API_Database.prepare('FCRP/Whitelisted', 'SELECT * from whitelist WHERE identifier = @identifier')

-------- CHARACTER QUERIES -----------
API_Database.prepare('FCRP/CreateCharacter', "INSERT INTO characters(user_id, characterName, groups, age) VALUES (@user_id, @charName, 0,@charAge); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare('FCRP/GetCharacters', 'SELECT * from characters WHERE user_id = @user_id')
API_Database.prepare('FCRP/GetCharacter', 'SELECT * from characters WHERE charid = @charid')
API_Database.prepare('FCRP/DeleteCharacter', 'DELETE FROM characters WHERE charid = @charid')
API_Database.prepare('FCRP/GetUserIdByCharId', 'SELECT user_id from characters WHERE charid = @charid')
API_Database.prepare('FCRP/GetCharNameByCharId', 'SELECT characterName from characters WHERE charid = @charid')
API_Database.prepare('FCRP/UpdateLevel', 'UPDATE characters SET level = @level WHERE charid = @charid')
API_Database.prepare('FCRP/UpdateXP', 'UPDATE characters SET xp = @xp WHERE charid = @charid')
API_Database.prepare('UPDATE:character_data_role', 'UPDATE characters SET groups = @role WHERE charid = @charid')
API_Database.prepare('UPDATE:character_data_clothing', 'UPDATE characters SET clothes = @clothing WHERE charid = @charid')
-------- CHARACTER DATATABLE QUERIES --------
API_Database.prepare('FCRP/SetCData', 'CALL setData(@target, @key, @value, @charid)')
API_Database.prepare('FCRP/GetCData', 'CALL getData(@target, @charid, @key)')
API_Database.prepare('FCRP/RemCData', 'CALL remData(@target, @key, @charid)')

API_Database.prepare('FCRP/SetSkinData', 'UPDATE characters SET SkinMdf = @value WHERE charid = @charid')

API_Database.prepare('FCRP/SetCWeaponData', 'UPDATE characters SET weapons = @weapons WHERE charid = @charid')

API_Database.prepare('FCRP/SetPlayerDeath', 'UPDATE characters SET is_dead = @is_dead WHERE charid = @charid')
API_Database.prepare('FCRP/GetPlayerDeath', 'SELECT is_dead from characters WHERE charid = @charid')

-------- FORT DATATABLE QUERIES --------
API_Database.prepare('FCRP/SetCFort', 'UPDATE fort SET bando = @bando WHERE id = @id')
API_Database.prepare('FCRP/GetCFort', 'SELECT bando from fort WHERE id = @id')

-------- JAIL DATATABLE QUERIES --------
API_Database.prepare('FCRP/SetCJail', 'INSERT INTO jail(charid, jail_time) VALUES (@charid, @jail_time); SELECT LAST_INSERT_ID() AS id')
API_Database.prepare('FCRP/UpdCJail', 'UPDATE jail SET jail_time = @jail_time WHERE charid = @charid')
API_Database.prepare('FCRP/GetCJail', 'SELECT * from jail WHERE charid = @charid')
API_Database.prepare('FCRP/RemCJail', 'DELETE FROM jail WHERE charid = @charid')

-------- QUEST DATATABLE QUERIES --------
API_Database.prepare('FCRP/SetQuest', 'INSERT INTO quest(questId, charid, questSteps) VALUES (@questId, @charid, @questSteps); SELECT LAST_INSERT_ID() AS id')
API_Database.prepare('FCRP/UpdQuest', 'UPDATE quest SET questSteps = @questSteps WHERE questId = @questId')
API_Database.prepare('FCRP/GetQuest', 'SELECT * from quest WHERE charid = @charid')
API_Database.prepare('FCRP/RemQuest', 'DELETE FROM quest WHERE questId = @questId')

-------- WANTED DATATABLE QUERIES --------
API_Database.prepare('FCRP/SetCWanted', 'INSERT INTO characters(wanted) VALUES (@wanted); SELECT LAST_INSERT_ID() AS user_id')
API_Database.prepare('FCRP/GetCWanted', 'SELECT wanted from characters WHERE charid = @charid')
API_Database.prepare('FCRP/UpdCWanted', 'UPDATE wanted SET wanted = @wanted WHERE charid = @charid')

-------- JOINAPP DATATABLE QUERIES --------
API_Database.prepare('FCRP/JoinAppS', 'SELECT steam from playerjoin WHERE steam = @identifier')
API_Database.prepare('FCRP/JoinAppD', 'DELETE FROM jail WHERE charid = @charid')

-------- INVENTORY QUERIES -----------
API_Database.prepare('FCRP/Inventory', 'CALL procInventory(@id, @charid, @slot, @itemId, @itemAmount, @procType);')
API_Database.prepare('UPDATE:inv_update_slot', 'CALL inv_update_slot(@inv_id, @slot_id, @slot_value)')
API_Database.prepare('UPDATE:inv_remove_slot', 'CALL inv_remove_slot(@inv_id, @slot_id);')
API_Database.prepare('SELECT:inv_select_slots_and_capacity', 'SELECT inv_slots, inv_capacity FROM inventories WHERE id = @inv_id')

---------- HORSE QUERIES -------------
API_Database.prepare('FCRP/CreateHorse', 'INSERT INTO horses(charid, model, name) VALUES (@charid, @model, @name); SELECT LAST_INSERT_ID() AS id')
API_Database.prepare('FCRP/GetHorses', 'SELECT * from horses WHERE charid = @charid')
API_Database.prepare('FCRP/GetHorse', 'SELECT * from horses WHERE id = @id')
API_Database.prepare('FCRP/DeleteHorse', 'DELETE FROM horses WHERE charid = @charid')

API_Database.prepare('UpdateHorseComponents', 'UPDATE horses SET components = @components WHERE id = @id')
API_Database.prepare('SelectHorseComponents', 'SELECT components FROM horses WHERE id = @id')

---------- POSSE QUERIES -------------
API_Database.prepare('FCRP/CreatePosse', 'INSERT INTO posses(charid, members, name) VALUES (@charid, @members, @name); SELECT LAST_INSERT_ID() AS id')
API_Database.prepare('FCRP/GetPosseById', 'SELECT * from posses WHERE id = @id')

---------- CHEST QUERIES -------------
API_Database.prepare('FCRP/GetChests', 'SELECT * from chests')
API_Database.prepare('FCRP/CreateChest', "INSERT INTO chests(charid, position, type, capacity) VALUES (@charid, @position, @type, @capacity); SELECT LAST_INSERT_ID() AS id")
API_Database.prepare('FCRP/CreateStaticChest', "INSERT INTO chests(position, type, capacity) VALUES (@position, @type, @capacity); SELECT LAST_INSERT_ID() AS id")

------------ CROP QUERIES --------------------
API_Database.prepare('UPDATE:crop_update_slot', 'UPDATE farms SET crop_percent_grown = @crop_percent_grown, crop_min_time_water = @crop_min_time_water WHERE crop_id = @crop_id AND slot_id = @slot_id')
API_Database.prepare('UPDATE:crop_remove_slot', 'DELETE FROM farms WHERE crop_id = @crop_id AND slot_id = @slot_id')
API_Database.prepare('INSERT:crop_insert_slot', 'INSERT INTO farms(crop_id, slot_id, crop_percent_grown, crop_min_time_water) VALUES (@crop_id, @slot_id, 0, @crop_min_time_water)')
API_Database.prepare('SELECT:get_crop_slots', 'SELECT slot_id, crop_percent_grown, crop_min_time_water FROM farms WHERE crop_id = @crop_id')

------------ HOUSE RENT QUERIES --------------
API_Database.prepare('INSERT:house_rent', 'INSERT INTO house_rent(house_id, house_next_payment) VALUES (@house_id, @house_next_payment)')
API_Database.prepare('SELECT:house_rent', 'SELECT house_next_payment from house_rent WHERE house_id = @house_id')
API_Database.prepare('DELETE:house_rent', 'DELETE FROM house_rent WHERE house_id = @house_id')