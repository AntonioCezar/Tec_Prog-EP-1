#!/bin/bash

# aqui jaz a função run que roda o programa que foi compilado pelo build

out_text=$(mktemp -p "$command_log_dir" 03_run.XXXXXX)

build_dir=$(find "./" -type d -name "build")

if [[ -z $build_dir ]]; then
  echo "Nenhum Arquivo Presente Na Pasta './build'!" >> $out_text
  echo "A pasta './build' está vazia! - Use './cbuild.sh build <dir> <output_name>' para compilar seu programa"
  exit 1
fi

run_file=$(find $build_dir -maxdepth 1 -type f -printf '%T+ %p\n' | sort -r | head -1 | cut -d' ' -f2-)

if [[ -z $run_file ]]; then
  echo "Arquivo de Execução Não Encontrado Na Pasta './build'!" >> $out_text
  echo "Nenhum arquivo de execução encontrado!"
  exit 1
else
  ./$run_file 2>> $out_text || echo "Erro desconhecido! Acesse o log para mais informações"; exit 1
  echo "Programa Executado Com Sucesso!" >> $out_text
fi