#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

$HOME/.config/polybar/launch.sh &

#change your keyboard if you need it
#setxkbmap -layout be

setxkbmap -option caps:ctrl_modifier &
keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')

sxhkd &

feh --bg-fill /usr/share/backgrounds/arcolinux/time-abstract.jpg &
#feh --randomize --bg-fill ~/Képek/*

#dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
xsetroot -cursor_name left_ptr &

#conky -c $HOME/.config/bspwm/system-overview &
#run variety &
#run nm-applet &
#run pamac-tray &
run xfce4-power-manager &
numlockx on &
#blueberry-tray &
#picom --config $HOME/.config/bspwm/picom.conf &
picom --experimental-backends --backend glx --xrender-sync-fence &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
#run volumeicon &
#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run discord &
#run spotify &
#run atom &
