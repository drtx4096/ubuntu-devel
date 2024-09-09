#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

function usage() {
    echo "
        Usage: $0 [args and options]

        This is an example Bash command-line argument parser. It parses defined options
        and leaves the positional arguments on the command-line.

        -h | --help: Print this usage statement and exit.
        --ip: Provide an IP address. The default is 127.0.0.1.
        " | sed -E -e 's/^\s*//'  # Remove leading whitespace in output.
}

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo "script_dir = $script_dir"

# Parse arguments.
allow_undefined_option=false
positional=()
IP_ADDR="127.0.0.1"
while [ $# -gt 0 ]; do
    key="$1"
    case $key in
    -h | --help)
        usage
        exit 1
        ;;
    --ip)
        IP_ADDR="$2"
        shift 2
        ;;
    --) # Allow users to stop argument processing
        shift
        positional+=("$@")
        break
        ;;
    -*) # Unknown option
        if $allow_undefined_option; then
            positional+=("$key") # Save it in an array for later
            shift
        else
            >&2 echo "ERROR: Unknown option: $key"
            exit 1
        fi
        ;;
    *)                       # Positional argument.
        positional+=("$key") # Save it in an array for later
        shift
        ;;
    esac
done
set -- "${positional[@]}" # Restore positional parameters
unset positional

echo "IP_ADDR = $IP_ADDR"
echo "Remaining command line args = " "$@"
