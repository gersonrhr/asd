#!/bin/bash

# Separar la lectura de la lista y la ejecución
lista_dominios="wordlist"
dominios=$(cat $lista_dominios)

forfuzz=$1

# Usar xargs para manejar espacios en blanco
parallel -j 10 "telnet $forfuzz 443 >> result/{}" ::: $dominios &
parallel -j 10 "telnet $forfuzz 80 >> result/{}" ::: $dominios

find result -size 0 -delete
