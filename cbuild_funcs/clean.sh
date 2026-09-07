#!/bin/bash

#aqui jaz a função clean que limpa os arquivos temp criados e o arquivo de compilação

#Obs.:
#falta apagar os arquivos temp
#falta fazer um log registrando a limpeza

clean() {
    #verifica se o diretório build existe e não está vazio
    if [[ -d "./build" && ! -z "$(ls -A "./build")" ]]; then 
        #apaga os arquivos de build
        find "./build" -mindepth 1 -delete
        echo "Os arquivos build foram apagados com sucesso"
    else 
        echo "Não há arquivos build para apagar"
    fi
}

cleanAll() {
    #apaga os arquivos de build e os arquivos temp
    clean

    #verifica se o diretório logs existe e não está vazio
    if [[ -d "./logs" && ! -z "$(ls -A "./logs")" ]]; then 
        #apaga os logs
        find "./logs" -mindepth 1 -delete
        echo "Os logs foram apagados com sucesso"
    else 
        echo "Não há logs para apagar"
    fi
}

#procura a partir daqui um arquivo "logs.sh"
logs_func=$(find "./" -type f -name "logs.sh") 

clean_mode="$1"

case "$clean_mode" in
    "ALL" | "AAl" | "AlL" | "All" | "aLL"| "aLl" | "alL" | "all" )
        cleanAll
        ;;
    "" )
        clean
        ;;
    *)
        echo "O parâmetro -$clean_mode- não existe."
        ;;
esac