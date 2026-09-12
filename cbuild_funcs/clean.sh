#!/bin/bash

#aqui jaz a função clean que limpa os arquivos temp criados e o arquivo de compilação
#clean() apaga os arquivos de build
#cleanAll() apaga os arquivos de build e apaga os logs


#cria arquivo temp de erro
out_text=$(mktemp -p "$command_log_dir" 01_clean.XXXXXX)

clean() {
    #verifica se o diretório build existe e não está vazio
    if [[ -d "./build" && -n "$(find "./build" -mindepth 1 -print -quit)" ]]; then 

        #apaga os arquivos de build, se houver erro, manda para o $out_text
        if find "./build" -mindepth 1 -delete 2>> "$out_text"; then
            echo "Os Arquivos Da Pasta './build' Foram Apagados Com Sucesso" >> $out_text
            echo "Os arquivos build foram apagados com sucesso"
            return 0
        else
            echo "Não foi possível apagar os arquivos de build. Acesse o log para mais informações"
            return 1
        fi

    else 
        echo "Não Há Nenhum Arquivo Na Pasta './build' Para Apagar!" >> $out_text
        echo "Não há arquivos build para apagar"
        return 0
    fi
}

cleanAll() {
    #apaga os arquivos de build
    clean

    #verifica se o diretório logs existe e não está vazio
    if [[ -d "./logs" && -n "$(find "./logs" -mindepth 1 -print -quit)" ]]; then

        #apaga os logs, se houver erro, manda para o $out_text
        if find "./logs" -mindepth 1 -delete 2> "$out_text"; then
            echo "Os Arquivos Da Pasta './logs' Foram Apagados Com Sucesso" >> $out_text
            echo "Os logs foram apagados com sucesso"
            return 0
        else
            echo "Não foi possível apagar os arquivos de build."
            return 1
        fi

    else 
        echo "Não Há Nenhum Arquivo Na Pasta './logs' Para Apagar!" >> $out_text
        echo "Não há logs para apagar"
        return 0
    fi
}

#deixa o parâmetro em caixa baixa
clean_mode="${1,,}"

case "$clean_mode" in
    "all" )
        cleanAll
        ;;
    "" )
        clean
        ;;
    *)
        echo "O parâmetro -$clean_mode- não existe."
        ;;
esac