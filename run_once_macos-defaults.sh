#!/bin/bash

# macOS system settings

# Create screenshots directory
mkdir -p ~/screenshots

# Apple Global Domain
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g AppleTemperatureUnit -string "Celsius"
defaults write -g AppleShowAllExtensions -bool true
defaults write -g com.apple.trackpad.scaling -float 3
defaults write -g com.apple.trackpad.scrolling -float 0.5881999999999999
defaults write -g InitialKeyRepeat -float 15
defaults write -g KeyRepeat -float 2

# Control Center
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Clock" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true

# Dock
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock orientation -string "right"
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock tilesize -float 40

# Menu bar clock
defaults write com.apple.menuextra.clock ShowSeconds -bool true

# Screenshot
defaults write com.apple.screencapture location -string "~/screenshots"
defaults write com.apple.screencapture show-thumbnail -bool false

# Terminal
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"

# Restart affected applications
killall Dock 2>/dev/null || true

echo "macOS defaults configured. Some settings may require logout/restart."
