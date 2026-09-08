#!/bin/bash

# aqui jaz a função build simples (pois ainda compila tudo e não apenas o que foi modificado) que compila o programa em c

# --- Error handling e logs ---

error_text=$(mktemp) # variavel temporaria de erro (o clean vai precisar limpar ela caso exista)

logs_func=$(find "./" -type f -name "logs.sh")

# --- função para procurar os arquivos modificados ---

deep_compiler() {

    local file

    while IFS= read -r file; do

        local formated_file=$(basename "$file" .c)

        if [[ ! -d "./build" ]]; then # se não tem a pasta build, cria a pasta build
            mkdir build
            mkdir ./build/build_parts
            gcc -c $file -o "./build/build_parts/${formated_file}.o" 2> "$error_text"; # compila os arquivos que o while IFS está passando e retorna erro caso dê errado

        elif [[ "$file" -nt "./build/build_parts/${formated_file}.o" ]]; then # vê se o arquivo de compilação já existe e, se sim, se o arquivo .c é mais novo que o arquivo de compilação para só compilar o que foi modificado.
                gcc -c $file -o "./build/build_parts/${formated_file}.o" 2> "$error_text";
        else
            return 3 # devolve o erro 3 para error handling caso não encontre nenhum arquivo que deve ser compilado

        fi

    done

    out_files=$(find "./build/build_parts" -type f -iname "*.o" | xargs -n 1 | tr '\n' ' ') # procura todos os arquivos .o que acabou de compilar no while

    gcc $out_files -o "./build/$out_name.o" 2> "$error_text" # compila todos em um só output com o nome escolhido pelo usuário

}

# --- checando se o user passou as infos corretas para o funcionamento do cbuild ---

program_folder="$1"; # aqui vai o diretório que o user vai passar ./cbuild b <dir>
out_name="$2" # vai ser o nome que o user passar para o comando ./cbuild b <dir> <nome>

if [[ ! -d $program_folder ]]; then # checagem para ver se o dir passado pelo usuario existe
    ./$logs_func "Compilação mal-sucedida" <<< "Diretório '$program_folder' Não Encontrado!"
    echo "Erro na execução do comando build - Diretório '$program_folder' não encontrado!"
    exit 1
fi

if find "$program_folder" -type f -iname "*.c" | xargs -n 1 | deep_compiler; then # procura todos os arquivos .c na pasta do projeto informada pelo usuário e executa o compilador avançado caso encontre arquivos
    ./$logs_func "Compilação bem-sucedida" <<< "$out_name" # caso tudo funcione manda para o log o sucesso
    echo "Comando build executado com sucesso"
else

    if [[ "$?" -eq 3 ]]; then # checagem para ver se houve mudanças nos arquivos .c desde a ultima compilação
        ./$logs_func "Compilação mal-sucedida" <<< "Nenhuma Mudança Detectada Nos Arquivos .c"
        echo "Erro na execução do comando build - Nenhuma mudança detectada nos arquivos .c"
        exit 1
    else
        ./$logs_func "Compilação mal-sucedida" < "$error_text" # caso contrário é um erro desconhecido que vai estar catalogado nos logs
        echo "Erro desconhecido na execução do comando build"
        exit 1
    fi
fi

# -----------------------------