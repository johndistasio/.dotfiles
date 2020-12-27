# Link files from a given directory at ~/.filename
# @param1 path to directory
function link() {
  local dir="${1}"
  local dryrun="${2}"

  if [[ ! -d "${dir}" ]]; then
    echo "Warning: '${dir}' is not a directory; skipping..."
    return
  fi

  while read -r d; do
    d="${d/$dir/$HOME}"
    d="${d/$HOME\//$HOME/.}"

    if [[ "${dryrun}" != "" ]]; then
      echo "mkdir -> ${d}"
    else
      mkdir -p "${d}"
    fi

  done < <(find "${dir}" -type d -mindepth 1)

  while read -r f; do
    l="${f/$dir/$HOME}"
    l="${l/$HOME\//$HOME/.}"


    if [[ "${dryrun}" != "" ]]; then
      echo "'${l}' -> '${f}'"
    else
      ln -v -s -f "${f}" "${l}"
    fi

  done < <(find "${dir}" -type f -mindepth 1)
}


DOTS="${1}"

if [[ -z "${DOTS}" ]]; then
  DOTS="${PWD}/home"
fi

(link "${DOTS}" "${DRYRUN}") | column -t
