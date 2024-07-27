#!/bin/bash

# PREGUNTA 4. MICROARREGLOS Y GENES
## Escrito por Gabriel Ramirez Vilchis

# CONSIDERACIONES
## Este script esta disenado para ejecutarse desde un directorio de trabajo que contiene una carpeta data/
## La carpeta data/ debe contener los archivos genes-arrays.txt y genes-go.txt
## El script toma algunos segundos en terminar su ejecucion


## La variable AFFY_GENES almacena el conteo de los genes reportados en el microarreglo Affy
### Eliminar los encabezados de genes-arrays.txt
### Imprimir el identificador del gene si hay una sonda registrada en la columna del microarreglo Affy para ese gene
### Ordenar y eliminar repeticiones
### Contar los genes
AFFY_GENES=$(tail -n +2 data/genes-arrays.txt | awk -F "\t" '$2 {print $1}' | sort -u | wc -l)

## La variable ILLUMINA_GENES almacena el conteo de los genes reportados en el microarreglo Illumina
### Eliminar los encabezados de genes-arrays.txt
### Imprimir el identificador del gene si hay una sonda registrada en la columna del microarreglo Illumina para ese gene
### Ordenar y eliminar repeticiones
### Contar los genes
ILLUMINA_GENES=$(tail -n +2 data/genes-arrays.txt | awk -F "\t" '$3 {print $1}' | sort -u | wc -l)

## Imprimir la cantidad de genes en el microarreglo Affy precedida de un mensaje informativo al usuario
echo "Cantidad de genes en el microarreglo Affy:" $AFFY_GENES

## Imprimir la cantidad de genes en el microarreglo Illumina precedida de un mensaje informativo al usuario
echo "Cantidad de genes en el microarreglo Illumina:" $ILLUMINA_GENES
