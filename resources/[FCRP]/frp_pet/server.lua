local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


RegisterServerEvent('kcrp:buydog')
AddEventHandler('kcrp:buydog', function(dog)
    print(dog.Model)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

	if Inventory:getItemAmount('generic_money') < 2 then
        User:notify('Dinheiro insuficiente!')
        return
	end
	TriggerClientEvent('kcrp:spawndog', _source, dog.Model, false)	
end)

local function GetAmmoutdogs( Player_ID, Character_ID )
    local Hasdogs = MySQL.Sync.fetchAll( "SELECT * FROM dogs WHERE identifier = @identifier AND charid = @charid ", {
        ['identifier'] = Player_ID,
        ['charid'] = Character_ID
    } )
    if #Hasdogs > 0 then return true end
    return false
end

RegisterServerEvent('kcrp:buydog')
AddEventHandler( 'kcrp:buydog', function ( args )

    local _src   = source
    local _price = args['Price']
    local _level = args['Level']
    local _model = args['Model']


	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        u_identifier = user.getIdentifier()
        u_level = user.getLevel()
        u_charid = user.getSessionVar("charid")
        u_money = user.getMoney()
    end)

    local _resul = GetAmmoutdogs( u_identifier, u_charid )

    if u_money <= _price then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.NoMoney )
        return
    end

    if u_level <= _level then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.LevelMissing )
        return
    end

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        user.removeMoney(_price)
    end)

    TriggerClientEvent('kcrp:spawndog', _src, _model, true)


    if _resul ~= true then
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['dog'] = _model }
        MySQL.Async.execute("INSERT INTO dogs ( `identifier`, `charid`, `dog` ) VALUES ( @identifier, @charid, @dog )", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You bought a new pet' )
    else
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['dog'] = _model }
        MySQL.Async.execute(" UPDATE dogs SET dog = @dog WHERE identifier = @identifier AND charid = @charid ", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You replaced your old pet' )
    end

end)

RegisterServerEvent( 'kcrp:loaddog' )
AddEventHandler( 'kcrp:loaddog', function ( )

    local _src = source

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
	    u_identifier = user.getIdentifier()
	    u_charid = user.getSessionVar("charid")
	end)

    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid }
    local Hasdogs = MySQL.Sync.fetchAll( "SELECT * FROM dogs WHERE identifier = @identifier AND charid = @charid ", Parameters )

    if Hasdogs[1] then
        local dog = Hasdogs[1].dog
        print(dog)
        TriggerClientEvent("kcrp:spawndog", _src, dog, false)
    end

end )