# Bring in aliases
source ~/.aliases

export set EDITOR='vi'
export set VISUAL="$EDITOR"

export PS1='\n$(if [[ $? == 0 ]]; then echo "\[\e[32m\]$?"; else
echo "\[\e[31m\]$?"; fi)\[\e[0m\] \[\033[36m\]ndm@\h \
\[\033[33m\]\w\[\033[32m\]`__git_ps1`\[\033[0m\]\n\$ '
