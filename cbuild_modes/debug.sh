#!/bin/bash

# aqui jaz o script para ativar/desativar o modo debug.

# rafael aqui vc vai detectar se $1 = T, true, True... etc ou as variantes de false e ver se pode ativar e desativar a variavel $debug_mode. (ela é uma variável global logo basta colocar $debug_mode=true se quiser ligá-la e =false caso contário)

parametro="$1" # lê $1
ativou=false
case "$parametro" in
    "T" | "true" | "t" | "True")
        ativou=true 
        ;;
    "")
    "F" | "false" | "f" | "False")
        $debug_mode=false #desativa o modo debug
        exit 0
        ;;
    "")
        echo "digite T para ativar o modo debug e F para desativar" #verifica se $1 não existe
        exit 1
        ;;
    *)
        echo "esse comando não existe, digite um comando válido" #verifica se $1 é algo aleatório 
        exit 1
        ;;
esac



#ver se o modo verboso esté ativado e está tentando ativar o modo debug
if [[ $verbose_mode == "true" && $ativou == "true" ]]; then
    echo "desative o modo verboso para ativar o modo debug"
    exit 1
elif [[ $ativou = "true" ]]; then
    $verbose_mode=true
    exit 0
fi
