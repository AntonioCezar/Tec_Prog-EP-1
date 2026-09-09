#!/bin/bash

# aqui jaz a função info que mostra informações importantes sobre o cbuild e o programa do usuário

info() {
    # encontra todos os arquivos que terminam em .c e  .h e calcula a soma de todas as linhas de código presentes nesses arquivos
    find . -type f \( -name "*.c" -o -name "*.h" \) | xargs wc -l
}

