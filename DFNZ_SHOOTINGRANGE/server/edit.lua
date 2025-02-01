function sendHook(header, message, id)
    local link = 'https://discord.com/api/webhooks/1334866703254945792/St7qw0E_5iqgUGHJlNhOFl9HSt9XPIKr2fz7VsdxToWwLao47nnlh17d4VEexJcRFFUo'    --> insert your link here
    exports.DFNZ_LOGGER:sendHook(link, header, message, id)      --> replace this export if you dont want to use my logger system
end