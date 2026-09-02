#!/bin/bash

# aqui jaz a função build simples (pois ainda compila tudo e não apenas o que foi modificado) que compila o programa em c

trap './logs.sh "Compilação mal-sucedida"; echo "Erro na execução do comando build"; exit 1' ERR # caso tenha erro manda para o log

program_folder="../Mock_Program" # aqui vai o diretório que o user vai passar ./cbuild b <dir>

out_name="nome_parametro" # vai ser o nome que o user passar para o comando ./cbuild b <dir> <nome>

comp_files=$(find "$program_folder" -type f -iname "*.c" | xargs -n 1 echo | tr '\n' ' ') # acha e formata todos os arquivos .c

gcc $comp_files -o "$out_name" # compila os arquivos que achou acima

./logs.sh "Compilação bem-sucedida" # caso funcione manda para o log
echo "Comando build executado com sucesso"