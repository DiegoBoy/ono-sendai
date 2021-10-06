# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_MODE='nerdfont-complete'

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  command-not-found
  extract
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias bat='batcat --paging=always'
alias cat='batcat --paging=never -p'
alias l='ls -al'
alias x='extract'
alias _='/usr/bin/sudo'

# we can use zsh plugins as sudo this way
sudo() {
    full_cmd="$@"
    _ zsh -ic "$full_cmd"
}

# custom settings for autorecon + autoreport
autoreconnoisseur() {
  # set perms on results folder (otherwise it'll be root-only)
  md results
  chmod 2770 results
  setfacl -d -m u::rwX,g::rwX,o::0 results
  md results/scans

  if ! autoreport --testMode -k $1 -u $2
  then
    return $?
  fi

  autoreport --watchMode -k $1 -u $2 &
  autoreportPID=$!

  # run autorecon
  sudo env PATH="$PATH" HOME="$HOME" autorecon -vv --single-target "${@:3}"

  # color results using grc
  for f in results/**/*nmap.txt
  do 
    grcat /usr/share/grc/conf.nmap < "$f" | sudo tee "$f".ansi &> /dev/null
  done 2> /dev/null

  kill $autoreportPID > /dev/null
}

# include GRC aliases
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

export PATH="$PATH:$HOME/.local/bin"
