case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

export EDITOR="micro"
export VISUAL="micro"
export MICRO_TRUECOLOR=1
export XCURSOR_THEME="Bibata-Modern-Ice"
export XCURSOR_SIZE=24

if command -v fzf >/dev/null 2>&1; then
    if [ -f /usr/share/fzf/shell/key-bindings.bash ]; then
        source /usr/share/fzf/shell/key-bindings.bash
    fi
    if [ -f /usr/share/fzf/shell/completion.bash ]; then
        source /usr/share/fzf/shell/completion.bash
    fi
fi