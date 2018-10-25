#
# This is my theme because I'm picky
#

NEWLINE='
'

# PROMPT
PROMPT_SYMBOL="${PROMPT_SYMBOL:-$}"
PROMPT_ADD_NEWLINE="${PROMPT_ADD_NEWLINE:-false}"
PROMPT_SPARATE_LINE="${PROMPT_SPARATE_LINE:-false}"

# GIT
GIT_SHOW="${GIT_SHOW:-true}"
GIT_UNCOMMITED="${GIT_UNCOMMITED:-+}"
GIT_UNSTAGED="${GIT_UNSTAGED:-!}"
GIT_UNTRACKED="${GIT_UNTRACKED:-?}"
GIT_UNPULLED="${GIT_UNPULLED:-↓}"
GIT_UNPUSHED="${GIT_UNPUSHED:-↑}"

# Username
user(){
  echo -n "%{$fg[blue]%}"
  echo -n "["
  echo -n "%{$reset_color%}"
  if [[ $USER == 'root' ]]; then
    echo -n "%{$fg_bold[red]%}"
  elif [[ -n $SSH_CONNECTION ]]; then
    echo -n "%{$fg[yellow]%}"
  else
    echo -n "%{$fg[blue]%}"
  fi
    echo -n "%n@%m:"
    echo -n "%{$reset_color%}"
}

# Current directory
cur_dir(){
  echo -n "%{$fg[green]%}"
  echo -n "%~"
  echo -n "%{$reset_color%}"
  echo -n "%{$fg[blue]%}"
  echo -n "]"
  echo    "%{$reset_color%}"
}

# Uncommited changes
git_uncommited(){
  if ! $(git diff --quiet --ignore-submodules --cached); then
    echo -n "${GIT_UNCOMMITED}"
  fi
}

# Unstaged changes
git_unstaged(){
  if ! $(git diff-files --quiet --ignore-submodules --); then
    echo -n "${GIT_UNSTAGED}"
  fi
}

# Untracked files
git_untracked(){
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    echo -n "${GIT_UNTRACKED}"
  fi
}

# Unpushed/Unpulled
git_unpushed_unpulled(){
  # check for upstream
  command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

  local count
  count="$(command git rev-list --left-right --count HEAD..@'{u}' 2>/dev/null)"
  #exit if failed
  (( !$? )) || return

  # split on tab for counters
  count=(${(ps:\t:)count})
  local arrows left=${count[1]} right=${count[2]}

  (( ${right:-0} > 0 )) && arrows+="${GIT_UNPULLED}"
  (( ${left:-0} > 0 )) && arrows+="${GIT_UNPUSHED}"

  [ -n $arrows ] && echo -n "${arrows}"
}

# Build the git prompt
git_status(){
  [[ $GIT_SHOW == false ]] && return

  # Check if in Git repo
  command git rev-parse --is-inside-work-tree &>/dev/null || return

  # Check if currently in .git
  if [[ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]]; then
    # update index
    git update-index --really-refresh -q &>/dev/null

    # String of indicators
    local indicators=''

    indicators+="$(git_uncommited)"
    indicators+="$(git_unstaged)"
    indicators+="$(git_untracked)"
    indicators+="$(git_unpushed_unpulled)"

    [ -n "${indicators}" ] && indicators=" [${indicators}]"

    echo -n "%{$fg[green]%}"
    echo -n "$(git_current_branch)"
    echo -n "$indicators "
    echo -n "%{$reset_color%}"
  fi
}

# Prompt return status
return_status(){
  echo -n "%(?.%{$fg[green]%}.%{$fg[red]%})"
  echo -n "%?"
  echo -n "%{$reset_color%}"
}

# Build left prompt
build_left_prompt(){
  user
  cur_dir
  echo -n "%{$fg[8]%}"
  echo -n "%{$PROMPT_SYMBOL%}"
  echo -n "%{$reset_color%}"
}

# Build right prompt
build_right_prompt(){
  git_status
  return_status
}

# Compose left prompt
PROMPT=''
[[ $PROMPT_ADD_NEWLINE == true ]] && PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'$(build_left_prompt) '
[[ $PROMPT_SPARATE_LINE == true ]] && PROMPT="$PROMPT$NEWLINE"

# Compose right prompt
RPROMPT=''
[[ $PROMPT_ADD_NEWLINE == true ]] && RPROMPT="$RPROMPT$NEWLINE"
RPROMPT="$RPROMPT"'$(build_right_prompt)'
[[ $PROMPT_SPARATE_LINE == true ]] && RPROMPT="$RPROMPT$NEWLINE"

# Set PS2 - continuation interative prompt
PS2="%{$fg[8]%}"
PS2+="%{$PROMPT_SYMBOL%} "
PS2+="%{$reset_color%}"
