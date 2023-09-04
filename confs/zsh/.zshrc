source_if_exists() {
  if [ -f $1 ]; then
    source $1
  fi
}

set_general_settings () {
  autoload -Uz compinit && compinit
  autoload -U history-search-end
  autoload -z edit-command-line
  zstyle ':completion:*' menu select
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  zle -N history-incremental-search-backward history-search-end
  zle -N edit-command-line
  setopt HIST_EXPIRE_DUPS_FIRST
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_SPACE
  setopt HIST_FIND_NO_DUPS
  setopt HIST_SAVE_NO_DUPS
}

set_exports () {
  export COLORTERM="truecolor"
  export SHELL="/bin/zsh"
  export PATH="/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$PATH"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$HOME/.cargo/bin:$PATH"
  export HISTFILE="$HOME/.zsh_history"
  export HISTSIZE=1000
  export SAVEHIST=1000
}

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
  bindkey '^ ' history-incremental-search-backward
  bindkey "^[[A" history-beginning-search-backward-end
  bindkey "^[[B" history-beginning-search-forward-end
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
  bindkey "^O" edit-command-line
}

set_prompt () {
  setopt prompt_subst
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git svn
  zstyle ':vcs_info:git*' formats "(%b)"
  precmd() {
    vcs_info
  }
  newline=$'\n'
  git_info='${vcs_info_msg_0_}'
  prompt='❯'
  blue='%B%F{blue}'
  cyan='%B%F{cyan}'
  green='%B%F{green}'
  normal='%b%f'
  workdir='%2~'
  reminder='[ @kontti ]'
  PROMPT="$newline$green$reminder $blue$workdir $cyan$git_info $newline$cyan$prompt $normal"
}

set_extras () {
  source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

check_extra_dir () {
  if [ -d $1 ]; then
    for rc in $1/*; do
      source_if_exists "$rc"
    done
  fi
}

set_general_settings
set_exports
pick_editor
define_aliases
set_keybinds
set_extras
set_prompt
check_extra_dir ~/.zshrc.d  # Any extra zsh stuff / possible overrides
