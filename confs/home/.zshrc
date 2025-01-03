# zmodload zsh/zprof  # debug zsh startup time

autoload -Uz compinit

# for dump in ~/.zcompdump(N.mh+24); do  # compinit only once a day
#   compinit
# done
# compinit -C

autoload -Uz compinit && compinit  # compinit always
autoload -Uz add-zsh-hook
autoload -Uz history-search-end
autoload -Uz edit-command-line

source_if_exists() {
  if [ -f "$1" ]; then
    source "$1"
  fi
}

set_general_settings () {
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
  setopt incappendhistory
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
  export PATH="/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$PATH"
  export PATH="/usr/share/git-core/contrib:$PATH"
  export PATH="/usr/share/git/diff-highlight:$PATH"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$HOME/.cargo/bin:$PATH"
  export HISTFILE="$HOME/.zsh_history"
  export HISTSIZE=1000000
  export SAVEHIST=1000000
  export LS_COLORS="${LS_COLORS}ow=1;37;42:"
}

set_custom_commands () {
  alias ls='ls -F --color=auto --group-directories-first'
  alias la='ls -a'
  alias l='ls -lh'
  alias ll='ls -lh --almost-all'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias gs="git status"
  alias gd="git diff --color-words"
  alias gl="git log --graph --abbrev-commit --oneline"
  alias zel="zellij"
  alias zeltab="zellij action new-tab --name"
  getignore () {
    wget -O - "https://raw.githubusercontent.com/github/gitignore/main/$1.gitignore" > "$PWD/.gitignore"
  }
}

set_keybinds () {
  bindkey "^P" history-incremental-search-backward
  bindkey "^N" history-incremental-search-forward
  # bindkey "^P" history-beginning-search-backward-end
  # bindkey "^N" history-beginning-search-forward-end
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
  bindkey "^O" edit-command-line
}

set_prompt_and_title () {
  setopt prompt_subst
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git svn
  # zstyle ':vcs_info:git*' formats "(%b)"
  zstyle ':vcs_info:git:*' formats '(%b) '

  bold='%B'
  red='%F{red}'
  green='%F{green}'
  yellow='%F{yellow}'
  blue='%F{blue}'
  magenta='%F{magenta}'
  cyan='%F{cyan}'
  normal='%b%f'

  # newline='\n'
  hostname='@%m '
  workdir='%2~ '
  workdir_full='%~ '
  git_info='${vcs_info_msg_0_}'
  venv='%(1V.(%1v) .)'
  prompt_symbol='❯ '

  export VIRTUAL_ENV_DISABLE_PROMPT=1
  venv_indicator () {
    if [[ -z $VIRTUAL_ENV ]]; then
      psvar[1]=''
    else
      psvar[1]=${VIRTUAL_ENV##*/}
    fi
  }
  add-zsh-hook precmd venv_indicator
  add-zsh-hook precmd vcs_info

  PROMPT="
$bold$green$hostname$blue$workdir$cyan$git_info$venv
$blue$prompt_symbol$normal"

  title_info () {
    print -Pn "$hostname$workdir_full"
  }
  set_base_title () {
    echo -en "\e]0;zsh $(title_info)\a"
  }
  set_cmd_title () {
    echo -en "\e]0;$1 $(title_info)\a"
  }

  add-zsh-hook precmd set_base_title
  add-zsh-hook preexec set_cmd_title
}

set_extras () {
  source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source_if_exists /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source_if_exists /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source_if_exists /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
}

check_extra_dir () {
  if [ -d "$1" ]; then
    for rc in "$1"/*; do
      source_if_exists "$rc"
    done
  fi
}

set_general_settings
set_exports
set_custom_commands
set_keybinds
set_extras
set_prompt_and_title
check_extra_dir ~/.zshrc.d  # Any extra zsh stuff / possible overrides

# zprof  # debug zsh startup time
