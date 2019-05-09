alias ls='ls --color=auto'

zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
fpath=(~/.zsh $fpath)

autoload -U colors && colors

source ~/.git-prompt.sh
setopt PROMPT_SUBST ; PS1='[%{$fg_bold[red]%}%n%{$fg_bold[yellow]%}@%{$fg_bold[blue]%}%m %{$fg[yellow]%}$(__git_ps1 " (%s)")%{$fg_bold[green]%}%~%{$reset_color%}]%{$fg_bold[white]%}\$%{$reset_color%} '
