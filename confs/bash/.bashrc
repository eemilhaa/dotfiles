source_if_exists() {
  if [ -f $1 ]; then
    source $1
  fi
}

set_exports () {
  pick_editor () {
    if hash helix 2>/dev/null; then
      alias hx='helix'
      export VISUAL=helix
    elif hash hx 2>/dev/null; then
      export VISUAL=hx
    else
      export VISUAL=vi
    fi
    export EDITOR="$VISUAL"
  }
  pick_editor
  export COLORTERM="truecolor"
  export SHELL="/bin/zsh"
  if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
  then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
  fi
  export PATH="/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$PATH"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$HOME/.cargo/bin:$PATH"
  export HISTFILE="$HOME/.bash_history"
  export HISTSIZE=1000
  export HISTCONTROL=ignoreboth:erasedups
}

define_aliases () {
  if hash lsd 2>/dev/null; then
    alias ls='lsd'
    alias lls='ls -l --almost-all --total-size'
    alias lt='ls --tree'
  fi
  alias l='ls -l'
  alias ll='ls -l --almost-all'
  alias la='ls -a'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias zel="zellij --layout tabs"
  alias gs="git status"
  alias gd="git diff --color-words"
  alias gl="git log --graph --abbrev-commit --oneline"
}

set_keybinds () {
  bind "\C-o":edit-and-execute-command
}

set_prompt () {
  source_if_exists /usr/share/git/git-prompt.sh
  PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
}


# Source global definitions
source_if_exists /etc/bashrc
set_exports
define_aliases
set_keybinds
set_prompt
