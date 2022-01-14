1penv() {
  OP_APP=${1:-my.1password.com}
  OP_TAG=${2:-api}
  OP_VAULT=${3:-enableOps}
  OP_HOST=${4:-my.1password.com}  

  hostShorthand=$(op signin --list | grep https://$OP_HOST | head -1 | awk '{print $2}')

  if [[ -z $hostShorthand ]]; then
    echo "Plase sign in into $OP_HOST first"
    echo "Run 'op sigin --help' for more info"
  else
    sessionRef="OP_SESSION_$hostShorthand"
    
    if [ "$ENVINJ_SHELL" = "zsh" ]; then
	    sessionKey=${(P)sessionRef}
    else
      sessionKey=${!sessionRef}
    fi
    

    if newKey=$(op signin $OP_HOST --session ${sessionKey:-expired})
    then
      eval $newKey
      envs=$(op list items --vault ${OP_VAULT} --tags ${OP_TAG}/$1 | jq 'sort_by(.overview.title)' | op get item - | jq '.details.sections[] | select( has("fields") ) | .fields[] | {name: .t, value: .v}' | jq -r $' (.name) + "=\'" + (.value) + "\'" ')
      echo $envs
    fi
  fi
}
