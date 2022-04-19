#! /usr/bin/env bash

hackFolder="$(realpath "$(dirname "$0")")"

# import container cli alias
. "$hackFolder"/utils/container-alias.sh

containerCli build -f "$hackFolder/php-cli.dockerfile" -t kajapp-php-cli "$hackFolder" "$@"