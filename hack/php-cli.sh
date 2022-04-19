#! /usr/bin/env bash

hackFolder="$(realpath "$(dirname "$0")")"

# import container cli alias
. "$hackFolder"/utils/container-alias.sh

# build image if it doesn't exist
if [ -z "$(containerCli images -q kajapp-php-cli)" ]; then
    "$hackFolder"/build-php-cli.sh
fi

# run image
containerCli run --rm -it -v "$(dirname "$hackFolder")/api":/home/app/kajapp -w /home/app/kajapp kajapp-php-cli "$@"