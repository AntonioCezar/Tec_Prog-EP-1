#!/bin/bash

# aqui jaz o script para ativar/desativar o modo verboso.

# rafael aqui vc vai detectar se $1 = T, true, True... etc ou as variantes de false e ver se pode ativar e desativar a variavel $verbose_mode. (ela é uma variável global logo basta colocar $verbose_mode=true se quiser ligá-la e =false caso contário)

out_text=$(mktemp -p "$command_log_dir" 06_verbose.XXXXXX)

parametro="$1" # lê $1
ativou=false
case "$parametro" in
    "T" | "true" | "t" | "True")
        ativou=true 
        ;;
    "F" | "false" | "f" | "False")
        echo "modo verboso desativado" >> $out_text
        verbose_mode=false #desativa o modo verboso
        exit 0
        ;;
    "")
        echo "não foi digitado nenhum argumento" >> $out_text
        echo "digite T para ativar o modo verboso e F para desativar" #verifica se $1 não existe
        exit 1
        ;;
    *)
        echo "o comando digitado não existe" >> $out_text
        echo "esse comando não existe, digite um comando válido" #verifica se $1 é algo aleatório 
        exit 1
        ;;
esac



#ver se o modo debug esté ativado e está tentando ativar o modo verboso
if [[ $debug_mode == "true" && $ativou == "true" ]]; then
    read -p "você deseja desativar o modo debug para ativar o modo verboso?(s/n)" resposta
        case "$resposta" in
            "s" | "S" | "y" | "Y" | "sim" | "Sim" | "yes" | "Yes" )
                echo "modo verboso ativado e modo debug desativado" >> $out_text
                $debug_mode == "false" #desativa o modo debug
                $verbose_mode == "true" #ativa o modo verboso
                ;;
            "n" | "N" | "no" | "No" | "não" | "Não" | "nao" | "Nao" )
                echo "operação cancelada: o modo verboso não pode ser ativado junto com o debug" >> $out_text
                echo "operação cancelada: você não pode ativar o modo verboso com o modo debug ativado"
                exit 1
                ;;
            "")
                echo "não foi digitado nenhum argumento" >> $out_text
                echo "operação cancelada"
                exit 1
                ;;
            *)
                echo "o comando digitado não existe" >> $out_text
                echo "esse comando não existe, digite um comando válido" 
                exit 1
                ;;
    esac
elif [[ $ativou = "true" ]]; then
    echo "modo verboso ativado" >> $out_text
    verbose_mode=true
    exit 0
fi
