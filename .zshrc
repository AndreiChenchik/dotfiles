# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
# https://brew.sh
export PATH=/usr/local/bin:/opt/homebrew/bin:$PATH
# https://direnv.net/
eval "$(direnv hook zsh)"
# https://python-poetry.org
export PATH="$HOME/.poetry/bin:$PATH"
# https://www.atlassian.com/git/tutorials/dotfiles
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# https://github.com/Homebrew/brew/issues/3933
source $HOME/.scripts/brw.sh
# https://stackoverflow.com/questions/68573454/having-difficulty-to-get-ssh-with-a-yubikey-working-with-macos-monterey
export PATH=$(brew --prefix openssh)/bin:$PATH

alias macup="brew update && brew upgrade \
 && mas reset && mas upgrade \
 && softwareupdate --list --force \
 && softwareupdate --download \
 && poetry self update \
 && brew bundle cleanup --file=${HOME}/.Brewfile --force"
export PATH="/opt/homebrew/sbin:$PATH"

export PYTHONUNBUFFERED=1
export PYTHONDONTWRITEBYTECODE=1

#export GITHUB_ORG_IDENTITY=$(cat $HOME/.github_org_identity)
#export VAULT_ADDR="https://vault.chenchik.me"

# https://github.com/AndreiChenchik/env-injector
#source $HOME/env-injector/activate.sh
source $HOME/.scripts/1penv.sh

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
