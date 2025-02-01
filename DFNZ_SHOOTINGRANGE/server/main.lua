lib.locale()

lib.callback.register('shootingrange:canStart', function(source, price, weapon, ammo, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.WeaponsAsItems then 
        if not xPlayer.hasItem(weapon) then return 'no weapon' end
    else
        if not xPlayer.hasWeapon(weapon) then return 'no weapon' end
    end

    if xPlayer.getAccount(Config.PayAccount).money < price then return 'no money' end

    xPlayer.removeAccountMoney(Config.PayAccount, price)
    if Config.UseLogger then
        sendHook(locale('exercise_paid'), '**'..locale('price')..'** '..price..locale('currency'), xPlayer.source)
    end
    return true
end)

RegisterServerEvent('shootingrange:finished')
AddEventHandler('shootingrange:finished', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.UseLogger then
        sendHook(locale('exercise_success'), '', xPlayer.source)
    end

    -- insert your skill or anything else here!
end)