#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# _golden <label> <golden> <result>
_golden() {
  if ! diff --unified --label golden --label "$1" "$2" "$3"; then
    cp --interactive --backup "./$3" "$2" </dev/tty
  fi
}

find . \
  -mindepth 1 -maxdepth 1 \
  -type d \
  ! -name 'public' ! -name 'layouts' \
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
