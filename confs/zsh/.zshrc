# init
autoload -Uz compinit && compinit

# env
export COLORTERM="truecolor"
export SHELL="/bin/zsh"
export COLORTERM="truecolor"
export PATH="/root/.local/bin:$PATH"
export PATH="/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$PATH"

# history
export HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_save_no_dups hist_ignore_dups

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


# aliases
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias ll='ls -l --almost-all'
alias lt='ls --tree'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# dont overwrite
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# git
alias gs="git status"
alias gl="git log --graph --abbrev-commit --oneline"
# custom zellij
alias zel="zellij --layout tabs"

# keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# starship
eval "$(starship init zsh)"

# highlight
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
