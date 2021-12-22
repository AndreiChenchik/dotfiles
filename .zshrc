export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH
export PATH="$HOME/.deta/bin:$PATH"
export PATH="$HOME/scripts/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-autosuggestions copydir copyfile history)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

alias macup="brew upgrade && mas reset && mas upgrade && softwareupdate --list --force && softwareupdate --download"
alias dev="cd $HOME/Documents/Developer"
alias eops="cd $HOME/Documents/enableOps"
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

opApps=(flask packer deta deta-update-environment python)

for app in ${opApps[@]}; do
  eval "
    ${app}() {
      appPath=\$(which -a \$0 | grep \"^/\" | head -1)

      if [[ -z \$appPath ]]
      then
        echo \"\$0 not found\" 
      else
        if [[ -z \$OP_HOST || -z \$OP_VAULT || -z \$OP_TAG ]]
        then
          eval \"\$appPath \$@\"
        else 
          hostShorthand=\$(op signin --list | grep https://\$OP_HOST | head -1 | awk '{print \$2}')
          if [[ -z \$hostShorthand ]]
          then
            echo \"Plase sign in into \$OP_HOST first\"
            echo \"Run 'op sigin --help' for more info\"
          else
            sessionRef=\"OP_SESSION_\$hostShorthand\"
            sessionKey=\${(P)sessionRef}
            
            if newKey=\$(op signin \$OP_HOST --session \${sessionKey:-expired})
            then
              eval \$newKey
              envs=\$(op list items --vault \${OP_VAULT} --tags \${OP_TAG},app/\$0 | op get item - --cache | jq '.details.sections[] | select( has(\"fields\") ) | .fields[] | {name: .t, value: .v}' | jq -r '\"\(.name)=\(.value)\"' | tr '\n' ' ')

              eval \"\${envs:0:-1} \$appPath \$@\"
            fi
          fi
        fi
      fi
    }
  "
done
