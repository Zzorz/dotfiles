#! /bin/sh

wid=$1
class=$2
instance=$3
eval $4
title=$(xtitle "$wid")

#notify-send $instance
#notify-send $wid
#notify-send $title
#notify-send $class



#if [ "$class" = FloatingTerminal ] ; then
	#echo "$1" > ~/.cache/bspwm.ft
	#echo "bspc node $1 -g hidden=off" > ~/.cache/bspwm.ft
#elif [ "$instance" = zeal ] ; then
#	center $wid 1280 800
#fi
