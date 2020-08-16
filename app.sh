#!/bin/bash
cat << EOS

 TkyLab

 me, and the other.

EOS

#
# Install web apps.
#
echo " ----- Install web apps ------"
brew cask install 1password
brew cask install java
brew cask install android-studio
brew cask install atom
brew cask install google-chrome
brew cask install google-backup-and-sync
brew cask install sourcetree
brew cask install google-japanese-ime
brew cask install spotify
brew cask install visual-studio-code
brew cask install adobe-creative-cloud
brew cask install discord
brew cask install chatwork
brew cask install alfred
brew cask install shiftit
brew cask install karabiner-elements
brew cask install paw

while true; do
  read -p 'Add Other Apps "For Private"? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      brew cask install dropbox
      break;
      ;;
    [Nn]* )
      echo "Skip install"
      break;
      ;;
    * )
      echo Please answer YES or NO.
  esac
done;
echo " ------------ END ------------"

