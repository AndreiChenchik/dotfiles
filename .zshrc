# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"


# https://www.atlassian.com/git/tutorials/dotfiles
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# https://brew.sh
export PATH="/usr/local/bin:/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
# https://stackoverflow.com/questions/68573454/having-difficulty-to-get-ssh-with-a-yubikey-working-with-macos-monterey
export PATH="$(brew --prefix openssh)/bin:$PATH"
# https://github.com/Homebrew/brew/issues/3933
source $HOME/.scripts/brw.sh


# https://direnv.net/
eval "$(direnv hook zsh)"


# https://python-poetry.org
export PATH="$HOME/.poetry/bin:$PATH"


# https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-zsh/
source <(kubectl completion zsh)
# https://www.studytonight.com/post/how-to-list-all-resources-in-a-kubernetes-namespace
function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found ${i}
  done
}


# https://docs.python.org/3/using/cmdline.html
export PYTHONUNBUFFERED=1
export PYTHONDONTWRITEBYTECODE=1
# https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


#export GITHUB_ORG_IDENTITY=$(cat $HOME/.github_org_identity)
#export VAULT_ADDR="https://vault.chenchik.me"

# https://github.com/AndreiChenchik/env-injector
#source $HOME/env-injector/activate.sh
source $HOME/.scripts/1penv.sh


alias macup="brew update && brew upgrade \
 && mas reset && mas upgrade \
 && softwareupdate --list --force \
 && softwareupdate --download \
 && poetry self update \
 && brew bundle cleanup --file=${HOME}/.Brewfile --force"


# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
