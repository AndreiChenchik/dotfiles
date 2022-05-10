# https://brew.sh
export PATH=/usr/local/bin:/opt/homebrew/bin:$PATH
# https://www.deta.sh
export PATH="$HOME/.deta/bin:$PATH"
# https://ohmyz.sh
plugins=(zsh-autosuggestions copypath copyfile history)
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

export GITHUB_ORG_IDENTITY=$(cat $HOME/.github_org_identity)
export VAULT_ADDR="https://vault.chenchik.me"

# Kubernetes
alias k='kubectl'
alias ktx='kubectx'
alias kns='kubens'
source <(kubectl completion zsh)
complete -F __start_kubectl k

# https://github.com/AndreiChenchik/env-injector
source $HOME/env-injector/activate.sh
source $HOME/.scripts/1penv.sh

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Volumes/External/Users/gumlooter/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Volumes/External/Users/gumlooter/miniforge3/etc/profile.d/conda.sh" ]; then
#         . "/Volumes/External/Users/gumlooter/miniforge3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Volumes/External/Users/gumlooter/miniforge3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
