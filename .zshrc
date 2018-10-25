# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# No duplicates in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# append to history
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS

setopt autocd notify
unsetopt beep

autoload -U colors && colors

bindkey "^N" expand-or-complete
bindkey '^?' backward-delete-char

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="best"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
# source $HOME/.oh-my-zsh/plugins/zsh-syntax.highlighting/zsh-syntax-highlighting.zsh

# exports
# export set PATH=$PATH:$HOME/bin/sublime
export set PATH=$PATH:$HOME/bin/scripts
export VISUAL=vim
export EDITOR="$VISUAL"

# set focus mode to 'sloppy'
# 'sloppy' is the same as 'mouse' focus mode, but alt-tab can override focus
gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'

# my settings
mesg n

