define_aliases () {
  alias colorpick='grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:-'
  alias recordscreen='wf-recorder -g "$(slurp)"'
  alias db="distrobox"
  alias dbh="distrobox-host-exec"
  battery () {
    upower -i $(upower -e | grep 'BAT') | grep -E "state|percentage"
  }
  dbinit () {
    distrobox create -n $1 --hostname $1 --image ghcr.io/eemilhaa/dotfiles:main
  }
  dev () {
    podman run -it --network host --rm -v $1:/root/work/:z ghcr.io/eemilhaa/dotfiles:main
  }
  ghclone () {
    if [ -z $2 ]; then
      git clone git@github.com:eemilhaa/$1.git
    else
      git clone git@github.com:$1/$2.git
    fi
  }
  dbe () {
    if [ -z $1 ]; then
      distrobox enter kontti
    else
      distrobox enter $1
    fi
  }
  firefox-open () {
    gtk-launch org.mozilla.firefox.desktop $1
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

define_sway_stuff () {
  ssway () {
    export WLR_DRM_NO_ATOMIC=1
    export XDG_CURRENT_DESKTOP=sway
    #export XDG_CURRENT_DESKTOP=unity  # for tray
    sway
  }

  sway_ext_output_scale () {  # TODO get output dynamically
    swaymsg output HDMI-A-1 enable scale $1
  }

  sway_ext_output_position () {
    swaymsg output HDMI-A-1 position 0 0
    swaymsg output eDP-1 position $1 $2
  }
}

define_aliases
set_osc7_shell_escape
define_sway_stuff
