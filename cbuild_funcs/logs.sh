#!/bin/bash

# aqui jaz a função de criação de logs

mkdir -p ./logs

logdir=./logs

data_atual=$(date '+%Y-%m-%d')
hora_atual=$(date '+%H-%M-%S')
hora_atual_format=$(date '+%H:%M:%S')

logfile=cbuild_${data_atual}_${hora_atual}.log
touch "$logdir/$logfile"

if [[ $2 -eq 0 ]]; then
    status="Operação Bem-Sucedida"
else
    status="Operação Mal-Sucedida"
fi

{
echo "" 
echo "============================================================="
echo "Data de criação deste log: ${data_atual}"
echo "Hora de criação deste log: ${hora_atual_format}"
echo "============================================================="
echo ""
echo "*************************************************************"
echo ""
echo "Comando executado: '$1'"
echo ""
echo "Resultado da Operação: '$status'"
echo ""
echo "Comando Digitado pelo Usuário: '$3'"
echo ""
echo "Tempo de Execução do Comando $1: '$4'"
echo ""
echo "*************************************************************"
echo ""
} >> $logdir/$logfile

{
echo "Retorno do Comando $1:"
echo ""
shopt -s nullglob # evita que o cat envie a path como texto para o log
cat "$command_log_dir"/* < /dev/null # lê e armazena no log todos os textos dos erros nos comandos
echo ""
} >> $logdir/$logfile

#elif [[ "$1" == "Clean" ]]; then
    #{
   # echo "Retorno do Comando Clean:"
    #echo ""
    #shopt -s nullglob # evita que o cat envie a path como texto para o log
    #cat "$command_log_dir"/* < /dev/null # lê e armazena no log todos os textos dos erros nos comandos
    #echo ""
    #} >> $logdir/$logfile
#fi