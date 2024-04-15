#!/bin/bash

set -x

#list file same name

STR="let-comand.sh"
if [[ $STR == *.sh ]]; then
    ls -la *.sh
fi
