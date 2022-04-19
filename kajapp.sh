#! /usr/bin/env bash

filename=$0
hackFolder="$(realpath "$(dirname "$filename")")/hack"

globalHelp() {
    echo "Usage:"
    echo -e "\t $filename -h                                            Show this help message"
    echo -e "\t $filename php-cli [-h | <command args>]                 Call the php-cli with optional arguments"
    echo -e "\t $filename up [-h | <command args>]                      Call compose-up with optional arguments"
    echo -e "\t $filename up [-h]                                       Call compose-down"
}

phpCliHelp() {
    echo "Command \"php-cli\" usage:"
    echo -e "\tlorem ipsum"
}

upHelp() {
    echo "Command \"up\" usage:"
    echo -e "\tlorem ipsum"
}

downHelp() {
    echo "Command \"down\" usage:"
    echo -e "\tlorem ipsum"
}

phpCliAction() {
    echo "command parameters passed to \"php-cli\": $1"
    . "$hackFolder"/php-cli.sh
}

upAction() {
    echo "command parameters passed to \"up\": $1"
    #TODO: call compose up
}

downAction() {
    echo "down function called"
    #TODO: call compose down
}

if [ ! 0 == $# ]; then
    while getopts ":h" option; do
        case $option in
            h)
                globalHelp
                exit 0
                ;;
            ?)
                echo "Invalid option: ${OPTARG}"
                globalHelp
                exit 1
                ;;
        esac
    done
    shift $((OPTIND - 1))
    command=$1
    shift
    case "$command" in
        help)
            globalHelp
            exit 0
            ;;
        php-cli)
            unset OPTIND
            while getopts ":h" option; do
                case $option in
                    h)
                        phpCliHelp
                        exit 0
                        ;;
                    ?) ;;
                esac
            done
            phpCliAction "$*"
            ;;
        up)
            unset OPTIND
            while getopts ":h" option; do
                case $option in
                    h)
                        upHelp
                        exit 0
                        ;;
                    ?) ;;
                esac
            done
            upAction "$*"
            ;;
        down)
            unset OPTIND
            while getopts ":h" option; do
                case $option in
                    h)
                        downHelp
                        exit 0
                        ;;
                    ?)
                        echo "Invalid option: ${OPTARG}"
                        echo "This command does not accept options"
                        downHelp
                        exit 1
                        ;;
                esac
            done
            downAction
            ;;
        *)
            if [ -n "$command" ]; then
                echo "Invalid command: $command"
            fi
            globalHelp
            exit 1
            ;;
    esac
else
    globalHelp
    exit 1
fi
