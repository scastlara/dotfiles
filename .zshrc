# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


export POETRY_VIRTUALENVS_IN_PROJECT=1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
VIRTUAL_ENV_DISABLE_PROMPT=1

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fuzzy finder
eval "$(fzf --zsh)"

# Pyenv
eval "$(pyenv init -)"

# Homebrew fixes
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Sets ipdb as default debugger for python
export PYTHONBREAKPOINT=ipdb.set_trace
export PYTEST_ADDOPTS='--pdbcls=IPython.terminal.debugger:Pdb'

# Replacements
alias ls='lsd --group-directories-first'
alias ll='ls -l'
alias cat='bat --style plain'
alias more='cat'
alias vim='nvim'

# Testing commands
alias pt="pytest -s --disable-warnings"
alias ppt="pt -n 4"
alias u='make unittests'
alias f='make format'
alias l='make lint'
alias docker-stop-all='docker ps -q | xargs docker stop'

# git commands
alias ga='git add .'
alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push --force-with-lease --force-if-includes origin HEAD'
alias 'gp!'='git push --force origin HEAD'
alias gpl='git pull origin HEAD'
alias gf='git fetch'
alias gfm='git fetch origin master:master'
alias gb='git branch'
alias gco='git checkout'
alias grb='git rebase -i master'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbt='git-rebase-tip'
alias gpp='ga && gca && gp'

alias k='kubectl'


# Useful functions
git-rebase-tip () {
    if [[ $# -eq 0 ]] ; then
        echo 'Please, provide branch name to merge onto';
    else
    
        if [[ $# -eq 2 ]] ; then
            NUM_COMMITS=${2};
        else
            NUM_COMMITS=1;
        fi
        echo "Rebasing last ${NUM_COMMITS} onto ${1}";
        git rebase --onto ${1} HEAD~${NUM_COMMITS};
    fi
}

function activate() {
    [ -d ".venv" ] && { source .venv/bin/activate };
    [ -d "venv" ] && { source venv/bin/activate };
    return 0;
}

function pinit() {
    mkdir -p $1;
    touch ${1}/__init__.py;
    echo "Created __init__.py in ${1}"
} 

function dsh() {
  docker-compose run --rm ${1} /bin/bash
} 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.private-stuff || true