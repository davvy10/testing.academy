#!/usr/bin/env bats

@test "if chsh.sh is not able to run, then don't run any other tests" {
    run bash -c "which chsh.sh"

    # asserts
    [[ "${status}" -eq 0 ]]
    [[ -x "${output}" ]]
}


@test "if no path is given, then no change is provided and exit with status 0" {
    run bash -c 'echo -e "\n" | chsh.sh'

    # asserts
    [[ "${status}" -eq 0 ]]
}


@test "if no full path is provided, then print error message and exit with status 1" {
    run bash -c 'echo "something" | chsh.sh'

    # asserts
    [[ "${status}" -eq 1 ]]
    [[ "${output}" =~ "chsh.sh: shell must be a full path name" ]]
}


@test "if run with non existing file, then print error message and exit with status 1" {
    run bash -c 'echo "/this/path/doesnt/exist" | chsh.sh'

    # asserts
    [[ "${status}" -eq 1 ]]
    [[ "${output}" =~ "chsh.sh: \"/this/path/doesnt/exist\" does not exist" ]]
}


@test "if run with non executable file, then print error message and exit with status 1" {
    run bash -c 'echo "/etc/passwd" | chsh.sh'

    # asserts
    [[ "${status}" -eq 1 ]]
    [[ "${output}" =~ "chsh.sh: \"/etc/passwd\" is not executable" ]]
}


@test "if run with path, which is not in /etc/shells, then print error message and exit with status 1" {
    run bash -c 'echo "/usr/bin/vi" | chsh.sh'

    # asserts
    [[ "${status}" -eq 1 ]]
    [[ "${output}" =~ "chsh.sh: \"/usr/bin/vi\" is not listed in /etc/shells" ]]
}


#@test "bonus #1: if run with path, which is not in /etc/shells, then print error message and exit with status 1" {
    #run bash -c 'echo "/usr/bin/vi" | chsh.sh'

    ## asserts
    #[[ "${status}" -eq 1 ]]
    #[[ "${output}" =~ "chsh: \"/usr/bin/vi\" is not listed in /etc/shells" ]]
    #[[ "${output}" =~ "Use chsh.sh -l to see list." ]]
#}

@test "bonus #1: if run with '-l', then show content of /etc/shells and exit with status 0" {
    run bash -c "chsh.sh -l"

    # asserts
    [[ ${status} -eq 0 ]]
    [[ ${output} == $(cat /etc/shells) ]]
}

#@test "if user sandokan doesn't exist, then print error message and exit with status 1" {
    #run chsh sandokan
    
    ## asserts
    #[[ "${status}" -eq 1 ]]
    #[[ "${output}" = 'chsh: user "sandokan" does not exist.' ]]
#}


