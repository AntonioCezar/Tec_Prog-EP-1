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
    # encontra todos os arquivos que terminam em .c e  .h e calcula a soma de todas as linhas de código presentes nesses arquivos
    find . -type f \( -name "*.c" -o -name "*.h" \) | xargs wc -l
}