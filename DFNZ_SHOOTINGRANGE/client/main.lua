lib.locale()
local icons, data, isChoosing, hasExercise, onExercise = Config.Icons, {}, false, false, false
local ped, target, timer

CreateThread(function()
    for k, v in pairs(Config.Locations) do 
        local coords = vec3(v.boss.coords.x, v.boss.coords.y, v.boss.coords.z)
        local point = lib.points.new({
            coords = coords,
            distance = 20
        })

        function point:onEnter()
            data = Config.Locations[k]
            spawnPed()
        end

        function point:onExit()
            DeleteEntity(ped)
        end

        if v.blip then 
            local blip = AddBlipForCoord(coords)
            SetBlipDisplay(blip, 4)
            SetBlipSprite(blip, Config.Blips.sprite)
            SetBlipColour(blip, Config.Blips.color)
            SetBlipScale(blip, Config.Blips.scale)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(locale('blip'))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

function spawnPed()
    -- get location
    local boss = data.boss
    -- load model
    local hash = lib.RequestModel(boss.ped)
    -- spawn ped
    ped = CreatePed(4, hash, boss.coords.x, boss.coords.y, boss.coords.z - 1.0, boss.coords.w, false, true)
    SetEntityHeading(ped, boss.coords.w)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, boss.scenario, -1, true)
    -- set target
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'shootingrange',
            label = locale('target'),
            icon = icons['target'].icon,
            iconColor = icons['target'].iconColor,
            onSelect = function()
                mainMenu()
            end
        },
    })
    -- unload model
    SetModelAsNoLongerNeeded(hash, true)
end

function mainMenu()
    -- get data
    local exercises = data.exercises
    -- building menu
    local options = {}

    options[#options + 1] = {
        title = locale('information'),
        description = locale('information_desc'),
        readOnly = true,
        icon = icons['info'].icon,
        iconColor = icons['info'].iconColor,
        iconAnimation = icons['info'].iconAnimation,
    }

    for k, v in pairs(exercises) do
        options[#options + 1] = {
            title = k, 
            description = locale('price')..v.price..locale('currency')..'\n'..locale('time')..v.time..locale('seconds')..'\n'..locale('targets')..v.targets..'\n'..locale('weapon')..v.weapon.label,
            icon = icons['start'].icon,
            iconColor = icons['start'].iconColor,
            iconAnimation = icons['start'].iconAnimation,
            arrow = true,
            onSelect = function()
                if Config.UseDialog then
                     exports.DFNZ_DIALOG:closeDialog() 
                end

                if hasExercise then return notify(locale('allready_has_exercise'), 'error') end
                local check = lib.callback.await('shootingrange:canStart', false, v.price, v.weapon.name)
                if check then 
                    hasExercise = true
                    return startExercise(k) 
                end
                if check == 'no weapon' then return notify(locale('no_weapon'), 'error') end
                if check == 'no money' then return notify(locale('no_money'), 'error') end   
            end
        }
    end

    if Config.UseDialog then
        exports.DFNZ_DIALOG:openDialog(ped, locale('menu_header'), options)
    else
        lib.registerContext({id = 'shootingrange', title = locale('menu_header'), options = options})
        lib.showContext('shootingrange')
    end
end

function startExercise(exercise)
    -- get data
    local ranges = data.ranges
    local targets = data.targets
    local exercise = data.exercises[exercise]
    local targetsCount = exercise.targets

    -- set target
    for k, v in pairs(ranges) do
        exports.ox_target:addSphereZone({
            coords = vec3(v.x, v.y, v.z),
            name = 'shootingrange'..k,
            rotation = v.w,
            radius = 0.5,
            distance = 1.0,
            options = {
                {
                    label = locale('exercise'),
                    icon = icons['target'].icon,
                    iconColor = icons['target'].iconColor,
                    onSelect = function()
                        isChoosing = false
                        SetEntityCoords(cache.ped, v.x, v.y, v.z - 1.0, false, false, false, true)
                        SetEntityHeading(cache.ped, v.w)
                        FreezeEntityPosition(cache.ped, true)
                        local weapon = GetHashKey(exercise.weapon.name)

                        countdown(10)
                        if countdown then
                            local time = math.floor(exercise.time * 1000)
                            timer = lib.timer(time, function()
                                if onExercise then
                                    finished('fail')
                                end
                            end, true)

                            onExercise = true
                            textUI(locale('targets')..targetsCount, 'target')
                            spawnTarget()
                            while onExercise do
                                if IsPedDeadOrDying(target, true) then
                                    targetsCount = targetsCount - 1
                                    if targetsCount == 0 then
                                        onExercise = false
                                        finished('success')                                    
                                    else
                                        DeleteEntity(target)
                                        spawnTarget()
                                        textUI(locale('targets')..targetsCount, 'target')
                                    end
                                end

                                if GetSelectedPedWeapon(cache.ped) ~= weapon then
                                    return finished('disqualified')
                                end

                                Wait(10)
                            end
                        end
                    end
                }
            }
        })
    end

    -- set marker
    local marker = Config.Marker
    local boss = vec3(data.boss.coords.x, data.boss.coords.y, data.boss.coords.z)
    isChoosing = true
    while isChoosing do
        for k, v in pairs(ranges) do
            DrawMarker(28, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, marker.r, marker.g, marker.b, marker.a, false, false, 2, nil, nil, false)
        end

        if #(cache.coords - boss) > 20.0 then 
            isChoosing = false
            finished('to_far_away')
        end
        Wait(1)
    end
end

function countdown(timer)
    -- set counter
    local counter = timer
    textUI(locale('start_in')..counter..locale('seconds'), 'countdown')
    -- remove counter
    if counter ~= 0 then
        repeat 
            Wait(1000)
            counter = counter - 1
            textUI(locale('start_in')..counter..locale('seconds'), 'countdown')
        until counter == 0
    end
    lib.hideTextUI()
    return true
end

function textUI(message, icon)
    local isOpen = lib.isTextUIOpen()
    if isOpen then 
        lib.hideTextUI()
    end
    lib.showTextUI(message, {
        position = Config.TextUI,
        icon = icons[icon].icon,
        iconColor = icons[icon].iconColor,
        iconAnimation = icons[icon].iconAnimation,
    })
end

function spawnTarget()
    -- check if entity exist
    if not DoesEntityExist(target) then
        -- get location
        local random = math.random(1, #data.targets)
        local position = data.targets[random]
        -- load model
        local hash = lib.RequestModel(Config.TargetPed)
        -- spawn ped
        target = CreatePed(4, hash, position.x, position.y, position.z - 1.0, position.w, false, true)
        SetEntityHeading(target, position.w)
        FreezeEntityPosition(target, true)
        SetBlockingOfNonTemporaryEvents(target, true)
        -- unload hash
        SetModelAsNoLongerNeeded(hash)
    else
        return
    end
end

function finished(type)
    -- reset checks
    onExercise = false
    hasExercise = false
    timer:forceEnd(false)
    FreezeEntityPosition(cache.ped, false)
    -- get data
    local ranges = data.ranges
    -- delete zones
    for k, v in pairs(ranges) do
        exports.ox_target:removeZone('shootingrange'..k)
    end
    -- delete target
    if DoesEntityExist(target) then
        DeleteEntity(target)
    end
    -- hide text ui
    lib.hideTextUI()
    -- notify
    if type == 'success' then
        notify(locale('finished'), 'success')
        TriggerServerEvent('shootingrange:finished')
    elseif type == 'fail' then
        notify(locale('failed'), 'error')
    elseif type == 'to_far_away' then
        notify(locale('to_far_away'), 'error')
    elseif type == 'disqualified' then
        notify(locale('disqualified'), 'error')
    end
end