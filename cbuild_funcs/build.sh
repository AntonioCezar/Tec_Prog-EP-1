#!/bin/bash

# aqui jaz a função build completa

# da para usar as variáveis arq_mod e file_detec para mandar informações específicas para os logs ou o modo debug e verboso

# e se tiver mais de uma pasta com arquivos de mesmo nome?

# --- Error handling e logs ---

out_text=$(mktemp -p "$command_log_dir" 02_build.XXXXXX) # reserva espaço para uma variavel temporaria de erro dentro do diretório command_log_dir com o nome build e um padrão alfanumérico aleatório 

# --- função para procurar os arquivos modificados ---

deep_compiler() {

    local file
    local arq_mod=0
    local file_detec=0

    mkdir -p ./build/build_parts

    while IFS= read -r file; do # o IFS junto com o read -r deixam o texto passado para file da exata forma que ele foi passado para evitar erros

        if [[ ! -z $file ]]; then # se existe um file .c adiciona no contador
            file_detec=$((file_detec + 1))
        fi

        local formated_file=$(basename "$file" .c) # formata o nome do arquivo para procurar o correspondente .o

        if [[ "$file" -nt "./build/build_parts/${formated_file}.o" ]]; then # vê se o arquivo de compilação já existe e, se sim, se o arquivo .c é mais novo que o arquivo de compilação para só compilar o que foi modificado.
            gcc -c "$file" -o "./build/build_parts/${formated_file}.o" 2>> "$out_text" || return 2 # compila cada file em um arquivo.o, se der erro retorna 2
            arq_mod=$((arq_mod + 1))
        fi

    done

    if [[ $file_detec -eq 0 ]]; then # detecta se existem ou não files .c
        return 4
    fi

    if [[ $arq_mod -eq 0 && -f "./build/$out_name" ]]; then # detecta se não houve mudanças e se existe um arquivo de execução atual para o programa
        return 3
    fi

    out_files=$(find "./build/build_parts" -type f -iname "*.o" | xargs -n 1 | tr '\n' ' ') # procura todos os arquivos .o que acabou de compilar no while

    gcc $out_files -o "./build/$out_name" 2>> "$out_text" || return 2 # compila todos em um só output com o nome escolhido pelo usuário, se der erro retorna 2

}

# --- checando se o user passou as infos corretas para o funcionamento do cbuild ---

program_folder="$1"; # aqui vai o diretório que o user vai passar ./cbuild b <dir>
out_name="$2" # vai ser o nome que o user passar para o comando ./cbuild b <dir> <nome>

if [[ ! -d $program_folder ]]; then # checagem para ver se o dir passado pelo usuario existe
    echo "Diretório '$program_folder' Não Encontrado!" >> $out_text
    echo "Erro na execução do comando build - Diretório '$program_folder' não encontrado!"
    exit 1
fi

if [[ -z $out_name ]]; then # checagem para ver se o user passou o nome do executável
    echo "Nome Do Executável Não Especificado!" >> $out_text
    echo "Erro na execução do comando build - Nome do executável não especificado!"
    exit 1

elif [[ "$out_name" == *.* ]]; then # checagem para ver se nome que o user passou é válido
    echo "Nome Do Executável Não Pode Conter '.'" >> $out_text
    echo "Erro na execução do comando build - Nome do executável não pode conter '.'"
    exit 1
fi

if find "$program_folder" -type f -iname "*.c" | deep_compiler; then # procura todos os arquivos .c na pasta do projeto informada pelo usuário e executa o compilador avançado caso encontre arquivos
    echo "O executável '$out_name' foi criado com sucesso!" >> $out_text # caso tudo funcione manda para o log o sucesso
    echo "Comando build executado com sucesso"
    exit 0
else

    func_status="$?" # guarda o erro da função (se houver)

    if [[ "$func_status" -eq 2 ]]; then # erro na compilação do gcc
        echo "Erro na execução do comando build - Erro na compilação usando comando gcc, veja o log para mais informações"
        exit 1

    elif [[ "$func_status" -eq 3 ]]; then # checagem para ver se houve mudanças nos arquivos .c desde a ultima compilação
        echo "Nenhuma Mudança Detectada Nos Arquivos .c" >> $out_text
        echo "Erro na execução do comando build - Nenhuma mudança detectada nos arquivos .c"
        exit 1

    elif [[ "$func_status" -eq 4 ]]; then # checagem para ver se encontrou algum arquivo .c
        echo "Nenhum Arquivo .c Encontrado!" >> $out_text
        echo "Erro na execução do comando build - Nenhum arquivo .c encontrado!"
        exit 1

    else
        echo "Erro desconhecido na execução do comando build, veja o log para mais informações" # caso contrário é um erro desconhecido que vai estar catalogado nos logs
        exit 1
    fi
fi

# -----------------------------