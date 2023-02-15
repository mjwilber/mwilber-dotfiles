#!/bin/sh

# Helpful screenshot options from https://sal.dev/macos/macos-screenshotting-tips-and-tricks/

# Update the default locations of ScreenShots
# Consider a place on the dock?
location=~/Pictures/ScreenShots
echo "Changing default location of screen shots to ${location}"
mkdir -p "${location}"
defaults write com.apple.screencapture location "${location}"

# Remove the shadow on screenshots
echo "Remove drop shadows on screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

# Take screenshots as jpg's instead of png's
echo "Screen shots should be jpgs for resource constraints"
defaults write com.apple.screencapture type jpg
# To switch back
# defaults write com.apple.screencapture type png


# Restart with new settings
echo "Restarting SystemUIServer to put new screen shot settings into effect"
killall SystemUIServer


