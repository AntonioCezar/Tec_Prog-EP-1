#!/bin/bash

logdir=./Logs

if [[ -d $logdir ]]; then
    echo "Dir Já Existe"
else
    mkdir Logs
fi

data_atual=$(date '+%Y-%m-%d')
hora_atual=$(date '+%H-%M-%S')
hora_atual_format=$(date '+%H:%M:%S')

cd Logs
logfile=cbuild_${data_atual}_${hora_atual}.log
touch $logfile
echo "Data de crição deste log: ${data_atual}" >> ./$logfile
echo "Hora de crição deste log: ${hora_atual_format}" >> ./$logfile
