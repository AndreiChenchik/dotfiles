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
# https://github.com/AndreiChenchik/env-wrapper
env_wrapped=(flask packer deta deta-update-environment python)
source $HOME/.env-wrapper/activate.sh

export PATH="$HOME/.scripts/bin:$PATH"

alias dev="cd $HOME/Documents/Developer"
alias eops="cd $HOME/Documents/enableOps"

# https://www.atlassian.com/git/tutorials/dotfiles
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# https://github.com/Homebrew/brew/issues/3933
brw() {
  local dump_commands=('install' 'uninstall')
  local main_command="${1}"

  brew ${@}

  for command in "${dump_commands[@]}"; do
    if [[ "${command}" == "${main_command}" ]]; then
        brew bundle dump --file="${HOME}/.Brewfile" --force
    fi
  done
}

alias macup="brew update && brew update\
 && brew bundle install --file="${HOME}/.Brewfile"\
 && mas reset && mas upgrade\
 && softwareupdate --list --force\
 && softwareupdate --download\
 && brew bundle cleanup --file="${HOME}/.Brewfile"