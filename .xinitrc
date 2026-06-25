#!/bin/sh

APP="${OPENAPP:-wm}"

setxkbmap -layout pl,ua -option grp:caps_toggle # Установка польской(на базе английской) раскладки и украинской(с доступом к русским и белорусским символам)

TOUCHPAD="SynPS/2 Synaptics TouchPad"
xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 1
xinput set-prop "$TOUCHPAD" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$TOUCHPAD" "libinput Click Method Enabled" 0 0
#xinput set-prop "$TOUCHPAD" "libinput Send Events Mode Enabled" 1 0

feh --bg-tile /home/heg/Downloads/Carved\ Stone.png &


export XDG_SESSION_TYPE=x11

# Запуск сессионной шины D-Bus (критично для PipeWire)
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# Запуск звукового сервера и менеджера сессий в фоне
pipewire &
pipewire-pulse &
wireplumber & 


exec $APP
