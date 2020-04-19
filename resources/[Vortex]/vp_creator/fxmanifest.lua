fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_script("@_core/lib/utils.lua")
server_script('server.lua')

client_script('client/client.lua')

ui_page('client/html/index.html')

files({
    'client/html/img/*',
    'client/html/fonts/*',
    'client/html/*',
    'client/html/webfonts/*',
    'client/html/css/*',
    'server.lua'
})