#!/bin/bash

# ----------------------------------------------------------------------------------------------------------------------------

# Olá, devs!
#
# Este é um código que tem a intenção de replicar um programa do Linux conhecido como banner, o qual transforma um texto em uma
# forma mais maneira e maior de si.
# Escreva como parâmetro o texto que desejar...

# ----------------------------------------------------------------------------------------------------------------------------

# Hello, devs!
#
# This code intends to replicate a linux program called banner, which tranforms a given text into cooler and greater version.
# Insert as parameter a text of your desire...

# ----------------------------------------------------------------------------------------------------------------------------

print_letter() {
    case "$1" in
        A|a) echo -e "  #  \n # # \n#####\n#   #\n#   #" ;;
        B|b) echo -e "#### \n#   #\n#### \n#   #\n#### " ;;
        C|c) echo -e " ####\n#    \n#    \n#    \n ####" ;;
        D|d) echo -e "#### \n#   #\n#   #\n#   #\n#### " ;;
        E|e) echo -e "#####\n#    \n#### \n#    \n#####" ;;
        F|f) echo -e "#####\n#    \n#### \n#    \n#    " ;;
        G|g) echo -e " ####\n#    \n#  ##\n#   #\n ####" ;;
        H|h) echo -e "#   #\n#   #\n#####\n#   #\n#   #" ;;
        I|i) echo -e "  #  \n  #  \n  #  \n  #  \n  #  " ;;
        J|j) echo -e "#####\n  #  \n  #  \n# #  \n ##  " ;;
        K|k) echo -e "#   #\n#  # \n###  \n#  # \n#   #" ;;
        L|l) echo -e "#    \n#    \n#    \n#    \n#####" ;;
        M|m) echo -e "#   #\n## ##\n# # #\n#   #\n#   #" ;;
        N|n) echo -e "#   #\n##  #\n# # #\n#  ##\n#   #" ;;
        O|o) echo -e " ### \n#   #\n#   #\n#   #\n ### " ;;
        P|p) echo -e "#### \n#   #\n#### \n#    \n#    " ;;
        Q|q) echo -e " ### \n#   #\n# # #\n#  # \n ## #" ;;
        R|r) echo -e "#### \n#   #\n#### \n#  # \n#   #" ;;
        S|s) echo -e " ####\n#    \n ### \n    #\n#### " ;;
        T|t) echo -e "#####\n  #  \n  #  \n  #  \n  #  " ;;
        U|u) echo -e "#   #\n#   #\n#   #\n#   #\n ### " ;;
        V|v) echo -e "#   #\n#   #\n#   #\n # # \n  #  " ;;
        W|w) echo -e "#   #\n#   #\n# # #\n## ##\n#   #" ;;
        X|x) echo -e "#   #\n # # \n  #  \n # # \n#   #" ;;
        Y|y) echo -e "#   #\n # # \n  #  \n  #  \n  #  " ;;
        Z|z) echo -e "#####\n   # \n  #  \n #   \n#####" ;;
        _) echo -e   "       \n       \n       \n       \n#######" ;;
        *) echo "    $1    " ;;
    esac
}

print_word() {
    local word="$1"
    local length="${#word}"
    local lines=()

    # Inicializa as linhas
    for ((i=0; i<5; i++)); do
        lines[i]=""
    done

    # Processa cada letra
    for ((i=0; i<length; i++)); do
        local letter="${word:i:1}"
        local letter_lines=$(print_letter "$letter")

        # Adiciona as linhas da letra às linhas da palavra
        local j=0
        while IFS= read -r line; do
            lines[j]+="  $line"
            ((j++))
        done <<< "$letter_lines"
    done

    # Imprime as linhas
    for line in "${lines[@]}"; do
        echo "$line"
    done
}

# Testa a função
for word in $@; do
    print_word "$word"
    echo
done
