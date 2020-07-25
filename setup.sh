#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

function command_exists {
  command -v "$1" > /dev/null;
}

#
# Copy git ssh config file
#
echo " ------- Git SSH config ------"
cp $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/git/config ~/.ssh/config
while true; do
  read -p 'Now git ssh settings? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      ssh-keygen -t rsa
      chmod 600 ~/.ssh/id_rsa.github
      eval `ssh-agent`
      ssh-add -K ~/.ssh/id_rsa.github
      ssh-add -l
      echo "Let’s register your public key on GitHub"
      break;
      ;;
    [Nn]* )
      echo "Skip settings"
      break;
      ;;
    * )
      echo Please answer YES or NO.
  esac
done;
echo " ------------ END ------------"

#
# Mac App Store apps install
#
if ! command_exists mas ; then
  echo " ---- Mac App Store apps -----"
  brew install mas
  mas install 497799835  # Xcode (8.2.1)
  echo " ------------ END ------------"
fi

#
# Install zsh
#
if ! command_exists zsh ; then
  echo " ------------ zsh ------------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
  chsh -s /usr/local/bin/zsh
  echo " ------------ END ------------"
fi

#
# Install vim
#
if ! command_exists vim ; then
  echo " ------------ Vim ------------"
  brew install vim --with-override-system-vi
  echo " ------------ END ------------"
fi

#
# Install ruby
#
if ! command_exists rbenv ; then
  echo " ----------- Ruby ------------"
  brew install rbenv
  brew install ruby-build
  rbenv --version
  rbenv install -l
  ruby_latest=$(rbenv install -l | grep -v '[a-z]' | tail -1 | sed 's/ //g')
  rbenv install $ruby_latest
  rbenv global $ruby_latest
  rbenv rehash
  ruby -v
  echo " ------------ END ------------"
fi

#
# Install dotfiles system
#
echo " ---------- dotfiles ---------"
sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"
cp $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/zsh/private.zsh ~/.yadr/zsh/private.zsh
source ~/.zshrc
echo " ------------ END ------------"

#
# Install Node.js env
#
if ! command_exists nodebrew ; then
  echo " ---------- Node.js ----------"
  curl -L git.io/nodebrew | perl - setup
  nodebrew ls-remote
  nodebrew install-binary latest
  nodebrew ls
  nodebrew use latest
  node -v
  npm -v
  echo " ------------ END ------------"
fi

#
# Install wget
#
if ! command_exists wget ; then
  echo " ----------- wget ------------"
  brew install wget
  wget --version
  echo " ------------ END ------------"
fi

#
# CocoaPods
#
if ! command_exists pod ; then
  echo " --------- CocoaPods ---------"
  echo $pass | sudo -S gem install -n /usr/local/bin cocoapods --pre
  pod setup
  echo " ------------ END ------------"
fi

#
# Carthage
#
if ! command_exists carthage ; then
  echo " --------- Carthage ----------"
  brew install carthage
  echo " ------------ END ------------"
fi

#
# swiftenv
#
if ! command_exists swiftenv ; then
  echo " --------- swiftenv ----------"
  brew install kylef/formulae/swiftenv
  echo 'if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi' >> ~/.yadr/zsh/private.zsh
  swiftenv rehash
  echo " ------------ END ------------"
fi

while true; do
  read -p 'Now install web apps? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/app.sh
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

while true; do
  read -p 'Now install App Store apps? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/appstore.sh
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

read -p 'Please enter your GitHub Access Token. You can skip by typing "N".' Answer
case $Answer in
  '' | [Nn]* )
    echo "Skip"
    ;;
  * )
    echo "export GITHUB_ACCESS_TOKEN=${Answer}" >> ~/.yadr/zsh/private.zsh
    echo "export HOMEBREW_GITHUB_API_TOKEN=${Answer}" >> ~/.yadr/zsh/private.zsh
    echo "Writing to ~/.yadr/zsh/private.zsh is complete."
    echo " ------------ END ------------"
esac
