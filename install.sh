#!/bin/bash

DOTS="${HOME}/src/dotfiles/home"

# Link files from a given directory at ~/.filename
# @param1 path to directory
function link() {
  local dir="${1}"

  if [[ ! -d "${dir}" ]]; then
    echo "Warning: '${dir}' is not a directory; skipping..."
    return
  fi

  while read -r f; do
    ln -v -s "${dir}" "${HOME}/.$(basename ${f})"
  done < <(find "${dir}" -type f)
}

link "${DOTS}"
