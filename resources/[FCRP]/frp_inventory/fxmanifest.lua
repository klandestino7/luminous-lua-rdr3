fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    '@_core/config/Items.lua',
	'client.lua'
}

server_scripts {
	"@_core/libs/utils.lua",
	'server.lua'
}

ui_page './html2/index.html'

files {
    './html2/fonts/*',
    './html2/*',
    './html2/images/*',
    './html2/images/items/*'
}
