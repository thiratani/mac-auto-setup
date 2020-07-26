##########################################################
# init
##########################################################
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

source ~/.zshenv

##########################################################
# environment 
##########################################################

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# git
export PATH="/usr/local/opt/git/bin:$PATH"

# Completation configuration
# 予測変換
# autoload predict-on
# predict-on

autoload -Uz colors
colors

autoload -Uz compinit
compinit -u
if [ -e ~/.zsh/zsh-completions ]; then
  fpath=(~/.zsh/zsh-completions/src $fpath)
fi  

# プロンプト設定
PROMPT='[%~:%n] %# '

# history
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

###########################################################
# options 
##########################################################

# history
setopt extended_history #ヒストリに実行時間も保存
setopt hist_ignore_dups #直前と同じコマンドはヒストリに追加しない
setopt inc_append_history
setopt share_history

function peco-history-selection() {
  BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# cdなしでディレクトリ名を直接指定
setopt auto_cd

# cdした先のディレクトリをディレクトリスタックに追加
setopt auto_pushd

# pushdしたとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# command correct edition before each completion attempt 
setopt correct

# <Tab>でパス名の補完候補を表示したあと、
# 続けて<Tab>を押すと候補からパス名を選択することができるようになる
zstyle ':completion:*:default' menu select=1

setopt list_packed

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 候補に色を付ける
zstyle ':completion:*' list-colors ''

# # cdの後にlsを実行
chpwd() { ls -ltrG }

# Arias
alias la='ls -laG'
alias ll='ls -lG'
alias vzrc='v ~/.zshrc'
alias vvrc='v ~/.vimrc'

alias wd='cd ~/workspace/src/backlog/desktop/Workflow'
alias wmi='cd ~/workspace/src/backlog/mobile/ios/Workflow'
alias wma='cd ~/workspace/src/backlog/mobile/android/Workflow'
alias c='cd'
alias v='vi' 

# Keybind configuration
#
# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
#zmodload zsh/complist
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char

#
# End of lines added by compinstall
