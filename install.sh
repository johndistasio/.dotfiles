#!/usr/bin/env zsh

# Anything that would be symlinked into these directories is copied instead.
copy=(
  $HOME/.config/nvim/autoload
)

# Link files from a given directory at ~/.filename
function link() {
  local dir="${1}"
  local dryrun="${2}"

  if [[ ! -d "${dir}" ]]; then
    echo "Warning: '${dir}' is not a directory; skipping..."
    return
  fi

  if [[ -n "${dryrun}" ]]; then
    echo "DRYRUN"
  fi

  while read -r d; do
    d="${d/$dir/$HOME}"
    d="${d/$HOME\//$HOME/.}"

    if [[ -z "${dryrun}" ]]; then
      mkdir -p "${d}"
    fi

  done < <(find "${dir}" -type d -mindepth 1)

  while read -r f; do
    l="${f/$dir/$HOME}"
    l="${l/$HOME\//$HOME/.}"

    c=0

    for item in "${copy[@]}"; do
      if [[ "${l}" == "${item}/$(basename ${f})" ]]; then

        echo "'${l}' <= '${f}'"

        if [[ -z "${dryrun}" ]]; then
          cp -f "${f}" "${l}"
        fi

        c=1

      fi
    done

    if [[ $c == 0 ]]; then

      echo "'${l}' <- '${f}'"

      if [[ -z "${dryrun}" ]]; then
        ln -s -f "${f}" "${l}"
      fi
    fi

  done < <(find "${dir}" -type f -mindepth 1)
}


DOTS="${1}"

if [[ -z "${DOTS}" ]]; then
  DOTS="${PWD}/home"
fi

if [[ -z "${HOME}" ]]; then
  echo '$HOME is not set!'
  exit 1
fi

(link "${DOTS}" "${DRYRUN}") | column -t
