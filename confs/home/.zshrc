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

_rc_source_if_exists() {
  if [ -f "$1" ]; then
    source "$1"
  fi
}

_rc_set_general_settings () {
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

_rc_set_exports () {
  _rc_pick_editor () {
    if command -v helix &>/dev/null; then
      alias hx='helix'
      export VISUAL=helix
    elif command -v hx &>/dev/null; then
      export VISUAL=hx
    else
      export VISUAL=vi
    fi
    export EDITOR="$VISUAL"
  }
  _rc_pick_editor
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
  export LS_COLORS="${LS_COLORS}ow=1;102;30:"
  export DFT_SYNTAX_HIGHLIGHT=off
  export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
}

_rc_set_custom_commands () {
  alias ls='ls -F --color=auto --group-directories-first'
  alias la='ls -a'
  alias l='ls -lh'
  alias ll='ls -lh --almost-all'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias gs="git status"
  alias gl="git log --graph --abbrev-commit --oneline"
  alias zel="zellij"
  alias zeltab="zellij action new-tab --name"
  alias code="code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto"
  getignore () {
    wget -O - "https://raw.githubusercontent.com/github/gitignore/main/$1.gitignore" >> "$PWD/.gitignore"
  }
  muxnew () {
    for arg
    do tmux new -s "$(basename "${arg}")" -c "${arg}" -d
    done
    tmux a -dt "$(basename "${1}")"
  }
  li () {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
}

_rc_set_keybinds () {
  bindkey "^P" history-incremental-search-backward
  bindkey "^N" history-incremental-search-forward
  # bindkey "^P" history-beginning-search-backward-end
  # bindkey "^N" history-beginning-search-forward-end
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
  bindkey "^O" edit-command-line
  bindkey ";5;13~" autosuggest-accept
}

_rc_set_prompt_and_title () {
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
$prompt_symbol$normal"

  title_info () {
    workdir_full='%~'
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

_rc_set_extras () {
  _rc_source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  _rc_source_if_exists /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  _rc_source_if_exists /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  _rc_source_if_exists /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
    export FZF_DEFAULT_OPTS="
    --layout=reverse \
    --color=16 \
    "
  fi
}

_rc_check_extra_dir () {
  if [ -d "$1" ]; then
    for rc in "$1"/*; do
      _rc_source_if_exists "$rc"
    done
  fi
}

_rc_set_general_settings
_rc_set_exports
_rc_set_custom_commands
_rc_set_keybinds
_rc_set_extras
_rc_set_prompt_and_title
_rc_check_extra_dir ~/.zshrc.d  # Any extra zsh stuff / possible overrides

# zprof  # debug zsh startup time
