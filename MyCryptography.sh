#!/bin/bash

# ----------------------------------------------------------------------------------------------------------------------------

# Olá, devs!
#
# Este é um código inspirado na Criptografia Playfair de textos.
# Funciona da seguinte forma: 
#   - É dado como parâmetro na execução do script MyCryptography.sh em terminal o tal texto o qual se quer criptografar/descriptografar;
#   - Cada opção só pode ser usada uma vez, tal que para fazer um nova criptografia/descriptografia deve-se reiniciar o programa, caso o
#   contrário não obterá o resultado desejado.
#
# *) Restrições:
#   - O programa deve receber apenas textos com letras maiúsculas, e sem pontuações ou acentos.

# ----------------------------------------------------------------------------------------------------------------------------

# Hello, devs!
#
# This is a code inspired in text Playfair Cryptography.
# It works like that: 
#   - A parameter is given in the execution of MyCryptography.sh in terminal: the chosen text we want to encrypt/decrypt;
#   - Each option can just be used one time per program, in a way that, for you to make a new cryptography, the program must be restarted. 
#   On the contrary, you are going obtain wrong results.
#
# *) Restrictions:
#   - O programa deve receber apenas textos com letras maiúsculas, e sem pontuações ou acentos.
#   - The program must receive only uppercase letter texts, without any punctuation or accent.

# ----------------------------------------------------------------------------------------------------------------------------

# Matrizes-chave:

    # Caso 1
    matrizQuadrada=("LOPES"
                    "ABCDF"
                    "GHIKM"
                    "NQRTU"
                    "VWXYZ")
    # Caso 2
    #matrizQuadrada=("CODES" 
    #                "ABFGH"
    #                "IKLMN"
    #                "PQRTU"
    #                "VWXYZ")


function criptografiaPlayfair(){
    # 1. Construção da matriz com colunas no lugar de linhas:
    matrizDeLado=()

    num_colunas=${#matrizQuadrada[0]}

    for ((coluna = 0; coluna < num_colunas; coluna++)); do
        coluna_atual=$empty
        coluna_atual=()
        for linha in "${matrizQuadrada[@]}"; do
            letra="${linha:$coluna:1}"
            coluna_atual+="$letra"
        done
        matrizDeLado+=("${coluna_atual[*]}")
    done

    # 2. Transforma a frase em digramas:
    fraseDigramada=($(echo $@ | tr -d ' ' | iconv -f utf-8 -t ascii//TRANSLIT | sed 's/.\{2\}/& /g'))

    novafraseDigramada=()


    # 3. Avaliar cada digrama pelos três ifs do problema com base na matriz quadrada:
    for digrama in "${fraseDigramada[@]}"; 
    do
        digramaCheioFlag1=0
        digramaCheioFlag2=0

        letra1="${digrama:0:1}"
        letra2="${digrama:1:1}"

        linhaFlag=0
        colunaFlag=0

        for linha in "${matrizQuadrada[@]}"; do
            # Verifica se as letras 1 e 2 estão na mesma linha:
            if [[ "$linha" == *"$letra1"* && "$linha" == *"$letra2"* ]]; then
                linhaFlag=1
                linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada=$linha
            fi
        done

        for linha in "${matrizDeLado[@]}"; do
            # Verifica se as letras 1 e 2 estão na mesma linha:
            if [[ "$linha" == *"$letra1"* && "$linha" == *"$letra2"* ]]; then
                colunaFlag=1
                linhaDaMatrizDeLado=$linha
            fi
        done

        novoDigrama=$empty

        #   i. Se duas letras do digrama estiverem na mesma linha da matriz quadrada, troque cada uma pela letra à direita.
        #       Se não tiver nenhuma à direita, troque pela primeira letra da linha.
        if [[ $linhaFlag == 1 ]];
        then 

            for ((i = 0; i < ${#linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada}; i++)); 
            do
                if [[ "$letra1" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i:1}" ]];
                then
                    indexLetra1=$i

                    if [[ "$letra1" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:${#linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada}-1:1}" ]];
                    then
                        caraterePosterior1="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:0:1}"
                        novoDigrama+=$caraterePosterior1
                    else
                        caraterePosterior1="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i+1:1}"
                        novoDigrama+=$caraterePosterior1
                    fi
                fi

                if [[ "$letra2" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i:1}" ]];
                then
                    indexLetra2=$i

                    if [[ "$letra2" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:${#linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada}-1:1}" ]];
                    then
                        caraterePosterior2="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:0:1}"
                        novoDigrama+=$caraterePosterior2
                    else
                        caraterePosterior2="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i+1:1}"
                        novoDigrama+=$caraterePosterior2
                    fi
                fi
            done

            if [[ $indexLetra1 > $indexLetra2 ]];
            then 
                tmp=$(echo "$novoDigrama" | rev)
                novoDigrama=$tmp
            fi

            novaFraseDigramada+=($novoDigrama)

        
        #   ii. Se duas letras do digrama estiverem na mesma coluna da matriz quadrada, troque cada uma pela letra abaixo.
        #       Se não tiver nenhuma à abaixo, troque pela primeira letra da coluna.
        elif [[ $colunaFlag == 1  ]];
        then
            for ((i = 0; i < ${#linhaDaMatrizDeLado}; i++)); 
            do
                if [[ "$letra1" == "${linhaDaMatrizDeLado:$i:1}" ]];
                then
                    indexLetra1=$i

                    if [[ "$letra1" == "${linhaDaMatrizDeLado:${#linhaDaMatrizDeLado}-1:1}" ]];
                    then
                        caraterePosterior3="${linhaDaMatrizDeLado:0:1}"
                        novoDigrama+=$caraterePosterior3
                    else
                        caraterePosterior3="${linhaDaMatrizDeLado:$i+1:1}"
                        novoDigrama+=$caraterePosterior3
                    fi
                fi

                if [[ "$letra2" == "${linhaDaMatrizDeLado:$i:1}" ]];
                then
                    indexLetra2=$i

                    if [[ "$letra2" == "${linhaDaMatrizDeLado:${#linhaDaMatrizDeLado}-1:1}" ]];
                    then
                        caraterePosterior4="${linhaDaMatrizDeLado:0:1}"
                        novoDigrama+=$caraterePosterior4
                    else
                        caraterePosterior4="${linhaDaMatrizDeLado:$i+1:1}"
                        novoDigrama+=$caraterePosterior4
                    fi
                fi
            done

            if [[ $indexLetra1 > $indexLetra2 ]];
            then 
                tmp=$(echo "$novoDigrama" | rev)
                novoDigrama=$tmp
            fi

            novaFraseDigramada+=($novoDigrama)

        #   iii. Se os ifs i e ii forem falsos, crie uma matriz retangular menor, a partir da matriz quadrada, onde as letras do digrama formam dois dos vértices dos cantos.
        #       Para cada letra, substitua essa pela letra que está no final da mesma linha, isso na matriz retangular menor.
        elif [[ $colunaFlag == 0 && $linhaFlag == 0 ]];
        then
            for linha in "${matrizQuadrada[@]}"; do
                matriz_original+=("$(echo $linha | sed 's/.\{1\}/& /g')")
            done     

            matriz_unificada=()
            for linha in "${matriz_original[@]}"; do
                matriz_unificada+=($linha)
            done

            # Encontrando as posições dos elementos
            for ((i = 0; i < 5; i++)); do
                for ((j = 0; j < 5; j++)); do
                    index=$((i * 5 + j))
                    if [[ "${matriz_unificada[index]}" == "$letra1" ]]; then
                        linha1=$((i))
                        coluna1=$((j))
                    elif [[ "${matriz_unificada[index]}" == "$letra2" ]]; then
                        linha2=$((i))
                        coluna2=$((j))
                    fi
                done
            done

            # Determinando os índices mínimo e máximo das linhas e colunas
            linha_min=$((linha1 < linha2 ? linha1 : linha2))
            linha_max=$((linha1 > linha2 ? linha1 : linha2))
            coluna_min=$((coluna1 < coluna2 ? coluna1 : coluna2))
            coluna_max=$((coluna1 > coluna2 ? coluna1 : coluna2))

            # Calculando o tamanho da matriz menor
            linhas_menor=$((linha_max - linha_min + 1))
            colunas_menor=$((coluna_max - coluna_min + 1))

            # Criando a matriz menor
            tamMenor=0
            matriz_menor=()
            for ((i = linha_min; i <= linha_max; i++)); do
                for ((j = coluna_min; j <= coluna_max; j++)); do
                    index=$((i * 5 + j))
                    matriz_menor+=("${matriz_unificada[index]}")
                    let 'tamMenor++'
                done
            done

            for linha in "${matrizQuadrada[@]}"; do
                matriz_original2+=($(echo $linha | sed 's/.\{1\}/& /g'))
            done 

            for ((i = 0; i < linhas_menor; i++)); do
                for ((j = 0; j < colunas_menor; j++)); 
                do
                    index=$((i * colunas_menor + j))

                    # A . .
                    # . . .
                    # . . B
                    if [[ $letra1 == ${matriz_menor[0]} && $letra2 -eq ${matriz_menor[$tamMenor-1]} ]];
                    then
                        if [[ $i -eq 0 && $j -eq $(($colunas_menor-1)) ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                        if [[ $i -eq $(($linhas_menor-1)) && $j -eq 0 ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                    # . . A
                    # . . .
                    # B . .
                    elif [[ $letra1 == ${matriz_menor[ $(( 0 * colunas_menor + $(($colunas_menor-1)) )) ]} ]];
                    then
                        if [[ $i -eq 0 && $j -eq 0 ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi
                    
                        if [[ $i -eq $(($linhas_menor-1)) && $j -eq $(($colunas_menor-1)) ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi
                    
                    # B . .
                    # . . .
                    # . . A
                    elif [[ $letra2 == ${matriz_menor[0]} && $letra1 -eq ${matriz_menor[$tamMenor-1]} ]];
                    then
                        #break
                        if [[ $i -eq $(($linhas_menor-1)) && $j -eq 0 ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                        if [[ $i -eq 0 && $j -eq $(($colunas_menor-1)) ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                        if [[ ${#novoDigrama} -eq 2 && $digramaCheioFlag1 -eq 0 ]];
                        then
                            digramaCheioFlag1=1
                            tmp=$(echo "$novoDigrama" | rev)
                            novoDigrama=$tmp
                        fi   

                        # . . B
                        # . . .
                        # A . .
                        elif [[ $letra2 == ${matriz_menor[ $(( 0 * colunas_menor + $(($colunas_menor-1)) )) ]} ]];
                        then
                            if [[ $i -eq 0 && $j -eq 0 ]];
                            then
                                novoDigrama+="${matriz_menor[index]}"
                            fi
                        
                            if [[ $i -eq $(($linhas_menor-1)) && $j -eq $(($colunas_menor-1)) ]];
                            then
                                novoDigrama+="${matriz_menor[index]}"
                            fi 

                            if [[ ${#novoDigrama} -eq 2 && $digramaCheioFlag1 -eq 0 ]];
                            then
                                digramaCheioFlag2=1
                                tmp=$(echo "$novoDigrama" | rev)
                                novoDigrama=$tmp
                                
                            fi   
                    fi
                done
            done

            novaFraseDigramada+=($novoDigrama)
        fi
        
        #echo "--------------------------------------------------------------"

    done

    # Para imprimir o resultado desta função, faça: echo "Frase Criptografada = $(echo ${novaFraseDigramada[@]})".
}

function descriptografarPlayfair(){

    fraseCriptografada=($(echo $@ | tr -d ' ' | iconv -f utf-8 -t ascii//TRANSLIT | sed 's/.\{2\}/& /g'))

    for digrama in "${fraseCriptografada[@]}"; 
    do 

        digramaCheioFlag1=0
        digramaCheioFlag2=0

        letra1="${digrama:0:1}"
        letra2="${digrama:1:1}"
        
        linhaFlag=0
        colunaFlag=0

        for linha in "${matrizQuadrada[@]}"; do
            # Verifica se as letras 1 e 2 estão na mesma linha:
            if [[ "$linha" == *"$letra1"* && "$linha" == *"$letra2"* ]]; then
                linhaFlag=1
                linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada=$linha
            fi
        done

        for linha in "${matrizDeLado[@]}"; do
            # Verifica se as letras 1 e 2 estão na mesma linha:
            if [[ "$linha" == *"$letra1"* && "$linha" == *"$letra2"* ]]; then
                colunaFlag=1
                linhaDaMatrizDeLado=$linha
            fi
        done

        novoDigrama=$empty

        #   i. Se duas letras do digrama estiverem na mesma linha da matriz quadrada, troque cada uma pela letra à esquerda.
        #       Se não tiver nenhuma à esquerda, troque pela última letra da linha.
        if [[ $linhaFlag == 1 ]];
        then 
            for ((i = 0; i < ${#linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada}; i++)); 
            do
                if [[ "$letra1" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i:1}" ]];
                then
                    indexLetra1=$i

                    if [[ "$letra1" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:0:1}" ]];
                    then
                        caraterePosterior1="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:${#linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada}-1:1}"
                        novoDigrama+=$caraterePosterior1
                    else
                        caraterePosterior1="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i-1:1}"
                        novoDigrama+=$caraterePosterior1
                    fi
                fi

                if [[ "$letra2" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i:1}" ]];
                then
                    indexLetra2=$i

                    if [[ "$letra2" == "${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:0:1}" ]];
                    then
                        caraterePosterior2="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:${#linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada}-1:1}"
                        novoDigrama+=$caraterePosterior2
                    else
                        caraterePosterior2="${linhaDaMatrizOndeLetra1DoDigramaFoiEncontrada:$i-1:1}"
                        novoDigrama+=$caraterePosterior2
                    fi
                fi
            done

            if [[ $indexLetra1 > $indexLetra2 ]];
            then 
                tmp=$(echo "$novoDigrama" | rev)
                novoDigrama=$tmp
            fi

            FraseDescriptografada+=($novoDigrama)

        elif [[ $colunaFlag == 1  ]];
        then
            for ((i = 0; i < ${#linhaDaMatrizDeLado}; i++)); 
            do
                if [[ "$letra1" == "${linhaDaMatrizDeLado:$i:1}" ]];
                then
                    indexLetra1=$i

                    if [[ "$letra1" == "${linhaDaMatrizDeLado:0:1}" ]];
                    then
                        caraterePosterior3="${linhaDaMatrizDeLado:${#linhaDaMatrizDeLado}-1:1}"
                        novoDigrama+=$caraterePosterior3
                    else
                        caraterePosterior3="${linhaDaMatrizDeLado:$i-1:1}"
                        novoDigrama+=$caraterePosterior3
                    fi
                fi

                if [[ "$letra2" == "${linhaDaMatrizDeLado:$i:1}" ]];
                then
                    indexLetra2=$i

                    if [[ "$letra2" == "${linhaDaMatrizDeLado:0:1}" ]];
                    then
                        caraterePosterior4="${linhaDaMatrizDeLado:${#linhaDaMatrizDeLado}-1:1}"
                        novoDigrama+=$caraterePosterior4
                    else
                        caraterePosterior4="${linhaDaMatrizDeLado:$i-1:1}"
                        novoDigrama+=$caraterePosterior4
                    fi
                fi
            done

            if [[ $indexLetra1 > $indexLetra2 ]];
            then 
                tmp=$(echo "$novoDigrama" | rev)
                novoDigrama=$tmp
            fi

            FraseDescriptografada+=($novoDigrama)

        elif [[ $colunaFlag == 0 && $linhaFlag == 0 ]];
        then
            for linha in "${matrizQuadrada[@]}"; do
                matriz_original+=("$(echo $linha | sed 's/.\{1\}/& /g')")
            done     

            matriz_unificada=()
            for linha in "${matriz_original[@]}"; do
                matriz_unificada+=($linha)
            done

            # Encontrando as posições dos elementos
            for ((i = 0; i < 5; i++)); do
                for ((j = 0; j < 5; j++)); do
                    index=$((i * 5 + j))
                    if [[ "${matriz_unificada[index]}" == "$letra1" ]]; then
                        linha1=$((i))
                        coluna1=$((j))
                    elif [[ "${matriz_unificada[index]}" == "$letra2" ]]; then
                        linha2=$((i))
                        coluna2=$((j))
                    fi
                done
            done

            # Determinando os índices mínimo e máximo das linhas e colunas
            linha_min=$((linha1 < linha2 ? linha1 : linha2))
            linha_max=$((linha1 > linha2 ? linha1 : linha2))
            coluna_min=$((coluna1 < coluna2 ? coluna1 : coluna2))
            coluna_max=$((coluna1 > coluna2 ? coluna1 : coluna2))

            # Calculando o tamanho da matriz menor
            linhas_menor=$((linha_max - linha_min + 1))
            colunas_menor=$((coluna_max - coluna_min + 1))

            # Criando a matriz menor
            tamMenor=0
            matriz_menor=()
            for ((i = linha_min; i <= linha_max; i++)); do
                for ((j = coluna_min; j <= coluna_max; j++)); do
                    index=$((i * 5 + j))
                    matriz_menor+=("${matriz_unificada[index]}")
                    let 'tamMenor++'
                done
            done

            for linha in "${matrizQuadrada[@]}"; do
                matriz_original2+=($(echo $linha | sed 's/.\{1\}/& /g'))
            done 

            for ((i = 0; i < linhas_menor; i++)); do
                for ((j = 0; j < colunas_menor; j++)); 
                do
                    index=$((i * colunas_menor + j))

                    # A . .
                    # . . .
                    # . . B
                    if [[ $letra1 == ${matriz_menor[0]} && $letra2 -eq ${matriz_menor[$tamMenor-1]} ]];
                    then
                        if [[ $i -eq 0 && $j -eq $(($colunas_menor-1)) ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                        if [[ $i -eq $(($linhas_menor-1)) && $j -eq 0 ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                    # . . A
                    # . . .
                    # B . .
                    elif [[ $letra1 == ${matriz_menor[ $(( 0 * colunas_menor + $(($colunas_menor-1)) )) ]} ]];
                    then
                        if [[ $i -eq 0 && $j -eq 0 ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi
                    
                        if [[ $i -eq $(($linhas_menor-1)) && $j -eq $(($colunas_menor-1)) ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi
                    
                    # B . .
                    # . . .
                    # . . A
                    elif [[ $letra2 == ${matriz_menor[0]} && $letra1 -eq ${matriz_menor[$tamMenor-1]} ]];
                    then
                        if [[ $i -eq $(($linhas_menor-1)) && $j -eq 0 ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                        if [[ $i -eq 0 && $j -eq $(($colunas_menor-1)) ]];
                        then
                            novoDigrama+="${matriz_menor[index]}"
                        fi

                        if [[ ${#novoDigrama} -eq 2 && $digramaCheioFlag1 -eq 0 ]];
                        then
                            digramaCheioFlag1=1
                            tmp=$(echo "$novoDigrama" | rev)
                            novoDigrama=$tmp
                        fi   

                        # . . B
                        # . . .
                        # A . .
                        elif [[ $letra2 == ${matriz_menor[ $(( 0 * colunas_menor + $(($colunas_menor-1)) )) ]} ]];
                        then
                            if [[ $i -eq 0 && $j -eq 0 ]];
                            then
                                novoDigrama+="${matriz_menor[index]}"
                            fi
                        
                            if [[ $i -eq $(($linhas_menor-1)) && $j -eq $(($colunas_menor-1)) ]];
                            then
                                novoDigrama+="${matriz_menor[index]}"
                            fi 

                            if [[ ${#novoDigrama} -eq 2 && $digramaCheioFlag1 -eq 0 ]];
                            then
                                digramaCheioFlag2=1
                                tmp=$(echo "$novoDigrama" | rev)
                                novoDigrama=$tmp
                                
                            fi   
                    fi
                done
            done

            FraseDescriptografada+=($novoDigrama)

        fi

        

    done

    tmp="$(echo ${FraseDescriptografada[@]} | tr -d ' ')"

    novaFraseDescriptografada="$tmp"
}

# 1. Recebe a frase:
fraseSecreta=$@

# 4. Imprimir as frases:

echo "Escolha a opção desejada:"
echo "  1 - Exibir o texto inserido"
echo "  2 - Criptografar o texto"
echo "  3 - Descriptografar o texto"
echo "  4 - Sair"

read

while [ $REPLY -ne 4 ]; do
    case "$REPLY" in
        1)
            echo "Frase Original = $(echo $fraseSecreta)"
        ;;
        2)
            criptografiaPlayfair $fraseSecreta
            echo "Frase Criptografada = $(echo ${novaFraseDigramada[@]})"
        ;;
        3)
            descriptografarPlayfair $fraseSecreta
            echo "Frase Descriptografada = $(echo ${novaFraseDescriptografada[@]})"
        ;;
        *)
            #Nothing happens...
        ;;
    esac

    read
done