lib.locale()

function notify(message, type)
    lib.notify({title = locale('notify_title'), description = message, type = type, iconAnimation = Config.Notify.animation, position = Config.Notify.position, duration = Config.Notify.duration * 1000})
end