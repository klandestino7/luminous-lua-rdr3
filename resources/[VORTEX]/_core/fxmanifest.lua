fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
	"lib/utils.lua",
	"lib/area.lua",
	---------------------
	"config/Clothes.lua",
	"config/Items.lua",
	"config/CraftableItems.lua",
	---------------------
	"client/_Main.lua",
	"client/Horse.lua",
	"client/BasicNeeds.lua",
	"client/LoadIPL.lua",
	"client/Ped.lua",
	"client/Player.lua",
	"client/Wrapper.lua",
	"client/Area.lua",
	--"client/DebuggingControls.lua",
	---------------------
	--"shared/DoorStateContainer.lua"
}

server_scripts {
	"lib/utils.lua",
	---------------------
	"config/Items.lua",
	"config/XPSystem.lua",
	"config/Chests.lua",
	"config/Permissions.lua",
	---------------------
	"server/Database.lua",
	"server/_Main.lua",
	"server/Auth.lua",
	"server/Gui.lua",
	"server/BasicNeeds.lua",
	-----------------------
	"server/class/Slot.lua",
	"server/class/Inventory.lua",
	"server/class/ItemData.lua",
	"server/class/Character.lua",
	"server/class/User.lua",
	"server/class/Chest.lua",
	"server/class/ShopItem.lua",
	"server/class/Horse.lua",
	"server/class/Posse.lua",
	-----------------------
	"server/manager/ChestManager.lua",
	"server/manager/ItemDataManager.lua",
	"server/manager/CharacterManager.lua",
	"server/manager/HorseManager.lua",
	"server/manager/PosseManager.lua",
	"server/manager/AreaManager.lua",
	---------------------
	-- "shared/DoorStateContainer.lua"
}

files {
	"lib/utils.lua",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Tools.lua",
	"lib/warmenu.lua",
	"html/*",
	"html/img/*",
	"html/fonts/*"
}

ui_page "html/index.html"
