#!/bin/bash

set -euo pipefail

LOOP=${LOOP:-0}

if [ "${LOOP}" == "1" ]; then
    exit 0
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd "${DIR}"
    if [[ ! -d node_modules/@angular/cli ]]; then
        echo "Running npm ci in non-production mode to load dev dependencies"
        env -i LOOP=1 PATH="$PATH" npm ci
    fi

    if [[ ! -d dist ]]; then
        echo "Running build"
        npm run build

        # echo "Pruning dev dependencies"
        # npm prune --production
    fi
popd
