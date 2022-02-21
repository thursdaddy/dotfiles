# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export ZSH="$HOME/.oh-my-zsh"

path+=("$HOME/.local/bin")
export PATH

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

#powerline-daemon -q
#. /usr/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh

# Path to your oh-my-zsh installation.
TERM="xterm-256color"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

plugins=(git history-substring-search ansible history systemd vagrant alias-finder you-should-use sudo tmux)
source $ZSH/oh-my-zsh.sh
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
export ANSIBLE_STDOUT_CALLBACK=debug

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Aliases

alias d='dirs -v | head -10'
alias vim=nvim
alias virsh="EDITOR=vim virsh"

# Copy/Pasta
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Git commands
alias gnpd='g --no-pager diff'
alias gdp='g diff'

# ACG sandboxes
alias account='vim $HOME/.local/bin/_coderunner'
alias _sandbox='echo `pbpaste` > /tmp/sandbox'
alias _sandbox_new='echo `pbpaste` > /tmp/sandbox && tmux kill-session cfn || tmux-cfn'

# Flag info on TAB
autoload -U compinit

# command-line navigation
bindkey -e

compinit
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

bindkey '^r' history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
