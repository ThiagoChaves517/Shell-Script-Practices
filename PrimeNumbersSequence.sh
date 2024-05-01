#!/bin/bash

# ----------------------------------------------------------------------------------------------------------------------------

# Olá, devs!
#
# Este é um código que imprime uma sequência de números primos de um certo mínimo até um certo máximo.
# Insira os valores das variáveis MIN e MAX como parâmetros para esse programa.

# ----------------------------------------------------------------------------------------------------------------------------

# Hello, devs!
#
# This code prints a sequence of prime numbers from certain minimum and to certain maximum.
# Insert the values of the MIN and MAX variables as parameters for this program.

# ----------------------------------------------------------------------------------------------------------------------------

MIN=$1
MAX=$2
COUNT=0

printf "+-------------------------------------------------------------------------------+\n" 

printf "|                               Numeros Primos                                  |\n" 

printf "+-------------------------------------------------------------------------------+\n" 

for((i=MIN+1; i<MAX; i++))
do

	primoFlag=1

	if [ "$i" -eq 2 -o "$i" -eq -2 ];
    then
		printf "%7d " "$i"
		let "COUNT++"
    fi

	let "t1 = i % 2"
    if [ "$t1" -ne 0 -a "$i" -ne 1 -a "$i" -ne -1 ];
        then
		for((j=3; j<i; j+=2))
		do
		let "t2 = i % j"
		if [ "$t2" -eq 0 ];
		then
			let "primoFlag = 0"
		fi
		done
	else
		let "primoFlag = 0"
	fi

	if [ "$primoFlag" -eq 1 ];
	then
		printf "%7d " "$i"
    	let "COUNT++"
        if [ "$COUNT" -eq 10 ];
        then
			echo ""
            let "COUNT = 0"
        fi
	fi
done

echo






