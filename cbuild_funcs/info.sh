#!/bin/bash

# aqui jaz a função info que mostra informações importantes sobre o cbuild e o programa do usuário

echo "--------------------------------------------"
echo "  Informações Adicionais Sobre Os Comandos  "
echo "--------------------------------------------"
echo ""
echo "Adicionar informações uteis para o uso do programa aqui"
echo ""
echo "********************************************"
echo ""
echo "====================================="
echo " Estatísticas sobre a execução atual "
echo "====================================="
echo ""
echo "aqui vai ter a quantidade de arquivos, linhas de código, tamanho do executável e datas da última 
compilação e execução. Quando uma informação ainda não existir, como a data de uma compilação que nunca ocorreu, a ferramenta deverá indicar explicitamente que o dado está indisponível. O critério utilizado para contabilizar linhas de código deverá ser definido pelo grupo e aplicado de forma consistente. O relatório deverá informar se linhas vazias, comentários, diretivas de pré-processamento e outros casos particulares são ou não contabilizados. "
echo ""

info() {
    # encontra e calcula a quatidade de arquivos do projeto 
    qtd_arquivos_proj=$(find . -type f \( -name "*.c" -o -name "*.h" \) | wc -l)
    echo "  Quantidade de arquivos do projeto: $qtd_arquivos_proj"

    # encontra todos os arquivos que terminam em .c e  .h e calcula a soma de todas as linhas de código presentes nesses arquivos, sem exceção
    qtd_linhas=$(find . -type f \( -name "*.c" -o -name "*.h" \) | xargs wc -l | tail -n 1 | awk '{print $1}')
    echo "  Quantidade absoluta de linhas de código: $qtd_linhas"

    # verifica se existe uma pasta build 
    if [[ ! -d "./build" ]]; then
        echo "Nenhum arquivo foi compilado"

    # verifica se a pasta build possui algum arquivo 
    elif [[ -z "$(find ./build -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
        echo "Não há arquivo compilado"

    else 
        # encontra o arquivo executavel na pasta build 
        executavel=$(find ./build -maxdepth 1 -type f -executable | head -n 1)
        tamanho_executavel=$(stat -c %s $executavel)
        data_compilacao=$(stat -c %y $executavel)

        echo "Tamanho do executável: $tamanho_executavel bytes"
        echo "Data de compilação: $data_compilacao"
        
     fi
}
info