#!/bin/bash

echo "==> UI & UX"

# Use dark menu bar and Dock
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable window opening and closing animations.
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Disable opening a Quick Look window animations.
defaults write -g QLPanelAnimationDuration -float 0

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Set computer name
read -r -p "Please provide a name for your computer: " COMPUTER_NAME
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Build Locate Database
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Enable audio feedback when volume is changed
defaults write com.apple.sound.beep.feedback -bool true

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# killall "SystemUIServer" &> /dev/null
