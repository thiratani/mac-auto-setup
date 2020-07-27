#!/bin/zsh
cat << EOS

 TkyLab

 me, and the other.

EOS

########## System
# システム音量の無効化
sudo nvram SystemAudioVolume=%00
# .DS_Storeファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# 保存ダイアログを詳細設定で表示
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -boolean true
# スクロール時のみスクロールバーを表示
defaults write -g AppleShowScrollBars -string "WhenScrolling"
# 自動大文字の無効化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# クラッシュレポートの無効化
defaults write com.apple.CrashReporter DialogType -string "none"
# Bluetoothヘッドフォン/ヘッドセットの音質を向上させる
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# デフォルトで秒まで表示
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm:ss'
# バッテリー残量をパーセントで表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# 時計アイコンクリック時に OS やホスト名 IP を表示する
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# ツールチップ表示のタイムラグをなくす
defaults write -g NSInitialToolTipDelay -integer 0
# ダイアログ表示やウィンドウリサイズ速度の高速化
defaults write -g NSWindowResizeTime 0.1

########## Mission Control
# 最新の使用状況に基づいて操作スペースを自動的に並べ替える
defaults write com.apple.dock mru-spaces -bool false

########## Dock
# Dockを自動的に隠さない
defaults write com.apple.dock autohide -bool false
# Dockアイコンのサイズ
defaults write com.apple.dock tilesize -int 16 
# Dockの表示位置（上下左右）
defaults write com.apple.dock orientation -string "left"
# Dockの表示位置（上中下）
defaults write com.apple.dock pinning -string middle
# Dockの拡大表示の有効化
defaults write com.apple.dock magnification -bool true
# Dockの拡大サイズ
defaults write com.apple.dock largesize -int 36
# Dockに表示されているデフォルトのアプリアイコンをすべて消去
defaults write com.apple.dock persistent-apps -array
# ウインドウをしまうときのエフェクト（デフォルトに戻す）
defaults delete com.apple.dock mineffect
# 開いているアプリケーションのみを表示
defaults write com.apple.dock static-only -bool true

########## Mouse
# マウスの速度
defaults write -g com.apple.mouse.scaling 5
# タップでクリック
defaults write -g com.apple.mouse.tapBehavior -int 1

########## Trackpad
# トラックパッドの速度
defaults write -g com.apple.trackpad.scaling -float 15
# タップでクリック
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

######### Keyboard
# キーのリピート
defaults write NSGlobalDomain KeyRepeat -int 2
# リピート入力認識までの時間
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# 英字入力中のスペルの自動変換
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

########## Finder
# デフォルトで隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles true
# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# サイドバーのアイコンサイズを大きく表示
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
# デフォルトでリストビュー形式で表示
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# デフォルトでLibraryを表示
chflags nohidden ~/Library

########## Safari
# ファイルのダウンロード後に自動でファイルを開くのを無効化する
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# Safari の開発・デバッグメニューを有効にする
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true    
# Safari の開発・デバッグメニューを有効にする
defaults write com.apple.Safari IncludeDevelopMenu -bool true
# Safari の開発・デバッグメニューを有効にする
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# アドレスバーに完全な URL を表示する
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# ステータスバーを表示する
defaults write com.apple.Safari ShowStatusBar -bool true
# 検索クエリを Apple へ送信しない
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# 検索クエリを Apple へ送信しない
defaults write com.apple.Safari UniversalSearchEnabled -bool false
# Safari の開発・デバッグメニューを有効にする
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

########## KeyBind
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"

# CtrlキーをCommandキーに変更
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771129</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771299</integer>\
</dict>
"

# CommandキーをCtrlキーに変更
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771299</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771129</integer>\
</dict>
"

# CapsLockキーをCommandキーに変更
defaults -currentHost write -g $modifiermapping -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771300</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771299</integer>\
</dict>
"

########## 
killall Dock
killall Finder
killall SystemUIServer
killall System\ Preferences
