#! /usr/bin/env bash

filename=$0
hackFolder="$(realpath "$(dirname "$filename")")/hack"

globalHelp() {
    echo "Usage:"
    echo -e "\t $filename -h                                            Show this help message"
    echo -e "\t $filename php-cli [-h | <command args>]                 Call the php-cli with optional arguments"
    echo -e "\t $filename up [-h | <command args>]                      Call compose-up with optional arguments"
    echo -e "\t $filename build [-h | <command args>]                   Yep, its here!"
    echo -e "\t $filename down [-h]                                     Call compose-down"
    echo -e "\t $filename exec [-h | <command args>]                    Call exec on the container defined in args"
    echo -e "\t $filename migrate                                       Run database migrations"
    echo -e "\t $filename pass-gen                                      Generate password hash"
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

buildHelp() {
    echo "Command \"build\" usage:"
    echo -e "\tlorem ipsum"
}

execHelp() {
    echo "Command \"exec\" usage:"
    echo -e "\tlorem ipsum"
}

migrateHelp() {
    echo "Command \"migrate\" usage:"
    echo -e "\tlorem ipsum"
}

passGenHelp() {
    echo "Command \"migrate\" usage:"
    echo -e "\tlorem ipsum"
}

phpCliAction() {
    echo "Command parameters passed to \"php-cli\": $1"
    "$hackFolder"/php-cli.sh $1
}

upAction() {
    echo "Command parameters passed to \"up\": $1"
    "$hackFolder"/compose-up.sh $1
}

downAction() {
    echo "Down function called"
    "$hackFolder"/compose-down.sh
}

buildPhpCliAction() {
    echo "Command parameters passed to \"build php-cli\": $1"
    "$hackFolder"/build-php-cli.sh $1
}

buildComposeAction() {
    echo "Command parameters passed to \"build compose\": $1"
    "$hackFolder"/build-compose.sh $1
}

execAction() {
    echo "Command parameters passed to \exec\": $1"
    "$hackFolder"/container-exec.sh $1
}

migrateAction() {
    echo "Running database migrations..."
    "$hackFolder"/container-exec.sh kajapp-php-api bin/console doctrine:migrations:migrate --no-interaction -vv
}

passGenAction() {
    echo "Hashing password: $1"
    "$hackFolder"/container-exec.sh kajapp-php-api bin/console security:hash-password --empty-salt --no-interaction "$1" "App\Entity\User"
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
                        echo "This command only accepts the -h option"
                        downHelp
                        exit 1
                        ;;
                esac
            done
            downAction
            ;;
        build)
            unset OPTIND
            while getopts ":h" option; do
                case $option in
                    h)
                        buildHelp
                        exit 0
                        ;;
                    ?)
                        echo "Invalid option: ${OPTARG}"
                        echo "This command only accepts the -h option"
                        buildHelp
                        exit 1
                        ;;
                esac
            done
            subcommand=$1
            shift
            case "$subcommand" in
                php-cli)
                    buildPhpCliAction "$*"
                    ;;
                compose)
                    buildComposeAction "$*"
                    ;;
                *)
                    if [ -n "$subcommand" ]; then
                        echo "Invalid subcommand: $subcommand"
                    fi
                    buildHelp
                    exit 1
                    ;;
            esac
            ;;
        exec)
            unset OPTIND
            while getopts ":h" option; do
                case $option in
                    h)
                        execHelp
                        exit 0
                        ;;
                    ?) ;;
                esac
            done
            execAction "$*"
            ;;
        migrate)
            unset OPTIND
            while getopts ":h" option; do
                case $option in
                    h)
                        migrateHelp
                        exit 0
                        ;;
                    ?) ;;
                esac
            done
            migrateAction
            ;;
        pass-gen)
            unset OPTIND
            while getopts ":h" option; do
                case $option in
                    h)
                        passGenHelp
                        exit 0
                        ;;
                    ?) ;;
                esac
            done
            passGenAction "$*"
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
