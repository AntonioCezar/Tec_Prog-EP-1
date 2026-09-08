#!/bin/bash

# Aqui jaz o código principal para o funcionamento do programa.

if [[ "$#" -eq 0 ]]; then
  echo "#------------------------------------------------#"
  echo "  Seja bem-vindo ao cbuild, seu compilador de c!"
  echo "#------------------------------------------------#"
  echo ""
  echo "Para utilizar o cbuild selecione um dos nossos comandos:"
  echo ""
  echo "build [b] - Compila todas as mudanças detectadas do seu programa .c"
  echo "clean [c] - Limpa os artefatos da compilação"
  echo "clean all [c a] - Limpa os artefatos da compilação, incluindo os logs"
  echo "run [r] - Roda seu programa .c a partir do arquivo compilado no comando build"
  echo "rebuild [rb] - re-compila seu programa limpando todos os arquivos temp"
  echo "info [i] - Exibe algumas informações importantes sobre o seu programa"
  echo ""
  echo "Escreva: cbuild (comando) [opções] para executar os comandos desejados"
fi

# acima está a interface principal do programa que aparece quando ./cbuild é rodado

comando_executado="$1" # parâmetro colocado pelo usuário

case "$comando_executado" in
    "build" | "Build" | "b")
        ./cbuild_funcs/build.sh "$2" "$3"
        ;;
    "clean" | "Clean" | "c" )
        ./cbuild_funcs/clean.sh "$2"
        ;; 
    "run" | "Run" | "r")
        ./cbuild_funcs/run.sh
        ;;
    "rb" | "rebuild" | "Rebuild" | "ReBuild")
        ./cbuild_funcs/rebuild.sh "$2" "$3"
        ;;
    "info" | "Info" | "i")
        echo "teste entrou no info"
        ;;
    "")
        ;;
    *)
        echo "Comando Desconhecido"
        ;;
esac

# acima temos os cases para cada parâmetro colocado pelo usuário, por exemplo, ./cbuild b entra na case de build do programa