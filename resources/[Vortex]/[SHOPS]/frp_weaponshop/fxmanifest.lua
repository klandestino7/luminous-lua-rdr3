fx_version 'adamant'
games {'rdr3'}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


ui_page 'html/index.html'

server_scripts {
	'@_core/lib/utils.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@_core/lib/utils.lua',
	'config.lua',
	'client.lua'
}

files {
	'html/index.html',
	'html/style.css',
	'html/app.js',
	'html/logo.png',
	'html/itens/*',
	'html/*',
	'html/Roboto-Regular.ttf'
}

