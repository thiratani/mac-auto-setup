#!/bin/bash
cat << EOS

 TkyLab

 me, and the other.

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
  mas install 497799835  # Xcode
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
# Install zsh env
#
echo " ------------ zsh env --------"
ln -s $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/zsh/.dotfiles/.zshrc ~/.zshrc
ln -s $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/zsh/.dotfiles/.zshenv ~/.zshenv
echo " ------------ END ------------"

#
# Install vim
#
if ! command_exists vim ; then
  echo " ------------ Vim ------------"
  brew install vim --with-override-system-vi
  echo " ------------ END ------------"
fi

#
# Install vim env
#
echo " ---------- Vim env-----------"
mkdir -p ~/.vim/rc/
ln -s $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/vim/.vimrc ~/.vimrc
ln -s $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/vim/rc/dein.toml ~/.vim/rc/dein.toml
ln -s $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/vim/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
echo " ------------ END ------------"

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
# Install Node.js env
#
if ! command_exists nodebrew ; then
  echo " ---------- Node.js ----------"
  brew install nodenv
  nodenv -v
  nodenv install 10.0.0
  nodenv install 6.11.4
  nodenv versions
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
