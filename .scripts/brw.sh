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
