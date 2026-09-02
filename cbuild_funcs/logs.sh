#!/bin/bash

# aqui jaz a função de criação de logs

logdir=./logs

if [[ ! -d $logdir ]]; then
    mkdir logs
fi

data_atual=$(date '+%Y-%m-%d')
hora_atual=$(date '+%H-%M-%S')
hora_atual_format=$(date '+%H:%M:%S')

cd logs
logfile=cbuild_${data_atual}_${hora_atual}.log
touch $logfile
echo "Data de crição deste log: ${data_atual}" >> ./$logfile
echo "Hora de crição deste log: ${hora_atual_format}" >> ./$logfile

echo "Estado da Compilação: $1" >> ./$logfile
