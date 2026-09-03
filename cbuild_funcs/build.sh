#!/bin/bash

# aqui jaz a função build simples (pois ainda compila tudo e não apenas o que foi modificado) que compila o programa em c

error_text=$(mktemp) # variavel temporaria de erro (o clean vai precisar limpar ela caso exista)

logs_func=$(find "./" -type f -name "logs.sh")

trap './$logs_func "Compilação mal-sucedida" < "$error_text"; echo "Erro na execução do comando build"; exit 1' ERR # caso tenha erro manda para o log

program_folder="$1"; # aqui vai o diretório que o user vai passar ./cbuild b <dir>
out_name="$2" # vai ser o nome que o user passar para o comando ./cbuild b <dir> <nome>

if [[ ! -d $program_folder ]]; then # checagem para ver se o dir existe
    ./$logs_func "Compilação mal-sucedida" <<< "Diretório '$program_folder' Não Encontrado!"
    echo "Erro na execução do comando build"
    exit 1
fi

comp_files=$(find "$program_folder" -type f -iname "*.c" | xargs -n 1 echo | tr '\n' ' ') # acha e formata todos os arquivos .c

if [[ -z "${comp_files// }" ]]; then # checagem para ver se comp_files não está vazio
    ./$logs_func "Compilação mal-sucedida" <<< "Nenhum Arquivo de Extensão .c Encontrado!"
    echo "Erro na execução do comando build"
    exit 1
fi

if [[ ! -d "./build" ]]; then
    mkdir build
fi

gcc $comp_files -o "./build/$out_name" 2> "$error_text" # compila os arquivos que achou acima e retorna erro caso dê errado

./$logs_func "Compilação bem-sucedida" <<< "$out_name" # caso tudo funcione manda para o log
echo "Comando build executado com sucesso"