#! /usr/bin/env bash

shopt -s expand_aliases # resolve aliases, does not work with sudo
alias nerdctl='sudo nerdctl' # fix for expand_aliases

if [ -x "$(command -v docker)" ] && ! [ -x "$(command -v nerdctl)" ]
then
  alias nerdctl='sudo docker'
fi

if [ -z "$(nerdctl images -q kajapp-php-cli)" ]
then
  nerdctl build -f "$(dirname "$0")/php-cli.dockerfile" -t kajapp-php-cli "$(dirname "$0")"
fi

nerdctl run --rm -it -v "$(dirname "$(realpath "./$(dirname "$0")")")/api":/home/app/kajapp -w /home/app/kajapp kajapp-php-cli "$@"
