#!/bin/zsh
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

# System
sudo nvram SystemAudioVolume=%00
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -boolean true

# Scrollbar 
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# Dock
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock tilesize -int 16 
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock pinning -string middle
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 36

defaults delete com.apple.dock mineffect

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# KeyBind
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"

## Change Ctrl to Command.
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771129</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771299</integer>\
</dict>
"

## Change Command to Ctrl.
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771299</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771129</integer>\
</dict>
"

## Change Caps Lock to Command.
defaults -currentHost write -g $modifiermapping -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771300</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771299</integer>\
</dict>
"

# Mouse
defaults write -g com.apple.mouse.scaling 5
defaults write -g com.apple.mouse.tapBehavior -int 1

# ScreenSaver 
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults write -g com.apple.trackpad.scaling -float 15

# Finder
defaults write com.apple.finder AppleShowAllFiles true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FinderSounds -bool no
chflags nohidden ~/Library

# Clock
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm:ss'

# Battery
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

killall Finder
killall Dock
killall SystemUIServer
