# Path to your oh-my-zsh installation.
export TERM="xterm-256color"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ll="ls --color -ahl"
alias ls="ls --color"
alias grep='grep -n --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,env}'
alias feh='feh --conversion-timeout 1'
alias k='kubectl'
alias df='df -h'
alias aria2c='aria2c --seed-time=0'
alias scp='scp -q'
alias ..="cd ../"
alias ...="cd ../../"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gf="git fetch"
alias rg="rg -S"
