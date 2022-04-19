#! /usr/bin/env bash

hackFolder="$(realpath "$(dirname "$0")")"

# import container cli alias
. "$hackFolder"/utils/container-alias.sh

containerCli compose down --file "$(dirname "$hackFolder")/compose.yaml"