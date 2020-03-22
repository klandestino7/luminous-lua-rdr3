fx_version 'adamant'
games {'gta5'}

ui_page 'html/index.html'

server_scripts {
	'@_core/libs/utils.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@_core/libs/utils.lua',
	'@_core/config/Items.lua',
	'config.lua',
	'client.lua'
}

files {
	'html/index.html',
	'html/style.css',
	'html/app.js',
}

