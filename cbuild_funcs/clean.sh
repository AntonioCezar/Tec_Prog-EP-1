#!/bin/bash

#aqui jaz a função clean que limpa os arquivos temp criados e o arquivo de compilação
#clean() apaga os arquivos de build
#cleanAll() apaga os arquivos de build e apaga os logs

#Obs.:
#falta registrar os logs

clean() {
    #verifica se o diretório build existe e não está vazio
    if [[ -d "./build" && -n "$(find "./build" -mindepth 1 -print -quit)" ]]; then 

        #apaga os arquivos de build, se houver erro, manda para o $error_text
        if find "./build" -mindepth 1 -delete 2> "$error_text"; then
            echo "Os arquivos build foram apagados com sucesso"
            return 0
        else
            echo "Não foi possível apagar os arquivos de build."
            cat "$error_text"
            return 1
        fi

    else 
        echo "Não há arquivos build para apagar"
        return 0
    fi
}

cleanAll() {
    #apaga os arquivos de build
    clean

    #verifica se o diretório logs existe e não está vazio
    if [[ -d "./logs" && -n "$(find "./logs" -mindepth 1 -print -quit)" ]]; then

        #apaga os logs, se houver erro, manda para o $error_text
        if find "./logs" -mindepth 1 -delete 2> "$error_text"; then
            echo "Os logs foram apagados com sucesso"
            return 0
        else
            echo "Não foi possível apagar os arquivos de build."
            cat "$error_text"
            return 1
        fi

    else 
        echo "Não há logs para apagar"
        return 0
    fi
}

#procura a partir daqui o arquivo "logs.sh"
logs_path=$(find "./" -type f -name "logs.sh") 

#cria arquivo temp de erro
error_text=$(mktemp)

#deixa o parâmetro em caixa baixa
clean_mode="${1,,}"

case "$clean_mode" in
    "all" )
        cleanAll
        #aqui falta registrar um log
        ;;
    "" )
        clean
        #aqui falta registrar um log
        ;;
    *)
        echo "O parâmetro -$clean_mode- não existe."
        ;;
esac

trap ' rm -f "$error_text" ' EXIT