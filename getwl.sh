#!/bin/bash

# Configuración de la base de datos
DB_HOST="47.242.232.124"
DB_PORT="5432"
DB_NAME="prog"
DB_USER="postgres"
DB_PASSWORD=" "
DB_TABLE="wc"


# Ejecutar el comando de inserción en la base de datos
obj=$(PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -AXqtc "select * from (SELECT wildcard, programa, tipo, ultimoscan, cantidaddescans FROM public.wc order by RANDOM() limit 100) a order by cantidaddescans limit 1")
echo $obj
PROGRAM=$(echo $obj | cut -d "|" -f 1)
WILDCARD=$(echo $obj | cut -d "|" -f 2)
REPEATS=$(echo $obj | cut -d "|" -f 5)

echo "Se analizará $WILDCARD del programa $PROGRAM, se ha revisado $REPEATS veces"

forfuzz=$(echo $WILDCARD | sed 's/\*/{}/g')

timeout 600 ./runsd.sh "$forfuzz"

find result -size 0 -delete

ls result/ >> R
rm result/*
echo "se encontro: $(cat R)"
