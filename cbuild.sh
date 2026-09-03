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
  echo "run [r] - Roda seu programa .c a partir do arquivo compilado no comando build"
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
    "run" | "Run" | "r")
        echo "teste entrou no run"
        ;;
    "info" | "Info" | "i")
        echo "teste entrou no info"
        ;;
    "")
        echo "casoteste"
        ;;
    *)
        echo "Comando Desconhecido"
        ;;
esac

# acima temos os cases para cada parâmetro colocado pelo usuário, por exemplo, ./cbuild b entra na case de build do programa