#!/bin/env bats

@test "when new folder with existing name is going to be created then error message is shown" {

    # setup
    DIR=dirx
    mkdir ${DIR}

    [[ $(mkdir ${DIR} 2>&1) = "mkdir: cannot create directory ‘${DIR}’: File exists" ]]

    # teardown
    rmdir ${DIR}
}


@test "when i create new folder then folder is created" {
    # setup
    DIR=diry

    mkdir ${DIR} && [[ -d ${DIR} ]]  

    # teardown
    rmdir ${DIR}
}


@test "when i create new folder then the folder is empty" {
    # setup
    DIR=dirz 

    mkdir ${DIR}
    [[ $(ls -a ${DIR} | wc -l) -eq 2 ]]

    # teardown
    rmdir ${DIR}
}


@test "when i put path which doesnt exists then error" {
    # setup
    
    DIR="/doesnt/exist"
    [[ $(mkdir ${DIR} 2>&1) = "mkdir: cannot create directory ‘${DIR}’: No such file or directory" ]] 

    #teardwon
}


@test "when parameter is too many then error" {
    # setup
    DIR=dirxz

    mkdir ${DIR}
    [[ $# -gt 1 ]]

    #teardown
    rmdir ${DIR}
}


@test "when folder is directory then has certain rights" {
    # setup
    DIR=dirxxx

    mkdir ${DIR}
    [[ -r ${DIR} ]]

    # teardown
    rmdir ${DIR}
}


@test "when folder hasnt a name then error" {
    
    DIR=" "
    [[ ! $(mkdir ${DIR} 2>&1) = "Try 'mkdir --help' for more information" ]]

}


@test "when folder has non exists option" {
    
    OPT="w"
    [[ $(mkdir -${OPT} 2>&1) = "mkdir: invalid option -- '${OPT}'
Try 'mkdir --help' for more information." ]]
    
}
 

 #@test "when name of created folder is too long, then error" {
    DIR="222222222222222222222222222222222222222222222222222222222222222222222222222222222111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222222222222222222222222222222222222211111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111112222222222222222222222222222222222222222222222222222222222222222222222222222222221111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222222222222222222222222222222222222222222222222222222222222222111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222222222222222222222222222222222222211111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111112222222222222222222222222222222222222222222222222222222222222222222222222222222221111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222222222222222222222222222222222222222222222222222222222222222111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222222222222222222222222222222222222222222222222222222222222222111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222222222222222222222222222222222222211111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111112222222222222222222222222222222222222222222222222222222222222222222222222222222221111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222222222222222222222222222222222222222222222222222222222222222111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222222222222222222222222222222222222211111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111112222222222222222222222222222222222222222222222222222222222222222222222222222222221111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    [[ $(mkdir ${DIR} 2>&1) = "mkdir: cannot create directory ‘${DIR}’: File name too long" ]]
 }
