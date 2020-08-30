###############################################################################
# 函数
###############################################################################
function runonce {
  if ! pgrep $1 ;
  then
    $@&
  fi

  if [ ! -f $1 ]
  then
	  $@&
  fi

}
function run { $@& }


###############################################################################
# 环境变量 //迁移到.pam_environment
###############################################################################
# 废弃

###############################################################################
# 渲染 壁纸 显示 音频设置
###############################################################################
runonce /usr/lib/gsd-xsettings 

#runonce start-pulseaudio-x11
/usr/bin/pasuspender /bin/true
setxkbmap -option ctrl:nocaps
wmname LG3D

runonce sxhkd

#xrandr --output eDP1 --primary --auto --pos 320x1440 --rotate normal --output HDMI1  --auto --pos 0x0 
#xrandr --output eDP-1 --primary --auto --pos 320x1440 --rotate normal --output HDMI-1  --auto --pos 0x0 
#xrandr --output eDP1 --primary --auto --pos 1920x0 --rotate normal --output HDMI1  --auto --pos 0x0 --rotate inverted 
#xrandr --output eDP-1 --primary --auto --pos 1920x0 --rotate normal --output HDMI-1  --auto --pos 0x0 --rotate inverted 
#xrandr --output eDP-1 --primary --auto --rotate normal --output HDMI-1  --auto --pos 0x0

#black-and-white-pattern-texture.jpg
wallpaper=${HOME}/Pictures/winux.jpg
#runonce xwinwrap -ov -fs -- gifview -w WID -a $wallpaper
feh --bg-fill $wallpaper --bg-fill $wallpaper
#nitrogen --restore


#run compton --config $HOME/.config/bspwm/compton.conf
picom -b

# notification
#runonce /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# panel
#runonce nm-applet
#runonce blueberry-tray

###############################################################################
# 杂项
###############################################################################

#runonce goldendict
#libinput-gestures-setup start
runonce fcitx5
#runonce flameshot
#runonce redshift-gtk
