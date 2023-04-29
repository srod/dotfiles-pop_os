#!/bin/bash

echo "==> Dock"

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool true

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Double-click a window's title bar to minimize
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool true

# Enable magnification
defaults write com.apple.dock magnification -bool true

# Set the icon size of Dock items to 44 pixels
defaults write com.apple.dock tilesize -int 44

# Set the over icon size of Dock items to 64 pixels
defaults write com.apple.dock largesize -int 64

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → Mission Control
#defaults write com.apple.dock wvous-tl-corner -int 2
#defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
#defaults write com.apple.dock wvous-tr-corner -int 4
#defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
#defaults write com.apple.dock wvous-bl-corner -int 5
#defaults write com.apple.dock wvous-bl-modifier -int 0
# ⌘ Bottom left screen corner → Start screen saver

defaults write com.apple.dock 'wvous-bl-corner' -int 5
defaults write com.apple.dock 'wvous-bl-modifier' -int 1048576

defaults write com.apple.dock 'wvous-br-corner' -int 13
defaults write com.apple.dock 'wvous-br-modifier' -int 1048576

# killall "Dock" &> /dev/null
