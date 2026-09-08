#!/bin/bash

# aqui jaz a função rebuild que chama a func clean e dps chama a func build

clean_command=$(find "./" -type f -iname "clean.sh")

build_command=$(find "./" -type f -iname "build.sh")

./$clean_command

./$build_command "$1" "$2"