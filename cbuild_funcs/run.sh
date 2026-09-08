#!/bin/bash

# aqui jaz a função run que roda o programa que foi compilado pelo build

# colocar error handling para o caso de não achar o arquivo de compilação

build_dir=$(find "./" -type d -name "build")

run_file=$(find $build_dir -maxdepth 1 -type f -printf '%T+ %p\n' | sort -r | head -1 | cut -d' ' -f2-)

./$run_file