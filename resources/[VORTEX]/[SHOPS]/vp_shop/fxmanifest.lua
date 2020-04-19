fx_version 'adamant'
games {'gta5'}

ui_page 'nui/index.html'

server_scripts {
	'@_core/lib/utils.lua',
	'_cfg.lua',
	'server.lua'
}

client_scripts {
	'@_core/lib/utils.lua',
	'@_core/config/Items.lua',
	'_cfg.lua',
	'client.lua'
}

files {
	'nui/index.html',
	'nui/style.css',
	'nui/app.js',
}

