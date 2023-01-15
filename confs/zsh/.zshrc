# init
autoload -Uz compinit && compinit

# env
export COLORTERM="truecolor"
export SHELL="/bin/zsh"
export COLORTERM="truecolor"
export PATH="/root/.local/bin:$PATH"

# history
export HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_save_no_dups hist_ignore_dups
setopt correctall

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
# custom zellij
alias zel="zellij --layout tabs"

# keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# starship
eval "$(starship init zsh)"

# highlight
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=red,bold"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[alias]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[global-alias]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[command]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[path]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[path_prefix]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[command-substitution]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[process-substitution]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=magenta,bold"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=magenta,bold"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]="fg=blue"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=blue"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="fg=blue"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="fg=blue"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]="fg=blue"
ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[assign]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[comment]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[comment]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[named-fd]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[numeric-fd]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=white,bold"
ZSH_HIGHLIGHT_STYLES[default]="fg=white,bold"
