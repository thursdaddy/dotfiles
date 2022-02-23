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
source ~/.bin/tmuxsre-completion.bash
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

fpath=(/usr/local/share/zsh-completions $fpath)
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

# Copy/Pasta
# alias pbcopy='xsel --clipboard --input'
# alias pbpaste='xsel --clipboard --output'

# Git
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'

alias gbr='git branch --remote'
alias gba='git branch --all'
alias gbl='git --no-pager branch --all'
alias gbD='git branch --delete --force'
alias gbd='git branch --delete'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit --message'
alias gclp='git --no-pager log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary'
alias gcl='git --no-pager lg'
alias grl='git --no-pager reflog'

alias gD='git diff'
alias gd='git --no-pager diff'

alias gf='git fetch'
alias gfo='git fetch origin'

alias gp='git push'
alias gfp='git push --set-upstream origin `git symbolic-ref --short HEAD`'
alias gsus='git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`'
alias gl='git pull'

alias gst='git status --short --branch'
alias gs='git status'
alias grsh='git reset --soft HEAD^'
alias grh='git reset'
alias grhh='git reset --hard'
alias gru='git reset --'
alias grset='git remote set-url'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbom='git rebase origin/master'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'

alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git --no-pager stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='gsta --include-untracked'
alias gsta='git stash --all'

alias gcom='git checkout `git branch | egrep "main|master"`'

# ACG sandboxes
alias account='vim $HOME/.local/bin/_coderunner'
alias _sandbox='echo `pbpaste` > /tmp/sandbox'
alias _sandbox_new='echo `pbpaste` > /tmp/sandbox && tmux kill-session cfn || tmux-cfn'
