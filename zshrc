alias ls='ls --color=auto'

zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
fpath=(~/.zsh $fpath)

autoload -U colors && colors

source ~/.git-prompt.sh
setopt PROMPT_SUBST ; PS1='[%{$fg[red]%}%n%{$fg[white]%}@%{$fg[blue]%}%m %{$fg[green]%}%~%{$fg[yellow]%}$(__git_ps1 " (%s)")%{$reset_color%}]\$ '
