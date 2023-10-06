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
  cme
  crackmapexec
  hydra
  medusa
)


### zsh + oh-my-zsh ###
COMPLETION_WAITING_DOTS="true"

# fzf - fuzzy finder
FZF_DEFAULT_OPTS="--preview='batcat --color=always --style=full {}' --bind='ctrl-/:change-preview-window(hidden|)'"
FZF_CTRL_R_OPTS="--preview=''"
FZF_ALT_C_OPTS="--preview=''"

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

## lateral movement
alias {proxychains,pc4,pxychn}='proxychains4'
alias ligolo-setup='sudo ip tuntap add user $(whoami) mode tun ligolo && sudo ip link set ligolo up'

### util ###
# search for aliases
alias aliasgrep='alias | grep -i'

# clipboard
alias ctrlc='xclip -selection clipboard' # echo $var | ctrlc

# open dir in ux browser
alias ocd='xdg-open .'

# list files
alias ls='ls --color=always --group-directories-first' # print dirs first
alias l='ls -halF' # human readable size, all files, long format, append slash to dirs (e.g., 'dir/')
alias lcd='cdl' # change + list dir

# print files
alias bat='batcat --color=always --paging=always --style=auto' # always colored syntax, enable paging, include file_name + line_num + git changes 
alias cat='batcat --color=auto --paging=never --style=plain' # colored syntax is context-dependent (e.g., off for piped output), no paging, display file contents only
alias less='batcat --color=always --paging=always --style=plain' # colored syntax, enable paging, display file contents only

# find files
alias fd='fdfind'

# change file perms
alias chmodx='chmod +x'

# git
alias ga='git add'
alias gaa='git add --all'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gcl='git clone --recurse-submodules'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout $(git_main_branch)'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gm='git merge'
alias gmm='git merge origin/$(git_main_branch)'
alias gmo='git merge origin/$(git_current_branch)'
alias gmu='git merge upstream/$(git_main_branch)'
alias gpl='git pull'
alias gplm='git pull origin $(git_main_branch)'
alias gplo='git pull origin $(git_current_branch)'
alias gplu='git pull upstream $(git_main_branch)'
alias gps='git push'
alias gpsm='git push --set-upstream origin $(git_main_branch)'
alias gpso='git push --set-upstream origin $(git_current_branch)'
alias gpsu='git push --set-upstream upstream $(git_current_branch)'
alias gr='git remote'
alias gru='git remote add upstream'
alias grv='git remote --verbose'
alias gs='git status'

# ip
alias ipcidr='net-cidr'
alias ipmask='net-mask'
alias iprange='net-range'

# vpn
alias vpnip='net-ip tun0'
alias vpncidr='net-cidr tun0'
alias vpnmask='net-mask tun0'
alias vpnrange='net-range tun0'
alias vpnkill='sudo killall -9 openvpn'

# hosts
alias hosts='cat /etc/hosts'
alias hostsedit='sudo nano /etc/hosts'

# extract and compress archives
alias tar-bz2='tar -cvjf'
alias tar-gz='tar -cvzf'
alias tar-xz='tar -cvJf'
alias x='extract'
alias xr='x --remove' # rm after extract

### terminator + zsh + oh-my-zsh ###
alias ttedit='code ~/.config/terminator/config'
alias p10kedit='code ~/.p10k.zsh'
alias omzedit='code ~/.oh-my-zsh/oh-my-zsh.sh'
alias zedit='code ~/.zshrc'
alias zload='source ~/.zshrc'
alias zcproot='ask-confirm "Replace ROOT [.zshrc] with HOME [.zshrc] - (new root = home)" && sudo cp ~/.zshrc /root/.zshrc'

# required to access the aliases, sourcing and other definitions in this zsh config as sudo
alias _='/usr/bin/sudo'

### hephaestus
if [[ -n "${HEPHAESTUS_DEV_PATH}" ]]; then
  alias hephacd='cd "${HEPHAESTUS_DEV_PATH}"'
  alias hephadev='code "${HEPHAESTUS_DEV_PATH}/install.sh"'
fi

### dev mode
if [[ -n "${ONOSENDAI_DEV_PATH}" ]]; then
  ## ono-sendai
  alias onocd='cd "${ONOSENDAI_DEV_PATH}"'
  alias onodev='code "${ONOSENDAI_DEV_PATH}/install.sh"'

  ## terminator + zsh + oh-my-zsh
  # edit dev version
  alias ttdev='code "${ONOSENDAI_DEV_PATH}/terminator.config"'
  alias zdev='code "${ONOSENDAI_DEV_PATH}/.zshrc"'

  # copy version in use to repo
  alias ttcpdev='ask-confirm "Replace DEV [terminator.config] with HOME [terminator.config] - (new dev = home)" && cp ~/.config/terminator/config "${ONOSENDAI_DEV_PATH}/terminator.config"'
  alias zcpdev='ask-confirm "Replace DEV [.zshrc] with HOME [.zshrc] - (new dev = home)" && cp ~/.zshrc "${ONOSENDAI_DEV_PATH}/.zshrc"'
fi



#################
#   functions   #
#################

### zsh + oh-my-zsh ###

# we can use zsh plugins as sudo this way
sudo() {
    full_cmd="$@"
    _ zsh -ic "$full_cmd"
}

## fzf - replace find with fd
_fzf_compgen_path() {
  echo "$1"
  command fdfind --type f --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  command fdfind --type d --hidden --follow --exclude ".git" . "$1"
}

### util ###

# ask for user confirmation
# $1 = message to display (default => "")
# $2 = default answer (default => n)
ask-confirm() {
  local y="y"
  local n="N"
  local by_default=false
  
  [[ -z "$1" ]] || echo $1

  if [[ "$2" =~ ^[Yy]$ ]]; then
    y="Y"
    n="n"
    by_default=true
  fi
  
  read choice\?"Continue ($y/$n)?"
  case "$choice" in 
    [yY] | [yY][eE][sS] ) return 0;;
    [nN] | [nN][oO] ) return 1;;
    * ) $by_default && return 0 || return 1;;
  esac
}


# change dir and list its contents
# $1 = directory (default => ~)
cdl() {
  (( $# > 1 )) && (echo "Usage: cd [directory]"; return 1)

  local directory=${1:=~}
  cd "${directory}" && l
}

# get the local IPv4 address range in CIDR
# $1 = network interface (default => eth0)
net-cidr() {
  local iface="eth0"
  (( $# > 0 )) && iface="$1"

  ip address show $iface | grep "inet " | awk '{print $2}' | head -n 1
}


# get the local IPv4 address
# $1 = network interface (default => eth0)
net-ip() {
  net-cidr $1 | cut -d '/' -f 1
}


# get the local IPv4 subnet mask
# $1 = network interface (default => eth0)
net-mask() {
  netmask -s $(net-cidr $1) | cut -d '/' -f2 | awk '{$1=$1};1'
}


# get the local IPv4 subnet mask
# $1 = network interface (default => eth0)
net-range() {
  netmask -r $(net-cidr $1) | awk '{$1=$1};1'
}


# convenient wrapper for net-ip
# $1 = network interface (default => eth0)
ip() {
  if (( ! $# )); then
    net-ip
  else
    /usr/sbin/ip "$@"
  fi
}


# connect to vpn in daemon mode
# $1 = openvpn config file
vpnd() {
  sudo openvpn --daemon --config "$1" && sleep 1
}


# add an entry to the /etc/hosts file
# $1 = IP address
# $2 = hostname
hostsadd() {
  if [[ ${#} -ne 2 ]]; then
    echo "Usage: hosts-add <ip_address> <hostname>"
    return 1
  fi

  grep -qx "$1\s+$2" /etc/hosts || sudo sed -i "1s/^/$1\\\t$2\\\n/" /etc/hosts
}


# delete entries from the /etc/hosts file
# $1 = IP address
hostsdel() {
  if (( ! $# )); then
    echo "Usage: hosts-del <ip_address>" >&2
    return 1
  fi

  sudo sed -i "/^$1\\\s\\\+.\\\+/d" /etc/hosts
}


# pushes a commit that includes all changes
# $1 = message for commit
git-push-all() {
  if (( ! $# )); then
    echo "A commit message is required."
    return 1
  fi

  # get status, commit all, push -u origin, and get status again
  gs && gcam "$1" && gpso && gs
}

# enables/disables alias wrappers for transparent execution of convenient commands over proxychains
#   e.g. nmap => proxychains -q nmap
# [no args] = get current status
# $1 = enable or disable
# $PROXYCHAINS_CMDS[@] = list of commands wrapped with aliases
pc4-mode() {
  local help_opts=( "-h" "--help" )
  if (( $# > 1 )) || (( ${#${@:*help_opts}} )); then
    echo "[*] Enable or disable aliases for transparent execution over proxychains."
    echo ""
    echo "Usage:"
    echo "        ${funcstack[1]}                  print the current status"
    echo "        ${funcstack[1]} <ON|OFF>         enable or disable aliases"
    echo ""
    echo "Options:"
    echo "        -h, --help                print this help message"
    echo ""
    echo "Update \$PROXYCHAINS_CMDS[@] to add or remove aliased commands."
    return
  fi

  local enabled="ON" disabled="OFF"
  local enabled_color="${fg[green]}${enabled}${reset_color}"
  local disabled_color="${fg[red]}${disabled}${reset_color}"
  local -a valid_enabled=("$enabled" "ON" "ENABLED")
  local -a valid_disabled=("$disabled" "OFF" "DISABLED")
  local mode="${PROXYCHAINS_MODE:u}"
  local modeEnabled="$(( $valid_enabled[(Ie)$mode] ))"

  # if no args, print current status
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

    PROXYCHAINS_ALIAS=( )
    PROXYCHAINS_MODE=$disabled
    echo "PROXYCHAINS_MODE is now $disabled_color"
  # enable pc4-mode
  else
    for cmd in "$PROXYCHAINS_CMDS[@]"; do
      if [[ -n "$aliases[$cmd]" ]]; then
        # existing aliases require expansion to work properly with proxychains
        alias $cmd="proxychains -q $aliases[$cmd]"
        PROXYCHAINS_ALIAS+=$cmd
      elif [[ $(command -v $cmd --no-failure-msg) ]] || [[ $(typeset -f $cmd) ]]; then
        alias $cmd="proxychains -q $cmd"
        PROXYCHAINS_ALIAS+=$cmd
      fi
    done

    PROXYCHAINS_MODE=$enabled
    echo "PROXYCHAINS_MODE is now $enabled_color"
  fi
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