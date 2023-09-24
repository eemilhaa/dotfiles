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
  hostname='[ @%m ]'
  PROMPT="$newline$green$hostname $blue$workdir $cyan$git_info $newline$cyan$prompt $normal"
}

define_aliases () {
  alias db="distrobox"
  alias colorpick='grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:-'
  alias recordscreen='wf-recorder -g "$(slurp)"'
  dev () {
    podman run -it --network host --rm -v $1:/root/work/:z ghcr.io/eemilhaa/kontti:main /bin/zsh -c "zellij --layout tabs options --default-shell zsh"
  }
  devsh () {
    podman run -it --network host --rm -v $1:/root/work/:z ghcr.io/eemilhaa/kontti:main
  }
  alias ddev="distrobox enter dev"
  ghclone () {
    if [ -z $2 ]; then
      git clone git@github.com:eemilhaa/$1.git
    else
      git clone git@github.com:$1/$2.git
    fi
  }
  did () {
    ~/.cargo/bin/did ~/repos/hours/$1.md
  }
}

set_osc7_shell_escape () {
  autoload -Uz add-zsh-hook
  osc7-pwd() {
    emulate -L zsh
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
  }
  chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
  }
  add-zsh-hook -Uz chpwd chpwd-osc7-pwd
}

ssway () {
  export WLR_DRM_NO_ATOMIC=1
  export XDG_CURRENT_DESKTOP=sway
  #export XDG_CURRENT_DESKTOP=unity  # for tray

  sway
}


set_prompt
define_aliases
set_osc7_shell_escape
