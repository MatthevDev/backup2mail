#!/bin/bash

# Display usage page and exit:
function usage() {
    echo "Usage: backup2mail [-v|-h] -d <directory>"
    echo "    -v             -- Verbose mode"
    echo "    -h             -- Help page"
    echo "    -d <directory> -- directory to take backup of"
    exit;
}

# Verbose messages
function verbose() {
    if [[ $VERBOSE -eq 1 ]]; then
        echo $1;
    fi
}

# Parse options
VERBOSE=0

while getopts "d:hv" opt; do
    case $opt in
        v)
            VERBOSE=1;
        ;;
        d)
            DIRECTORY="$OPTARG"
        ;;
        h)
            usage
        ;;
        ?)
            usage
        ;;
    esac
done

if [[ -z "$DIRECTORY" ]]; then
    echo "[ERROR] no specified directory to backup! Use -d argument"
    usage
fi

verbose "[INFO] Checking specified directory"

if [[ ! -d "$DIRECTORY" ]]; then
    echo "[ERROR] Specified directory doesn't exists"
    echo "   │"
    echo "   └──> '${DIRECTORY}'"
    exit;
fi

verbose "[SUCCESS] Directory verified"
verbose "[INFO] Creating temp file for archive"

TEMPFILE=$(mktemp --suffix .tar.gz)

verbose "[SUCCESS] Temp file created under: $TEMPFILE"
verbose "[INFO] Compressing directory into temp file"

OPTIONS="cf"
if [[ $VERBOSE -eq 1 ]]; then
    OPTIONS+="v"
fi

tar $OPTIONS $TEMPFILE $DIRECTORY

verbose "[SUCCESS] Directory compressed"
verbose "[INFO] Sending file over email (for now saving it locally)"

# Integrate email sending here

DATEPREFIX=$(date +%Y%m%d_%H%M)
FILENAME="${DATEPREFIX}_backup.tar.gz"
cp $TEMPFILE $FILENAME

verbose "[SUCCESS] In this stage of development file saved locally under ${FILENAME}"
verbose "[SUCCESS] File sent"

verbose "[INFO] Deleting temp file"
rm $TEMPFILE
verbose "[INFO] Temp file deleted"

verbose "[SUCCESS] Bye"
