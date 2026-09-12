#!/bin/bash

# aqui jaz a função info que mostra informações importantes sobre o cbuild e o programa do usuário

info() {
    
    echo ""
    echo ""
    echo "================================================================"
    echo "               CBUILD - PAINEL DE INFORMAÇÕES                   "
    echo "================================================================"
    echo ""
    echo " Este painel exibe o status atual do seu projeto em C."
    echo ""

    # encontra e calcula a quatidade de arquivos do projeto 

    echo "------------------- MÉTRICAS DO CÓDIGO ------------------------"
    echo ""

    qtd_arquivos_proj=$(find . -type f \( -name "*.c" -o -name "*.h" \) | wc -l)
    echo "Quantidade de arquivos do projeto: $qtd_arquivos_proj"

    # encontra todos os arquivos que terminam em .c e  .h e calcula a soma de todas as linhas de código presentes nesses arquivos, sem exceção
    qtd_linhas=$(find . -type f \( -name "*.c" -o -name "*.h" \) | xargs wc -l | tail -n 1 | awk '{print $1}')
    echo "Quantidade absoluta de linhas de código: $qtd_linhas"

    # geração do status de compilação

    echo ""
    echo ""
    echo "------------------- STATUS DE COMPILAÇÃO ----------------------"
    echo ""

    # verifica se existe uma pasta build 
    if [[ ! -d "./build" ]]; then
        echo "Nenhum arquivo foi compilado"

    # verifica se a pasta build possui algum arquivo 
    elif [[ -z "$(find ./build -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
        echo "Não há arquivo compilado"

    else 
        # encontra o arquivo executavel na pasta build 
        executavel=$(find ./build -maxdepth 1 -type f -executable | head -n 1)
        tamanho_executavel=$(stat -c %s $executavel)
        data_compilacao=$(date -r "$executavel" "+%d/%m/%Y às %H:%M:%S")

        echo "Tamanho do executável: $tamanho_executavel bytes"
        echo "Data de compilação: $data_compilacao"
        
     fi

    # data de execução do arquivo presente no projeto 

    echo ""
    echo ""
    echo "----------------- HISTÓRICO DE EXECUÇÂO ---------------------"
    echo ""

    # verifica se a pasta logs existe no diretório
    if [[ ! -d "./logs" ]]; then 
        echo "Nenhum comando foi executado"
    
    # verifica se a pasta logs possui algum arquivo
    elif [[ -z "$(find ./logs -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
        echo "Não há registro de comandos executados"
  
    else 
        # o arquivo log run mais recente
        log_run=$(grep -l -i "run" $(ls -t ./logs/* 2>/dev/null) | head -n 1)

        if [[ -z "$log_run" ]]; then
            echo "Não há registro de execução"
        
        else 
            data_exec=$(date -r "$log_run" "+%d/%m/%Y às %H:%M:%S")
            echo "Data de execução: $data_exec"
        fi
    fi

    echo ""
    echo "================================================================"
    echo ""
    echo ""

}
info