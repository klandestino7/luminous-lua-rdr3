fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script {
	'config/mp_male.lua',
	'config/mp_female.lua',
	'client.lua'
}

server_script {
	'@_core/libs/utils.lua',
	'server.lua'
}

ui_page 'html/index.html'

files {
	'html/*',
	'html/css/*',
	'html/fonts/*',
	'html/js/*',
	'html/assets/*',
	'html/assets/barbercolors/*',
	'html/assets/eyecolors/*',
	'html/assets/haircolors/*',
	'html/assets/skincolors/*'
}
