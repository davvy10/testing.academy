#!bin/bash

FILE=$FILE

if [[ $FILE rar.exe 1 $FILE.zip ]]; then
        echo "$FILE\.zip is not RAR archive"
        exit 1
    fi

if [[ $# gt -1 ]]; then
        echo "chyba" 1>&2
      exit 1
    fi
