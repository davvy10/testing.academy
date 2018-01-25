#!/bin/bash

<<<<<<< HEAD
TYPE=$(file --mime-type ${1} | cut -d' ' -f2)

if [[ $# ne -1 ]]; then
=======
FILE=$FILE

if [[ $FILE rar.exe 1 $FILE.zip ]]; then
        echo "$FILE\.zip is not RAR archive"
        exit 1
    fi

if [[ $# gt -1 ]]; then
>>>>>>> 25d93b3594c94e65ed97f68518d6f53aa3441c8c
        echo "chyba" 1>&2
      exit 1
    fi



