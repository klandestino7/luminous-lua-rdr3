fx_version 'adamant'
games {'gta5'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

-- UI
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/fonts/Circular-Bold.ttf",
	"ui/fonts/Circular-Book.ttf",
	"ui/assets/cursor.png",
	"ui/assets/close.png",
	"ui/front.js",
	"ui/script.js",
	"ui/style.css",
	'ui/debounce.min.js',
	"ui/menu/style.css",
	"ui/menu/script.js",

}

-- Client Scripts
client_scripts {
	"@_core/libs/utils.lua",
	"client.lua",
}
