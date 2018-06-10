#!/bin/zsh

[[ -f $HOME/.theme/bar ]] && source $HOME/.theme/bar

[[ -z "${colors[@]}" ]] && ( echo "No colors defined"; exit 1 )

barh=17
rrate=".2s"
p="  "
iconfont="FontAwesome:style=Regular"
#font="Liberation Mono for Powerline:style=Regular"
font="Space Mono for Powerline:style=Bold:size=10"

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=$'\ue0b0'

#bg="%{B#b58900}"
br="%{B-}"
txt="%{F#fff}"

segment() {
    local bg fg bgrgb fgrgb
    if [[ $CURRENT_BG == 'NONE' ]]; then
        bg=black
    else
        bg=${scheme[$CURRENT_BG]}
    fi
    fg=${foreground[$bg]}

    bg_rgb=${colors[$bg]}
    fg_rgb=${colors[$fg]}

    curr_bg_rgb=${colors[$CURRENT_BG]}
    if [[ $CURRENT_BG != 'NONE' ]]; then
        echo -n " %{F$curr_bg_rgb}%{B${bg_rgb}}${SEGMENT_SEPARATOR}%{F${fg_rgb}} "
    else
        echo -n "%{B${bg_rgb}}%{F${fg_rgb}} "
    fi
    CURRENT_BG=$bg
}

end_bar() {
    echo -n " %{F${colors[$CURRENT_BG]}}%{B-}${SEGMENT_SEPARATOR}"
}

desktop() {
    query=$(xprop -root _NET_DESKTOP_NAMES | awk -F" = " '{ print $2 }' | tr -d '"')
    desktops=("${(@s/, /)query}")
    numDesktops=${#desktops[@]}
    current=$(xprop -root _NET_CURRENT_DESKTOP | awk '{ print $NF }')
    let current="$current + 1"
    segment
    for (( i=1; i<=numDesktops; i++ ))
    do
        if [[ $i -ne 1 ]]; then
            echo -ne "|"
        fi
        if [[ $i -eq ${current} ]]; then
            echo -ne "%{F${colors[red]}}${desktops[$i]}%{F${colors[white]}}"
        else
            echo -ne "${desktops[$i]}"
        fi
    done
}

network() {
    id=$(iwgetid -r)
    segment
    if [[ "${id}" == "" ]]; then
        echo -n "No network"
    else
        echo -ne "\uf1eb ${id}"
    fi
}

cpu() {
    percent=$(cat /tmp/last_cpu.txt)
    segment
    #echo -ne "\uf2db ${percent}"
    echo -ne "\uf1fe ${percent}%"
}

hwmon_watercooling() {
    let cpu_temp=$(cat /sys/class/hwmon/hwmon0/temp2_input)/1000
    let fan_rpm=$(cat /sys/class/hwmon/hwmon0/fan2_input)
    let coolant_temp=$(visioncli -t2)
    segment
    echo -ne "\uf2c9 $cpu_temp°"
    segment
    echo -ne "|\uf043 $coolant_temp°"
    segment
    echo -ne "\uf110 $fan_rpm RPM"
}

hwmon() {
    if [[ "$(hostname)" = "canopus" ]]; then
        cpu_temp=$(sensors asus-isa-0000 | grep temp1 | awk '{ print $2 }')
        fan_rpm=$(sensors asus-isa-0000 | grep RPM | awk '{ print $2 }')
        segment
        echo -ne "\uf2c9 $cpu_temp|\uf110 $fan_rpm RPM"
    elif [[ "$(systemctl is-active pwmd)" = "active" ]]; then
        hwmon_watercooling
        return
    else
        let cpu_temp=$(cat /sys/class/hwmon/hwmon3/temp1_input)/1000
        rpm=$(cat /sys/class/hwmon/hwmon3/fan1_input)
        segment
        echo -ne "\uf2c9 $cpu_temp°|\uf110 $rpm RPM"
    fi
}

brightness() {
    if [[ ! -d /sys/class/backlight/intel_backlight ]]; then
        return
    fi
    current=$(cat /sys/class/backlight/intel_backlight/brightness)
    max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
    percent=$(bc <<< "scale=2; $current/$max*100.0")
    segment
    echo -ne "\uf26c $percent%"
}

sound() {
    sound_on=$(pactl list sinks short | awk '{ print $NF }')
    volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
    # pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo 30\%
    segment
    ico="\uf026"
    if [[ "$sound_on" == "RUNNING" ]]; then
        ico="\uf028"
    fi
    echo -ne "$ico $volume%"
}

battery() {
    if [[ ! -d /sys/class/power_supply/BAT0 ]]; then
        return
    fi
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)

    segment
    if [[ $power == "Charging" || $power == "Unknown" ]]; then
        echo -ne "\uf1e6 $percent%"
    else
        # icons...
        ico="\uf244"
        if [[ $percent -gt 87 ]]; then
            ico="\uf240"
        elif [[ $percent -gt 62 ]]; then
            ico="\uf241"
        elif [[ $percent -gt 37 ]]; then
            ico="\uf242"
        else
            ico="\uf243"
        fi
        echo -ne "${ico} $percent%"
    fi
}

clock() {
    segment
    echo -ne "\uf017 $(date '+%a %d %b, %T')"
}

power() {
    CURRENT_BG='NONE'
    segment
    echo -ne "%{r}%{A:qdbus org.kde.ksmserver /KSMServer logout 0 0 0:}\uf011%{A}"
}

vpn() {
    if ip addr | grep -q sslvpn; then
        segment
        echo -ne "\uf132 VPN"
    fi
}

build_bar () {
    declare -g CURRENT_BG='NONE'
    echo -en "%{l}"
    desktop
    network
    cpu
    hwmon
    battery
    brightness
    sound
    vpn
    clock
    end_bar
    #power
    echo ""
}

loop() {
    while true; do
        build_bar
        sleep "$rrate"
    done | $HOME/bin/lemonbar \
        -f "$font" \
        -f "$iconfont" \
        -g "x$barh" | bash
} 
if [[ -x ${HOME}/bin/cpu_usage ]]; then
    ${HOME}/bin/cpu_usage &
fi
loop
