#!/usr/bin/env bash

DIFF="diff --unified"

cd "$(dirname "${BASH_SOURCE[0]}")"

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
      $DIFF --label golden --label index.html \
        "$dir/golden.html" public/index.html || exit
    else
      $DIFF --label golden --label errors.log \
        "$dir/golden.log" "errors.log" || exit
    fi
  done
