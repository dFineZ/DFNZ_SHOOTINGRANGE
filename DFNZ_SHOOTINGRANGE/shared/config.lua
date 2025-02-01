Config = {}

--> if you want to add a skill system then you can add it in the server/main.lua

Config.UseLogger = true --> only set this to true if you want to use webhooks (basic script is DFNZ_LOGGER if you want to use antoher one edit it in server/edit.lua)
Config.UseDialog = true --> only set this to true if you use DFNZ_DIALOG
Config.PayAccount = 'money' --> choose betwenn money, bank or black_money
Config.TargetPed = 's_m_y_clown_01' --> ped that spawns as target
Config.WeaponsAsItems = true --> set this to false if your inventory dont use weapons as items

Config.Notify = {position = 'top', duration = 4, animation = 'beatFade'} --> duration in secs
Config.Marker = {r = 100, g = 100, b = 100, a = 250} --> marker color settings
Config.TextUI = 'bottom-center' --> textui position
Config.Icons = { --> icon settings
    ['target'] = {icon = 'fa-solid fa-bullseye', iconColor = '#FFFFFF', iconAnimation = 'beatFade'},
    ['info'] = {icon = 'circle-info', iconColor = '#FFFFFF', iconAnimation = 'beatFade'},
    ['start'] = {icon = 'right-to-bracket', iconColor = '#FFFFFF', iconAnimation = ''},
    ['countdown'] = {icon = 'fa-regular fa-clock', iconColor = '#FFFFFF', iconAnimation = 'beatFade'},
}

Config.Blips = {sprite = 468, color = 62, scale = 0.8} --> blip settings

Config.Locations = {
    [1] = {
        blip = true,
        boss = {coords = vec4(7.3445, -1096.0303, 29.7970, 248.1978), ped = 's_m_y_ammucity_01', scenario = 'WORLD_HUMAN_AA_SMOKE'},
        ranges = {
            vec4(12.2494, -1096.6407, 29.8347, 345.4146),
            vec4(13.1931, -1097.0068, 29.8347, 342.4529),
            vec4(14.0637, -1097.3983, 29.8348, 343.3226),
            vec4(15.0451, -1097.6570, 29.8348, 337.1081)
            --> add more by following the lines above
        },
        targets = {
            vec4(18.5861, -1090.1387, 29.7970, 158.7622),
            vec4(16.0866, -1079.5377, 29.7970, 162.1600),
            vec4(21.9093, -1081.9227, 29.7970, 157.8550),
            vec4(24.4272, -1072.6183, 29.7970, 159.2004),
            vec4(20.2004, -1074.7104, 29.7970, 157.4131),
            vec4(13.6809, -1085.2581, 29.6135, 161.6729),
            vec4(17.3357, -1085.9579, 29.7970, 165.1609),
            vec4(19.6115, -1080.8788, 29.7970, 141.9312),
            vec4(22.9216, -1085.6488, 29.7968, 142.1890),
            vec4(15.9250, -1089.5581, 29.7970, 163.7513)
            --> add more by following the lines above
        },
        exercises = {
            ['AK47 #1'] = {
                weapon = {name = 'WEAPON_ASSAULTRIFLE', label = 'AK47'}, --> player can only use this weapon
                targets = 15, --> targets to hit to finish the exercise
                time = 60, --> in seconds
                price = 30 --> price for the exercise
            },
            ['AK47 #2'] = {
                weapon = {name = 'WEAPON_ASSAULTRIFLE', label = 'AK47'}, 
                targets = 25,
                time = 60,
                price = 40
            },
            ['Glock 18 #1'] = {
                weapon = {name = 'WEAPON_PISTOL', label = 'Glock 18'}, 
                targets = 15,
                time = 60,
                price = 30
            },
            ['Glock 18 #2'] = {
                weapon = {name = 'WEAPON_PISTOL', label = 'Glock 18'},
                targets = 25,
                time = 60,
                price = 40
            },
        }
    },
    [2] = {
        blip = true,
        boss = {coords = vec4(827.7852, -2162.7246, 29.6190, 76.7073), ped = 's_m_y_ammucity_01', scenario = 'WORLD_HUMAN_AA_SMOKE'},
        ranges = {
            vec4(823.0516, -2163.7698, 29.6567, 181.2797),
            vec4(821.9192, -2163.8040, 29.6567, 181.3601),
            vec4(821.0421, -2163.8232, 29.6567, 176.9141),
            vec4(819.9420, -2163.8147, 29.6568, 174.2051)
            --> add more by following the lines above
        },
        targets = {
            vec4(819.2666, -2171.9705, 29.6190, 13.5991),
            vec4(823.4216, -2171.6321, 29.6661, 0.2302),
            vec4(819.7592, -2177.2844, 29.6190, 7.7390),
            vec4(824.5419, -2179.0583, 29.6190, 344.4360),
            vec4(822.0647, -2176.7202, 29.6190, 359.4496),
            vec4(824.1284, -2182.3826, 29.6190, 1.0754),
            vec4(818.9722, -2185.1755, 29.6190, 357.7888),
            vec4(826.8941, -2190.9343, 29.6190, 0.8703),
            vec4(820.3545, -2189.2141, 29.6190, 22.4175),
            vec4(823.5597, -2185.7014, 29.6190, 356.8564)
            --> add more by following the lines above
        },
        exercises = {
            ['AK47 #1'] = {
                weapon = {name = 'WEAPON_ASSAULTRIFLE', label = 'AK47'},
                targets = 15,
                time = 60,
                price = 30 
            },
            ['AK47 #2'] = {
                weapon = {name = 'WEAPON_ASSAULTRIFLE', label = 'AK47'}, 
                targets = 25,
                time = 60,
                price = 40
            },
            ['Glock 18 #1'] = {
                weapon = {name = 'WEAPON_PISTOL', label = 'Glock 18'}, 
                targets = 15,
                time = 60,
                price = 30
            },
            ['Glock 18 #2'] = {
                weapon = {name = 'WEAPON_PISTOL', label = 'Glock 18'},
                targets = 25,
                time = 60,
                price = 40
            },
        }
    }
}
