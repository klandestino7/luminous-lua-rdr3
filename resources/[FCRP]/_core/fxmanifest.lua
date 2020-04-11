fx_version 'adamant'
game 'gta5'

client_scripts {
	'libs/utils.lua',
	---------------------
	'config/Items.lua',
	'config/CraftableItems.lua', 
	'config/Garages.lua',
	---------------------
	'client/_Main.lua',
	'client/Wrapper.lua',
	'client/Death.lua',
	'client/BasicNeeds.lua',
	'client/Ped.lua',
	'client/UI.lua',
	'client/Vehicle.lua',
	'client/Player.lua',
	--'client/LoadIPL.lua',
}

server_scripts {
	'libs/utils.lua',
	---------------------
	'config/Items.lua',
	'config/XPSystem.lua',
	'config/Chests.lua',
	'config/Permissions.lua',
	---------------------
	'server/Database.lua',
	'server/_Main.lua',
	'server/Auth.lua',
	'server/Gui.lua',
	'server/BasicNeeds.lua',
	-----------------------
	'server/class/ItemData.lua',
	'server/class/Slot.lua',
	'server/class/Inventory.lua',
	'server/class/Character.lua',
	'server/class/User.lua',
	'server/class/Chest.lua',
	-- 'server/class/Posse.lua',
	-----------------------
	-- 'server/manager/ChestManager.lua',
	'server/manager/ItemDataManager.lua',
	'server/manager/CharacterManager.lua',
	-- 'server/manager/PosseManager.lua',
	'server/manager/ChestManager.lua',
}

files {
	'libs/utils.lua',
	'libs/Tunnel.lua',
	'libs/Proxy.lua',
	'libs/Tools.lua',
	'html/*',
	'html/img/*',
	'html/fonts/*',
	"loading/*",
}

loadscreen "loading/index.html"



ui_page 'html/index.html'
