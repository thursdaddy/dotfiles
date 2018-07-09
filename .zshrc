# If you come from bash you might have to change your $PATH.

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
#

#if [[ ! $TERM =~ screen ]]; then
#    exec tmux
#fi

export ZSH=/home/thurs/.oh-my-zsh
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

alias config='/usr/bin/git --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'
alias syncnotes='aws s3 sync $HOME/Docs/Notes s3://thursdaddy/notes/laptop --sse --profile thurs-notes' 
alias weechat='docker stop weechat; docker rm weechat; docker run --name weechat -v ~/.weechat:/home/guest/.weechat -t -i fstab/weechat-otr'
alias update='yaourt -Syu --aur'
alias dock='$HOME/.config/scripts/dock.sh dock'
alias undock='$HOME/.config/scripts/dock.sh undock'

source ~/.oh-my-zsh/antigen.zsh
antigen use oh-my-zsh
antigen bundle nviennot/zsh-vim-plugin 
antigen bundle gko/ssh-connect
antigen bundle TBSliver/zsh-plugin-tmux-simple
antigen bundle bric3/nice-exit-code 
antigen bundle Tarrasch/zsh-bd
antigen bundle popstas/zsh-command-time
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle djui/alias-tips
antigen bundle supercrabtree/k
antigen bundle Cloudstek/zsh-plugin-appup 
antigen bundle zlsun/solarized-man
antigen bundle psprint/history-search-multi-word
antigen bundle wting/autojump 
antigen apply

	[[ -s /home/thurs/.autojump/etc/profile.d/autojump.sh ]] && source /home/thurs/.autojump/etc/profile.d/autojump.sh

	autoload -U compinit && compinit -u

plugins=(git history-search-multi-word zsh-autosuggestions zsh-syntax-highlighting command-time you-should-use)

export UPDATE_ZSH_DAYS=1

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)


