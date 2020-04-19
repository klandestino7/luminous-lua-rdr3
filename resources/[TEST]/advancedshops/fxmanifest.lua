fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page('html/index.html') 

files({
  'html/index.html',
  'html/script.js',
  'html/style.css',
	'html/img/burger.png',
	'html/img/bottle.png',
  'html/font/vibes.ttf',
  'html/img/box.png',
	'html/img/carticon.png',
})

client_scripts {
  '@_core/libs/utils.lua',
  'config.lua',
  'client/main.lua',
  'locales/en.lua',
}

server_scripts {
  '@_core/libs/utils.lua',
  'config.lua',
  'server/main.lua',
}
