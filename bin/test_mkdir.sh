#!/bin/env bash

#when i create new folder then folder is created
#when i create new folder then exit status 0
#when create directory, which already exists, then write error
#when put path, which doesnt exist, then error
#when create more directory, then error
#when directory hasnt name, then error
#when 

# test setup
# ak zadam priecinok, ktory uz existuje, tak vypise chybu
DIR=dirx
mkdir ${DIR}
[[ $(mkdir ${DIR} 2>&1) = "mkdir: cannot create directory ‘${DIR}’: File exists" ]] || echo failed: when new folder with existing name is going to be created then error message is shown
# test teardown
rmdir ${DIR}

# ak zadam priecinok, tak je vytvoreny
#test setup
DIR=diry
mkdir ${DIR} && [[ -d ${DIR} ]] && [[ $(ls -a ${DIR} | wc -l) -eq 2 ]] && echo failed: when i create new folder then folder is created
#test teardown
