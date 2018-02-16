#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "When APPID and RESTAPIKey is exists, then everything is okay" {
 
    #setup
    curl -sX GET "https://parseapi.back4app.com/classes/movies" -H "X-Parse-Application-Id: axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ" -H "X-Parse-REST-API-Key: sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk" -H "Content-Type: application/json"

 
    APPID="axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ"
    RESTAPIKey="sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"
} 















































#URL="https://parseapi.back4app.com/classes/movies-H \"X-Parse-{$A    PPID}-H \"X-Parse-{$RESTAPIKey}-H \"Content-Type: application/jso    n"
 
#echo $URL
#echo curl -s "https://parseapi.back4app.com/classes/movies"


 

