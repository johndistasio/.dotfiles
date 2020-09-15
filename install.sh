# Link files from a given directory at ~/.filename
# @param1 path to directory
function link() {
  local dir="${1}"

  if [[ ! -d "${dir}" ]]; then
    echo "Warning: '${dir}' is not a directory; skipping..."
    return
  fi

  while read -r f; do
    ln -v -s -f "${f}" "${HOME}/.$(basename ${f})"
  done < <(find "${dir}" -type f)
}


DOTS="${1}"

if [[ -z "${DOTS}" ]]; then
  DOTS="${PWD}/home"
fi

(link "${DOTS}") | column -t
