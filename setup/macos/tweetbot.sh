#!/bin/bash

echo "==> Tweetbot"

# Bypass the annoyingly slow t.co URL shortener
defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

# killall "Tweetbot" &> /dev/null
