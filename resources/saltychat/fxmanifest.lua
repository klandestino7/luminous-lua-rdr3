fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page "NUI/SaltyWebSocket.html"

client_scripts {
    "client/SaltyClient.net.dll"
}

server_scripts {
    "server/SaltyServer.net.dll"
}

files {
    "NUI/SaltyWebSocket.html",
    "Newtonsoft.Json.dll",
}

exports {
    "EstablishCall",
    "EndCall",

    "SetPlayerRadioSpeaker",
    "SetPlayerRadioChannel",
    "RemovePlayerRadioChannel",
    "SetRadioTowers"
}

VoiceEnabled "true"
ServerUniqueIdentifier "Tp5R8cj0YhSKCw+AVZFd15xNa/Y="
RequiredUpdateBranch ""
MinimumPluginVersion ""
SoundPack "default"
IngameChannelId "22"
IngameChannelPassword "crazy@123"
