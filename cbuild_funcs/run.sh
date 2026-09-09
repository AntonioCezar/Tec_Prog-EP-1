#!/bin/bash

# aqui jaz a função run que roda o programa que foi compilado pelo build

#Função que formata a variavel runtime
get_runtime() {
  local runtime_ns=$1

  local all_sec=$(( runtime_ns / 1000000000 ))
  local milisec=$(( runtime_ns / 1000000 % 1000 ))

  local min=$(( all_sec / 60  ))
  local sec=$(( all_sec % 60 ))

  if [[ $min -gt 0 ]]; then
    printf "%dm%ds%03ds" "$min" "$sec" "$milisec"
  else
    printf "%ds%03ds" "$sec" "$milisec"
  fi
}

out_text=$(mktemp -p "$command_log_dir" 02_build.XXXXXX)

build_dir=$(find "./" -type d -name "build")

if [[ -z $build_dir ]]; then
  echo "Nenhum Arquivo Presente Na Pasta './build'!" >> $out_text
  echo "A pasta './build' está vazia! - Use './cbuild.sh build <dir> <output_name>' para compilar seu programa"
  exit 1
fi

#Guarda o caminho do executável mais recente
run_file=$(find $build_dir -maxdepth 1 -type f -executable -printf '%T+ %p\n' | sort -r | head -1 | cut -d' ' -f2-)

if [[ -z "$run_file" ]]; then
  echo "Arquivo de Execução Não Encontrado Na Pasta './build'!" >> $out_text
  echo "Nenhum arquivo de execução encontrado!"
  exit 1
fi

#Registra o início da execução
start=$(date +%s%N)

#Executa o arquivo, se houver erro, manda para o $out_text
./"$run_file" 2>> "$out_text"
exit_code=$?

#Registra o fim da execução
end=$(date +%s%N)

#Armazena runtime em segundos+nanossegundos 
runtime_ns=$(( (end - start) ))

#Armazena variável runtime mais legível
runtime=$(get_runtime "$runtime_ns")

if [[ $exit_code -eq 0 ]]; then
  echo "Programa Executado Com Sucesso!" >> $out_text
  echo "Tempo de execução: $runtime" >> $out_text
  echo "Execução bem-sucedida."
  exit 0

elif [[ $exit_code -eq 126 ]]; then
  echo "Permissão insuficiente para executar o arquivo '$run_file'" >> "$out_text"
  echo "Erro: falha de permissão ao executar o arquivo"
  exit 1

elif [[ $exit_code -eq 127 ]]; then
  echo "Não foi possível encontrar o caminho do executável '$run_file'" >> "$out_text"
  echo "Erro: o caminho do executável não foi encontrado"
  exit 1

elif [[ $exit_code -gt 128 ]]; then
  sinal=$((exit_code - 128))
  echo "Programa encerrado pelo sinal $sinal ($(kill -l $sinal))" >> "$out_text"
  echo "Erro em tempo de execução! Acesse o log para mais informações"
  exit 1

else
  echo "Erro desconhecido! Acesse o log para mais informações"
  exit 1
fi