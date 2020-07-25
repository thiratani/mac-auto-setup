#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

#
# Mac App Store apps install
#
echo " ---- Mac App Store apps -----"
brew install mas
mas install 409183694  # Keynote
mas install 409201541  # Pages 
mas install 409203825  # Numbers
mas install 549083868  # Display Menu (2.2.3)
mas install 1429033973 # RunCat (8.0)
mas install 1274495053 # Microsoft To Do (2.22)
mas install 715768417  # Microsoft Remote Desktop
echo " ------------ END ------------"
