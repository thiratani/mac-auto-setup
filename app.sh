#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

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
brew cask install iterm2
brew cask install sourcetree
brew cask install google-japanese-ime
brew cask install spotify
brew cask install visual-studio-code
brew cask install adobe-creative-cloud
brew cask install discord

while true; do
  read -p 'Add Other Apps "For Private"? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      # brew cask install dropbox
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

