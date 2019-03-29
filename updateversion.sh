#!/bin/bash

usage() {
	echo "./updateversion.sh -p PREVIOUS_VERSION -v NEW_VERSION"
	echo
	echo "Example:"
	echo "./updateversion.sh -p 0.6.2 -v 0.6.3"
	echo

	exit 1;
}

# Accept the variables as command line arguments as well
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -p|--prev)
            PREV="$2"
	    shift
	    shift
        ;;
	-v|--new)
	    VERSION="$2"
	    shift
	    shift
	;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
        ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ -z $PREV ]; then
	usage
fi

if [ -z $VERSION ]; then
	usage
fi

git pull

find ./ -iname "*md" -exec sed -i "s/$PREV/$VERSION/g" {} \;

git add docs/
git commit -m "Update version number to $VERSION"
git push

mkdocs gh-deploy

