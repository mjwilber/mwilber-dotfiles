#!/bin/bash
#
# Write by Karfield
#
# Free to use it!)
#
echo "Running as: "$(/usr/bin/id)
BING=http://www.bing.com
TMPFILE=/tmp/bing.html
#WALLPAPER=/home/$(whoami)/Downloads/Wallpapers/Bing/bing-$(date +%Y-%m-%d).jpg
echo "Try to get the BING page..."
wget -q $BING -O $TMPFILE
! [ -e $TMPFILE ] && exit;
# This fails in cron but not from the command line with "sed: -e expression #1, char 60: Invalid range end" ?
# Splitting the sed command up a bit seems to make it ok
#FAILS URL=$BING$(sed -n "s/\(.*\)g_img={url\:'\([0-9a-Z?=%_\\-\\/\\.]*\)'\,id\(.*\)/\2/p" < $TMPFILE)
URL=$(sed -n "s/\(.*\)g_img=\(.*\)\,id\(.*\)/\2/p" < $TMPFILE)
URL=$BING$(/bin/echo $URL | sed -n "s/\(.*\)'\([^']*\)'/\2/p" )
echo URL=$URL
# Failed to work anymore 2013-01-16ish WALLPAPER_FILE=$(echo $URL | sed "s/.*%2f//")
WALLPAPER_FILE=$(echo $URL | sed "s/.*\///")
#debug echo WALLPAPER_FILE=$WALLPAPER_FILE
mkdir -p /home/$(whoami)/Downloads/Wallpapers/Bing/$(date +%Y)
WALLPAPER=/home/$(whoami)/Downloads/Wallpapers/Bing/$(date +%Y)/bing-$(date +%Y-%m-%d)-$WALLPAPER_FILE
#debug echo WALLPAPER=$WALLPAPER
echo "Get the picture's URL = "$URL
rm $TMPFILE
# mv $WALLPAPER{,-$olddate}
echo "Download the wallpaper... to file://$WALLPAPER"
wget -q $URL -O $WALLPAPER

if [ -e $WALLPAPER ]; then
echo "We got it, set the background..." $WALLPAPER
echo "gconftool-2 --type string --set /desktop/gnome/background/picture_filename $WALLPAPER"
#gconftool-2 --type string --set /desktop/gnome/background/picture_filename $WALLPAPER
#gconftool-2 --type string --set /desktop/gnome/background/picture_options zoom
#gconftool-2 --type string --set /desktop/gnome/background/primary_color black
fi

# In gnome 3
# gsettings get org.gnome.desktop.background picture-uri
# gsettings set org.gnome.desktop.background picture-uri file://$WALLPAPER
