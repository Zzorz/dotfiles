###############################################################################
# 函数
###############################################################################
function runonce {
	if ! pgrep $1 ;
	then
		$@&
	fi
}
function run { $@& }


###############################################################################
# 环境变量 //迁移到.pam_environment
###############################################################################
# 废弃
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.xrender=true"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export PATH=${PATH}:~/.local/bin

source $HOME/.cargo/env


###############################################################################
# 渲染 壁纸 显示 音频设置
###############################################################################
runonce /usr/lib/gsd-xsettings
runonce start-pulseaudio-x11
/usr/bin/pasuspender /bin/true
setxkbmap -option ctrl:nocaps
wmname LG3D

runonce sxhkd

xrandr --output Virtual1 --primary --auto --pos 1920x0 --mode 1920x1080 --rate 60

#black-and-white-pattern-texture.jpg
wallpaper=${HOME}/Pictures/winux.jpg
#run xwinwrap -ov -fs -- gifview -w WID -a $wallpaper
feh --bg-fill $wallpaper --bg-fill $wallpaper


#run compton --config $HOME/.config/bspwm/compton.conf
#run picom -b

# notification
runonce /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
runonce /usr/lib/xfce4/notifyd/xfce4-notifyd

# panel
runonce xfce4-panel
runonce nm-applet
#run /usr/bin/xfce4-power-manager
#run blueberry-tray

###############################################################################
# 杂项
###############################################################################

tmux new-session -s default -d
fcitx5 -d
#runonce flameshot
