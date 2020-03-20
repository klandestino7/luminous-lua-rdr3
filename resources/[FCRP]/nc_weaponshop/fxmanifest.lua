fx_version 'adamant'
games {'gta5'}

ui_page 'html/index.html'

server_scripts {
	'@_core/libs/utils.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@_core/libs/utils.lua',
	'config.lua',
	'client/main.lua'
}

files {
	'html/index.html',
	'html/style.css',
	'html/app.js',
	'html/logo.png',
	'html/itens/*',
	'html/Roboto-Regular.ttf'
}

