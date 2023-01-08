# init
autoload -Uz compinit && compinit

# env
export COLORTERM="truecolor"
export HISTFILE="$HOME/.zsh_history"
export SHELL="/bin/zsh"
export COLORTERM="truecolor"
export PATH="/root/.local/bin:$PATH"
HISTSIZE=1000
SAVEHIST=1000

# pick editor
if hash helix 2>/dev/null
then
  alias hx="helix"
  export VISUAL=helix
elif hash hx 2>/dev/null
then
  export VISUAL=hx
else
  export VISUAL=vi
fi
export EDITOR="$VISUAL"

# opts
setopt hist_save_no_dups hist_ignore_dups
setopt correctall

# aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# dont overwrite
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# git
alias gs="git status"
alias gl="git log --graph --abbrev-commit --oneline"
alias db="distrobox"
# less ui in zellij
alias zel="zellij -l compact"

# keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# starship
eval "$(starship init zsh)"
