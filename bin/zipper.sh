#!/bin/bash

TYPE=$(file --mime-type ${1} | cut -d' ' -f2)

if [[ $# ne -1 ]]; then
        echo "chyba" 1>&2
      exit 1
    fi



