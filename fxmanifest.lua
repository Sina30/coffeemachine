fx_version 'cerulean'
game 'gta5'

author 'Authentic'
description 'Advanced Coffee Machine Script for ESX/QBCore'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/images/*.png',
    'html/images/*.jpg'
}

dependencies {
    '/server:4752',
    '/gameBuild:2189'
}