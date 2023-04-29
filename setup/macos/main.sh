#!/bin/bash

ohai "Preferences"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Close any open `System Preferences` panes in order to
# avoid overriding the preferences that are being changed.

osascript -e 'tell application "System Preferences" to quit'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

source "${BASEDIR}/setup/macos/activity_monitor.sh"
source "${BASEDIR}/setup/macos/app_store.sh"
source "${BASEDIR}/setup/macos/calendar.sh"
source "${BASEDIR}/setup/macos/dock.sh"
source "${BASEDIR}/setup/macos/finder.sh"
source "${BASEDIR}/setup/macos/keyboard.sh"
source "${BASEDIR}/setup/macos/language_and_region.sh"
source "${BASEDIR}/setup/macos/mail.sh"
source "${BASEDIR}/setup/macos/photos.sh"
source "${BASEDIR}/setup/macos/safari.sh"
source "${BASEDIR}/setup/macos/screen.sh"
source "${BASEDIR}/setup/macos/textedit.sh"
source "${BASEDIR}/setup/macos/trackpad.sh"
source "${BASEDIR}/setup/macos/tweetbot.sh"
source "${BASEDIR}/setup/macos/ui_and_ux.sh"
