##############
#   export   #
##############

# path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# add home bin dir to path 
export PATH="$PATH:$HOME/.local/bin"

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""


################
#   vars pre   #
################

### zsh + oh-my-zsh ###
# zsh theme - powerlevel10k (vars from powerlevel9k work too)
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# plugins
#     default plugins = ~/.oh-my-zsh/plugins/
#     custom plugins = ~/.oh-my-zsh/custom/plugins/
plugins=(
  colored-man-pages
  command-not-found
  extract
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)


##############
#   source   #
##############

### zsh + oh-my-zsh ###
# oh-my-zsh
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


### util ###
# grc - source aliases
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh



#################
#   vars post   #
#################

### attack ###
# proxychains
PROXYCHAINS_MODE=OFF
PROXYCHAINS_ALIAS=( )
PROXYCHAINS_CMDS=(
  # port scan
  amap
  nmap
  rustscan
  # dir busting
  dirb
  gobuster
  ffuf
  wfuzz
  wget
  # cred brute force
  cewl
  hydra
  medusa
)


### zsh + oh-my-zsh ###
COMPLETION_WAITING_DOTS="true"

# zsh-syntax-highlighting - custom syntax highlighting color profile
ZSH_HIGHLIGHT_HIGHLIGHTERS=(brackets main)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=yellow
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=underline
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=none
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=white
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=white
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
ZSH_HIGHLIGHT_STYLES[back-unquoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=white
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=none
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[assign]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[assign-equal]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[redirection]=fg=yellow
ZSH_HIGHLIGHT_STYLES[comment]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=underline
ZSH_HIGHLIGHT_STYLES[numeric-fd]=underline
ZSH_HIGHLIGHT_STYLES[variable]=fg=cyan
ZSH_HIGHLIGHT_STYLES[alias]=fg=green
ZSH_HIGHLIGHT_STYLES[builtin]=fg=green
ZSH_HIGHLIGHT_STYLES[function]=fg=green
ZSH_HIGHLIGHT_STYLES[command]=fg=green
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
ZSH_HIGHLIGHT_STYLES[arg0]=fg=green



#############
#   alias   #
#############

### attack ###
alias cme='crackmapexec'
alias {pc4, proxychains}='proxychains4'


### util ###
# print files
alias bat='batcat --paging=always' # colored syntax + output paging (like an editor)
alias cat='batcat --paging=never -p' # colored syntax, no paging

# list files
alias ls='ls --color=always --group-directories-first'
alias l='ls -halF'

# git
alias ga='git add'
alias gaa='git add --all'
alias gcm='git commit --message'
alias gcl='git clone --recurse-submodules'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout $(git_main_branch)'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gm='git merge'
alias gmo='git merge origin/$(git_current_branch)'
alias gmu='git merge upstream/$(git_main_branch)'
alias gpl='git pull'
alias gplm='git pull origin $(git_main_branch)'
alias gplo='git pull origin $(git_current_branch)'
alias gplu='git pull upstream $(git_main_branch)'
alias gps='git push'
alias gpso='git push --set-upstream origin $(git_current_branch)'
alias gpsu='git push upstream $(git_main_branch)'
alias gr='git remote'
alias gru='git remote add upstream'
alias grv='git remote --verbose'
alias gs='git status'

# openvpn
alias svpnd='sudo openvpn --daemon --config'
alias skvpn='sudo killall -9 openvpn'

# extract and compress archives
alias tar-bz2='tar -cvjf'
alias tar-gz='tar -cvzf'
alias tar-xz='tar -cvJf'
alias x='extract'
alias xr='x --remove' # remove after unpacking


### zsh + oh-my-zsh ###
alias p10k-edit="code ~/.p10k.zsh"
alias omz-edit="code ~/.oh-my-zsh/oh-my-zsh.sh"
alias zshrc-edit='code ~/.zshrc'
alias zshrc-load='source ~/.zshrc'

# required to access the aliases, sourcing and other definitions in this zsh config as sudo
alias _='/usr/bin/sudo'



#################
#   functions   #
#################

### util ###

# we can use zsh plugins as sudo this way
sudo() {
    full_cmd="$@"
    _ zsh -ic "$full_cmd"
}


# get the local IPv4 address range in CIDR
# $1 = network interface (default=eth0)
net-cidr() {
  local iface="eth0"
  if (( $# > 0 )); then
    iface="$1"
  fi

  ip address show $iface | grep "inet " | awk '{print $2}' | head -n 1
}


# get the local IPv4 address
# $1 = network interface (default=eth0)
net-ip() {
  net-cidr $1 | cut -d '/' -f 1
}


# get the local IPv4 subnet mask
# $1 = network interface (default=eth0)
net-mask() {
  netmask -s $(net-cidr $1)
}


# get the local IPv4 subnet mask
# $1 = network interface (default=eth0)
net-range() {
  netmask -r $(net-cidr $1)
}


### attack ###

# custom settings for autorecon + autoreport
# $1 = notion api key
# $2 = page url / page id
autoreconnoisseur() {
  # set perms on results folder (otherwise it'll be root-only)
  md results
  chmod 2770 results
  setfacl -d -m u::rwX,g::rwX,o::0 results
  md results/scans

  # validate args first
  if ! autoreport --testMode -k $1 -i $2
  then
    return $?
  fi

  # run autoreport in background
  autoreport --watchMode -k $1 -i $2 &
  autoreportPID=$!

  # run autorecon
  sudo env PATH="$PATH" HOME="$HOME" autorecon -vv --single-target "${@:3}"

  # color results using grc
  for f in results/**/*nmap.txt
  do 
    grcat /usr/share/grc/conf.nmap < "$f" | sudo tee "$f".ansi &> /dev/null
  done 2> /dev/null

  # send signal to stop autoreport
  kill $autoreportPID > /dev/null
}


# set alias for commands compatible with proxychains
# $1 = enable or disable (default=status)
pc4-mode() {
  local help_opts=( "-h" "--help" )
  if (( ! $help_opts[(ie)$1] )); then
    echo "[*] Manage aliases to simplify network commands that work with proxychains"
    echo ""
    echo "Usage:"
    echo "        ${funcstack[1]}             print the ON/OFF status"
    echo "        ${funcstack[1]} [ON|OFF]    enable or disable the aliases"
    echo ""
    echo "Options:"
    echo "        -h, --help                  print this help message"
    return
  fi

  local enabled="ON" disabled="OFF"
  local enabled_color="${fg[green]}${enabled}${reset_color}"
  local disabled_color="${fg[red]}${disabled}${reset_color}"
  local -a valid_enabled=("$enabled" "ON" "ENABLED")
  local -a valid_disabled=("$disabled" "OFF" "DISABLED")
  local mode="${PROXYCHAINS_MODE:u}"
  local modeEnabled="$(( $valid_enabled[(Ie)$mode] ))"

  # if no args, print status
  if (( ! $# )); then
    echo -n "PROXYCHAINS_MODE="
    (($modeEnabled)) && echo $enabled_color || echo $disabled_color
    return
  fi

  local arg="${1:u}"
  local argEnabled="$(( $valid_enabled[(Ie)$arg] ))"
  local argDisabled="$(( $valid_disabled[(Ie)$arg] ))"

  # validate args
  if ((! argEnabled)) && ((! argDisabled)); then
    echo "Invalid argument: $1"
    return 1
  elif [[ $arg == $mode ]]; then
    echo "PROXYCHAINS_MODE is already $mode"
    return 2
  fi 

  # disable pc4-mode
  if (($modeEnabled)); then
    for cmd in "$PROXYCHAINS_ALIAS[@]"; do
      unalias $cmd
    done

    PROXYCHAINS_MODE=$disabled
    echo "PROXYCHAINS_MODE is now $disabled_color"
  # enable pc4-mode
  else
    for cmd in "$PROXYCHAINS_CMDS[@]"; do
      if [[ $(command -v $cmd --no-failure-msg) ]] || [[ $(typeset -f $cmd) ]]; then
        alias "$cmd"="proxychains -q $cmd"
        PROXYCHAINS_ALIAS+=$cmd
      fi
    done

    PROXYCHAINS_MODE=$enabled
    echo "PROXYCHAINS_MODE is now $enabled_color"
  fi
}