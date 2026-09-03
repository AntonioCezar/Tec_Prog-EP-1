#!/bin/bash

# aqui jaz a função de criação de logs

logdir=./logs

if [[ ! -d $logdir ]]; then
    mkdir logs
fi

data_atual=$(date '+%Y-%m-%d')
hora_atual=$(date '+%H-%M-%S')
hora_atual_format=$(date '+%H:%M:%S')

info_adicional=$(cat)

cd logs
logfile=cbuild_${data_atual}_${hora_atual}.log
touch $logfile
echo "" >> ./$logfile
echo "=============================================================" >> ./$logfile
echo "Data de crição deste log: ${data_atual}" >> ./$logfile
echo "Hora de crição deste log: ${hora_atual_format}" >> ./$logfile
echo "=============================================================" >> ./$logfile
echo "" >> ./$logfile
echo "Estado da Compilação: $1" >> ./$logfile
echo "" >> ./$logfile

if [[ $1 == "Compilação bem-sucedida" ]]; then
    echo "Arquivo de Compilação '$info_adicional' Adicionado na Pasta build" >> ./$logfile

elif [[ -n $texto_erro ]]; then
    echo "---------------" >> ./$logfile
    echo "Erro detectado:" >> ./$logfile
    echo "---------------" >> ./$logfile
    echo "" >> ./$logfile
    echo "$info_adicional" >> ./$logfile

else 
    echo "Sem Informações Adicionais" >> ./$logfile
fi
