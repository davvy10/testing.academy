#!/bin/bash

echo "Changing shell for" $USER
read -p  "New shell [$SHELL]: " ANSWER 

 if [[ ! -n $ANSWER ]]; then
    exit 0
    fi

if  [[ ! $ANSWER =~ ^/.+ ]]; then 
        echo "chsh.sh: shell must be a full path name" 1>&2
    exit 1
    fi

if [[ ! -e $ANSWER ]]; then
        echo "chsh.sh: \"$ANSWER\" does not exist" 1>&2
     exit 1 
    fi

if [[ ! -x $ANSWER ]]; then
        echo "chsh.sh: \"$ANSWER\" is not executable" 1>&2
     exit 1
     fi

if [[ ! $ANSWER =~ /etc/shells ]]; then
        echo "chsh.sh: \"$ANSWER\" is not listed in /etc/shells" 1>&2
     exit 1
     fi
