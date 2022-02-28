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

# Path to your oh-my-zsh installation.
TERM="xterm-256color"

# Uncomment the following line if pasting URLs and other text is messed up.
#DISABLE_MAGIC_FUNCTIONS=true

plugins=(history-substring-search ansible history systemd vagrant alias-finder you-should-use sudo tmux)
source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# fpath=(/usr/local/share/zsh-completions $fpath)
rm -f "$HOME/.zcompdump"; compinit
autoload -U compinit

# command-line navigation
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

bindkey '^r' history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward

# Ansible exports
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_STDOUT_CALLBACK=yaml

# Misc.
alias d='dirs -v | head -10'
alias vim=nvim
alias virsh="EDITOR=vim virsh"
