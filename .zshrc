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
# https://github.com/AndreiChenchik/env-wrapper
env_wrapped=(uvicorn docker-run-with-env deta deta-upd-env-prod deta-upd-env-dev)
source $HOME/.env-wrapper/activate.sh
source $HOME/.scripts/1penv.sh

export PATH="$HOME/.scripts/bin:$PATH"

alias dev="cd $HOME/Documents/Developer"
alias eops="cd $HOME/Documents/enableOps"

# https://www.atlassian.com/git/tutorials/dotfiles
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# https://github.com/Homebrew/brew/issues/3933
source $HOME/.scripts/brw.sh

alias macup="brew update && brew upgrade\
 && mas reset && mas upgrade\
 && softwareupdate --download --force\
 && poetry self update\
 && brew bundle cleanup --file=${HOME}/.Brewfile --force"
