#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# _golden <label> <golden> <result>
_golden() {
  if ! diff --unified --label golden --label "$1" "$2" "$3"; then
    if [[ -f "$3" ]]; then
      if [[ ! -f "$2" ]]; then
        echo "Output was:"
        sed 's/^/  /' "$3"
      fi
    else
      exit
    fi

    read -p "update '$2'? (y/N) " confirm </dev/tty
    case "$confirm" in
    y | Y) cp --backup "./$3" "$2" ;;
    esac
  fi
}

find . \
  -mindepth 1 -maxdepth 1 \
  -type d \
  ! -name 'public' ! -name 'layouts' ! -name 'assets' \
  -print0 |
  sort -z |
  while read -r -d '' dir; do
    echo "  + TEST: $(basename $dir)"

    rm --recursive -- ./public/ 2>/dev/null
    unlink ./errors.log

    if hugo --contentDir "$dir" 2>errors.log >/dev/null; then
      tidy -quiet -modify -indent --show-body-only yes ./public/index.html
      _golden "index.html" "$dir/golden.html" "public/index.html"
    else
      _golden "errors.log" "$dir/golden.log" "errors.log"
    fi
  done
