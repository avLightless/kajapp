#! /usr/bin/env bash

shopt -s expand_aliases # resolve aliases, does not work with sudo
alias containerCli='sudo nerdctl' # fix for expand_aliases

# substitute nerdctl with docker, if only docker is installed
if [ -x "$(command -v docker)" ] && ! [ -x "$(command -v nerdctl)" ]
then
  alias containerCli='sudo docker'
fi