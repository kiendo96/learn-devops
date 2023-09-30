#!/bin/bash

set -x

#list file same name

STR=file3
if [[ $STR == file[0-3] ]]; then
    rm -rf $STR
fi
