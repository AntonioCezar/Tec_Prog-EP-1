#!/bin/bash

# Aqui jaz o código principal para o funcionamento do programa.

#Deixa o runtime mais legível
get_runtime() 
{
    local runtime_ns=$1

    local all_sec=$(( runtime_ns / 1000000000 ))
    local milisec=$(( runtime_ns / 1000000 % 1000 ))

    local min=$(( all_sec / 60  ))
    local sec=$(( all_sec % 60 ))

    if [[ $min -gt 0 ]]; then
        printf "%dm%ds%03dms" "$min" "$sec" "$milisec"
    else
        printf "%ds%03dms" "$sec" "$milisec"
fi
}

#Executa os comandos e registra o runtime
run_with_timing()
{
    local log_label="$1"                                #Armazena o primeiro parâmetro. Exemplo: "Build", "Clean"
    shift                                               #"Pula apenas o primeiro parâmetro", por exemplo:                                   

    local start=$(date +%s%N)                           #Registra o início da execução
    "$@"                                                #Executa o parâmetro que sobrou como se fosse um comando

    local exit_code=$?
    local end=$(date +%s%N)                             #Registra o fim da execução

    local runtime_ns=$(( (end - start) ))               #Armazena o runtime
    local runtime=$(get_runtime "$runtime_ns")          #Formata o runtime

    ./cbuild_funcs/logs.sh "$log_label" "$exit_code" "$comando_user" "$runtime"

    return "$exit_code"
}

export -f get_runtime

export command_log_dir=$(mktemp -d) # cria uma pasta temporaria global para o resultado das execuções dos comandos

trap 'rm -rf "$command_log_dir"' EXIT # deleta a pasta temporaria de resultados dos comandos

if [[ "$#" -eq 0 ]]; then
    echo ""
    echo "#------------------------------------------------#"
    echo "  Seja bem-vindo ao cbuild, seu compilador de c!"
    echo "#------------------------------------------------#"
    echo ""
    echo "Para utilizar o cbuild selecione um dos nossos comandos:"
    echo ""
    echo "build [b] - Compila todas as mudanças detectadas do seu programa .c"
    echo "clean [c] - Limpa os artefatos da compilação"
    echo "clean [c] all - Limpa os artefatos da compilação, incluindo os logs"
    echo "run [r] - Roda seu programa .c a partir do arquivo compilado no comando build"
    echo "rebuild [rb] - re-compila seu programa limpando todos os arquivos temp"
    echo "info [i] - Exibe algumas informações importantes sobre o seu programa"
    echo ""
    echo "Escreva: cbuild (comando) [opções] para executar os comandos desejados"
    echo ""
fi

# acima está a interface principal do programa que aparece quando ./cbuild é rodado

comando_executado="$1" # parâmetro colocado pelo usuário

comando_user="$0 $*"

case "$comando_executado" in
    "build" | "Build" | "b")
        run_with_timing "Build" ./cbuild_funcs/build.sh "$2" "$3"
        ;;
    "clean" | "Clean" | "c" )
        run_with_timing "Clean" ./cbuild_funcs/clean.sh "$2"
        ;; 
    "run" | "Run" | "r")
        run_with_timing "Run" ./cbuild_funcs/run.sh
        ;;
    "rb" | "rebuild" | "Rebuild" | "ReBuild")
        run_with_timing "Rebuild" ./cbuild_funcs/rebuild.sh "$2" "$3"
        ;;
    "info" | "Info" | "i")
        echo "teste entrou no info"
        ./cbuild_funcs/info.sh
        ;;
    "")
        ;;
    *)
        echo "Comando Desconhecido"
        ;;
esac

# acima temos os cases para cada parâmetro colocado pelo usuário, por exemplo, ./cbuild b entra na case de build do programa
