dbAPI = {}
local API = exports['GHMattiMySQL']

---------------------------------------------
---------------DATABASE SYSTEM---------------
---------------------------------------------
DBConnect = {
	driver = 'ghmattimysql',
	host = '127.0.0.1',
	database = 'fcrp',
	user = 'root',
	password = ''
}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local prepared_queries = {}
local db_initialized = false

function dbAPI.registerDBDriver(name, on_init, on_prepare, on_query)
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

function dbAPI.format(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end

function dbAPI.prepare(name, query)
	prepared_queries[name] = true

	if db_initialized then
		db_driver[2](name, query)
	else
		table.insert(cached_prepares, {name, query})
	end
end

function dbAPI.query(name, params, mode)
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

function dbAPI.execute(name, params)
	return dbAPI.query(name, params, 'execute')
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
		dbAPI.registerDBDriver('ghmattimysql', on_init, on_prepare, on_query)
	end
)
----------	USER THIGNS -------------
dbAPI.prepare('FCRP/CreateUser', 'INSERT INTO users(identifier, name, banned) VALUES(@identifier, @name, 0); SELECT LAST_INSERT_ID() AS id')
dbAPI.prepare('FCRP/SelectUser', 'SELECT * from users WHERE identifier = @identifier')
dbAPI.prepare('FCRP/BannedUser', 'SELECT banned from users WHERE user_id = @user_id')
dbAPI.prepare('FCRP/SetBanned', 'UPDATE users SET banned = 1 WHERE user_id = @user_id')
dbAPI.prepare('FCRP/Whitelisted', 'SELECT * from whitelist WHERE identifier = @identifier')

-------- CHARACTER THIGNS -----------
dbAPI.prepare('FCRP/CreateCharacter', "INSERT INTO characters(user_id, characterName, age, skin, clothes, groups) VALUES (@user_id, @charName, @charAge, @charSkin, @clothes, '{\"user\":true}'); SELECT LAST_INSERT_ID() AS id")
dbAPI.prepare('FCRP/GetCharacters', 'SELECT * from characters WHERE user_id = @user_id')
dbAPI.prepare('FCRP/GetCharacter', 'SELECT * from characters WHERE charid = @charid')
dbAPI.prepare('FCRP/DeleteCharacter', 'DELETE FROM characters WHERE charid = @charid')
dbAPI.prepare('FCRP/GetUserIdByCharId', 'SELECT user_id from characters WHERE charid = @charid')
dbAPI.prepare('FCRP/GetCharNameByCharId', 'SELECT characterName from characters WHERE charid = @charid')
dbAPI.prepare('FCRP/UpdateLevel', 'UPDATE characters SET level = @level WHERE charid = @charid')
dbAPI.prepare('FCRP/UpdateXP', 'UPDATE characters SET xp = @xp WHERE charid = @charid')

-------- CHARACTER DATATABLE --------
dbAPI.prepare('FCRP/SetCData', 'CALL setData(@target, @key, @value, @charid)')
dbAPI.prepare('FCRP/GetCData', 'CALL getData(@target, @charid, @key)')
dbAPI.prepare('FCRP/RemCData', 'CALL remData(@target, @key, @charid)')
dbAPI.prepare('FCRP/SetCWeaponData', 'UPDATE characters SET weapons = @weapons WHERE charid = @charid')
-------- INVENTORY THINGS -----------
dbAPI.prepare('FCRP/Inventory', 'CALL inventories(@id, @charid, @itemName, @itemCount, @typeInv);')
dbAPI.prepare('FCRP/ForcedInventory', "INSERT INTO inventories(id, capacity, items) VALUES (@id, @capacity, @items);")
dbAPI.prepare('INVENTORY:procListOfItems', 'CALL procListOfItems(@id, @charid, @itemList, @procType);')

---------- HORSE THINGS -------------
dbAPI.prepare('FCRP/CreatePosse', 'INSERT INTO posses(charid, members, name) VALUES (@charid, @members, @name); SELECT LAST_INSERT_ID() AS id')
dbAPI.prepare('FCRP/GetPosseById', 'SELECT * from posses WHERE id = @id')

---------- CHEST QUERIES -------------
dbAPI.prepare('FCRP/GetChests', 'SELECT * from chests')
dbAPI.prepare('FCRP/CreateChest', "INSERT INTO chests(charid, position, type, capacity) VALUES (@charid, @position, @type, @capacity); SELECT LAST_INSERT_ID() AS id")
dbAPI.prepare('FCRP/CreateStaticChest', "INSERT INTO chests(position, type, capacity) VALUES (@position, @type, @capacity); SELECT LAST_INSERT_ID() AS id")


-- BEGIN
-- 	DECLARE json, item, itemId, itemAmount VARCHAR(4000);
-- 	DECLARE i INT DEFAULT 0;
-- 	SELECT itemList INTO json;

-- 	WHILE i < JSON_LENGTH(json) DO
-- 		IF (procType = "add") THEN
-- 			SELECT JSON_EXTRACT(json,CONCAT('$[',i,']')) INTO item;
-- 			SELECT JSON_EXTRACT(item,CONCAT('$[1]')) INTO itemId;
-- 			SELECT JSON_EXTRACT(item,CONCAT('$[2]')) INTO itemAmount;
-- 			UPDATE inventories SET items = JSON_SET(items, CONCAT("$.", itemId), itemAmount) WHERE id = iid;
-- 			SELECT i + 1 INTO i;
-- 		ELSEIF (procType = "remove") THEN
-- 			SELECT JSON_EXTRACT(json,CONCAT('$[',i,']')) INTO item;
-- 			SELECT JSON_EXTRACT(item,CONCAT('$[1]')) INTO itemId;
-- 			SELECT JSON_EXTRACT(item,CONCAT('$[2]')) INTO itemAmount;
-- 			UPDATE inventories SET items = JSON_REMOVE(items, CONCAT("$.", itemId)) WHERE id = iid;
-- 			SELECT i + 1 INTO i;
-- 		END IF;
-- 	END WHILE;
-- END