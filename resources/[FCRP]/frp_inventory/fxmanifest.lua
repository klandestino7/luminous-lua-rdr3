fx_version "adamant"
games {"gta5"}

client_scripts {
    "@_core/config/Items.lua",
    "client.lua"
}

server_scripts {
    "@_core/libs/utils.lua",
    "server.lua"
}

ui_page "html2/index.html"

files {
    "html2/*",
    "html2/fonts/*",
    "html2/images/*",
    "html2/images/items/*"
}
