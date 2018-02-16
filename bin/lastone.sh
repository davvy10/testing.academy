#!/usr/bin/env bash

for file in *; do
    if [[ -d "$file" ]]; then
    echo "$file/"
    cd "$file"
    for FILE2 in *; do
    if [[ -d

