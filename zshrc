# Adapted from Josh Dick's own git prompt. Thanks Josh!
setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}
  local GIT_LOCATION_NO_WHITESPACE="$(echo -e "${GIT_LOCATION}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  local AHEAD="%{$fg_bold[white]%}⇡NUM%{$reset_color%}"
  local BEHIND="%{$fg_bold[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING="%{$fg_bold[red]%}MERGING%{$reset_color%}"
  local UNTRACKED="%{$fg[red]%}#%{$reset_color%}"
  local MODIFIED="%{$fg_bold[yellow]%}*%{$reset_color%}"
  local STAGED="%{$fg_bold[green]%}+%{$reset_color%}"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=( "(" )
  GIT_INFO+=( "%{$fg_bold[magenta]%}$GIT_LOCATION_NO_WHITESPACE%{$reset_color%}" )
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  echo "${(j::)GIT_INFO})"

}

alias ls='ls --color=auto'
alias l="ls"

PS1='%{$fg_bold[red]%}%n%{$fg_bold[yellow]%}@%{$fg_bold[cyan]%}%m%{$reset_color%}:%{$fg_bold[green]%}%~%{$reset_color%}$(git_info)% %{$reset_color%}%{$reset_color%}% %% '
