fx_version 'adamant'
games {'gta5'}

ui_page 'html/index.html'

server_scripts {
	'@_core/libs/utils.lua',
	'server.lua'
}

client_scripts {
	'@_core/config/Items.lua',
	'client.lua'
}

files {
	'html/*',
}

