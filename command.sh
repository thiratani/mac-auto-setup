#!/bin/bash
cat << EOS

 TkyLab

 me, and the other.

EOS

#
# Install command.
#
echo " ----- Install command ------"
brew install ag 
npm -g install gulp
npm i @google/clasp -g

while true; do
  read -p 'Add Other command "For Private"? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
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

