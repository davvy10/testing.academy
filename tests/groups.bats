#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'


    #setup
    weather=$(curl -s "http://api.openweathermap.org/data/2.5/weather?units=metric&APPID=3718d7f90e7b081ca8f46aa4305c05ea&q=kosice")


@test "when main doesnt exists, then erorr" {

    assert_equal $(echo "$weather" | egrep -o 'main') "main"
}


@test "when coord folder doesnt exists, then erorr" {

    run echo $(echo "$weather" | jq .coord)
    assert [ ! "$output" = "null" ]
}
