#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# _golden <golden> <result>
_golden() {
  if ! diff --unified --label golden --label "$(basename "$2")" "$1" "$2"; then
    if [[ -f "$2" ]]; then
      if [[ ! -f "$1" ]]; then
        echo "Output was:"
        sed 's/^/  /' "$2"
      fi
    else
      exit
    fi

    read -p "update '$1'? (y/N) " confirm </dev/tty
    case "$confirm" in
      y | Y) cp --backup "./$2" "$1" ;;
    esac
  fi
}

find . \
  -mindepth 1 -maxdepth 1 \
  -type d \
  ! -name 'public' ! -name 'layouts' \
  ! -name 'assets' ! -name 'data' \
  -print0 |
  sort -z |
  while read -r -d '' dir; do
    echo "  + TEST: $(basename $dir)"

    rm --recursive -- ./public/ 2>/dev/null
    mkdir ./public

    if hugo --contentDir "$dir" 2>./public/errors.log >/dev/null; then
      tidy -quiet -indent --show-body-only yes -output ./public/index.tidy.html public/index.html
      _golden "$dir/golden.html" "public/index.tidy.html"
    else
      sed --in-place -E -e 's/(\.html):[0-9]+:[0-9]+/\1:XX:XX/' ./public/errors.log
      _golden "$dir/golden.log" "public/errors.log"
    fi
  done
