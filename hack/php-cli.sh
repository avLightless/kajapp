#! /usr/bin/env bash

if ! [ -x "$(command -v docker)" ];
then
  alias nerdctl='docker'
fi

if [ "$(sudo nerdctl images -q kajapp-php-cli)" == '' ];
then
   sudo nerdctl build -f "$(dirname "$0")/php-cli.dockerfile" -t kajapp-php-cli "$(dirname "$0")"
fi

sudo nerdctl run --rm -it -v "$(dirname "$(realpath "./$(dirname "$0")")")/api":/home/app/kajapp -w /home/app/kajapp kajapp-php-cli "$@"
