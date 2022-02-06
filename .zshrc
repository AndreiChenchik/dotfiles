# https://brew.sh
export PATH=/usr/local/bin:/opt/homebrew/bin:$PATH
# https://www.deta.sh
export PATH="$HOME/.deta/bin:$PATH"
# https://ohmyz.sh
plugins=(zsh-autosuggestions copydir copyfile history)
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
# https://starship.rs
eval "$(starship init zsh)"
# https://direnv.net
eval "$(direnv hook zsh)"
# https://python-poetry.org
export PATH="$HOME/.poetry/bin:$PATH"
# https://www.atlassian.com/git/tutorials/dotfiles
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# https://github.com/Homebrew/brew/issues/3933
source $HOME/.scripts/brw.sh

alias macup="brew update && brew upgrade \
 && mas reset && mas upgrade \
 && softwareupdate --list --force \
 && softwareupdate --download \
 && poetry self update \
 && brew bundle cleanup --file=${HOME}/.Brewfile --force"
export PATH="/opt/homebrew/sbin:$PATH"

export PYTHONUNBUFFERED=1
export PYTHONDONTWRITEBYTECODE=1

export PATH="$HOME/.scripts/bin:$PATH"

# Kubernetes
alias k='kubectl'
alias ktx='kubectx'
alias kns='kubens'
source <(kubectl completion zsh)
complete -F __start_kubectl k

# https://github.com/AndreiChenchik/env-injector
source $HOME/env-injector/activate.sh
source $HOME/.scripts/1penv.sh
