#!/bin/bash

# Aqui jaz o código principal para o funcionamento do programa.

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
        ./cbuild_funcs/build.sh "$2" "$3"
        ./cbuild_funcs/logs.sh "Build" $? "$comando_user"
        ;;
    "clean" | "Clean" | "c" )
        ./cbuild_funcs/clean.sh "$2"
        ./cbuild_funcs/logs.sh "Clean" $? "$comando_user"
        ;; 
    "run" | "Run" | "r")
        ./cbuild_funcs/run.sh
        ./cbuild_funcs/logs.sh "Run" $? "$comando_user"
        ;;
    "rb" | "rebuild" | "Rebuild" | "ReBuild")
        ./cbuild_funcs/rebuild.sh "$2" "$3"
        ./cbuild_funcs/logs.sh "Rebuild" $? "$comando_user"
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
