#!/bin/sh
# Батарея → 60 Гц, сеть → 165 Гц на встроенной панели. Проверяет раз в 10 с;
# заодно возвращает 60 Гц, если перезагрузка конфига поставила 165 обратно.
#
# При смене питания переключает профиль tuned-ppd: батарея → power-saver
# (без турбобуста, EPP=power, ALPM, без nmi_watchdog), сеть → balanced.
# Если сессия держит NVIDIA (режим nvidia, вход на зарядке), отпустить её
# Hyprland на лету не умеет — напоминаем перелогиниться.
OUT=eDP-1 RES=1920x1200 POS=0x0
prev=
set_profile() {
    gdbus call --system --dest net.hadess.PowerProfiles \
        --object-path /net/hadess/PowerProfiles \
        --method org.freedesktop.DBus.Properties.Set \
        net.hadess.PowerProfiles ActiveProfile "<'$1'>" >/dev/null 2>&1
}
while :; do
    ac=$(cat /sys/class/power_supply/AC/online)
    if [ "$ac" = 1 ]; then hz=165; else hz=60; fi
    if ! hyprctl monitors | grep -qE "^\s*$RES@$hz\.[0-9]+ at"; then
        hyprctl eval "hl.monitor({output=\"$OUT\", mode=\"$RES@$hz\", position=\"$POS\", scale=1.0})" >/dev/null
    fi
    if [ "$ac" != "$prev" ]; then
        if [ "$ac" = 1 ]; then
            set_profile balanced
        else
            set_profile power-saver
            # По открытым файлам, а не по AQ_DRM_DEVICES: перезагрузка конфига
            # на батарее перепишет переменную, а карта останется открытой.
            if [ -n "$prev" ] && ls -l /proc/"$(pidof Hyprland)"/fd 2>/dev/null | grep -q /dev/nvidia; then
                notify-send -a Power "NVIDIA is still awake" \
                    "Log out and back in to power it off (logging in on battery uses Intel only)."
            fi
        fi
        prev=$ac
    fi
    sleep 10
done
