#! /usr/bin/env bash

filename=$0

# sets hack folder if script is called by itself, otherwise the parent script needs to set hack folder
if [ -z "$hackFolder" ]; then
    hackFolder="$(realpath "$(dirname "$filename")")"
fi

# import container cli alias
. "$hackFolder"/utils/container-alias.sh

# build image if it doesn't exist
if [ -z "$(containerCli images -q kajapp-php-cli)" ]
then
  containerCli build -f "$(dirname "$0")/php-cli.dockerfile" -t kajapp-php-cli "$(dirname "$0")"
fi

# run image
containerCli run --rm -it -v "$(dirname "$hackFolder")/api":/home/app/kajapp -w /home/app/kajapp kajapp-php-cli "$@"
