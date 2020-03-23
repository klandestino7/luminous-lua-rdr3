fx_version 'adamant'
games {'gta5'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script {
	'@_core/libs/utils.lua',
	'@_core/config/Items.lua',
	'@_core/config/CraftableItems.lua',
	'client.lua'
}

server_script {
	'@_core/libs/utils.lua',
	'@_core/config/CraftableItems.lua',
	'server.lua'
}

ui_page 'HTML/index.html'

files {
	'HTML/*',
}
