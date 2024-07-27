#!/bin/bash

# PREGUNTA 1. GENES REPORTADOS
## Escrito por Gabriel Ramirez Vilchis

# CONSIDERACIONES
## Este script esta disenado para ejecutarse desde un directorio de trabajo que contiene una carpeta data/
## La carpeta data/ debe contener los archivos genes-arrays.txt y genes-go.txt
## El script toma algunos segundos en terminar su ejecucion


## La variable NUMBER_OF_GENES_IN_ARRAYS almacena el conteo de los genes reportados en el archivo genes-arrays.txt
### Eliminar los encabezados conservando el archivo a partir del segundo renglon
### Conservar solo la primera columna que contiene los identificadores de los genes
### Ordenar los identificadores y eliminar las repeticiones
### Contar los genes al hacer un conteo de las lineas
NUMBER_OF_GENES_IN_ARRAYS=$(tail -n +2 data/genes-arrays.txt | cut -f1 | sort -u | wc -l)

## Imprimir a pantalla el conteo de los genes en genes-arrays.txt precedido de un texto informativo al usuario
echo "Cantidad de genes reportados en el archivo data/genes-arrays.txt:" $NUMBER_OF_GENES_IN_ARRAYS

## La variable NUMBER_OF_GENES_IN_GO almacena el conteo de los genes reportados en el archivo genes-go.txt
### Eliminar los encabezados conservando el archivo a partir del segundo renglon
### Conservar solo la primera columna que contiene los identificadores de los genes
### Ordenar los identificadores y eliminar las repeticiones
### Contar los genes al hacer un conteo de las lineas
NUMBER_OF_GENES_IN_GO=$(tail -n +2 data/genes-go.txt | cut -f1 | sort -u | wc -l)

## Imprimir a pantalla el conteo de los genes en genes-go.txt precedido de un texto informativo al usuario
echo "Cantidad de genes reportados en el archivo data/genes-go.txt:" $NUMBER_OF_GENES_IN_GO


## La variable GENES_IN_ARRAYS almacena todos los identificadores de genes del archivo genes-arrays.txt (sin repeticiones)
### Eliminar los encabezados conservando el archivo a partir del segundo renglon
### Conservar solo la primera columna que contiene los identificadores de los genes
### Ordenar los identificadores y eliminar las repeticiones
GENES_IN_ARRAYS=$(tail -n +2 data/genes-arrays.txt | cut -f1 | sort -u)

## La variable GENES_IN_GO almacena todos los identificadores de genes del archivo genes-go.txt (sin repeticiones)
### Eliminar los encabezados conservando el archivo a partir del segundo renglon
### Conservar solo la primera columna que contiene los identificadores de los genes
### Ordenar los identificadores y eliminar las repeticiones
GENES_IN_GO=$(tail -n +2 data/genes-go.txt | cut -f1 | sort -u)


## Buscar para cada gen reportado en el archivo gene-arrays.txt si no existe en el archivo genes-go.txt
for GENE_ARRAYS in ${GENES_IN_ARRAYS[@]};do
	### La variable CONCORDANCES almacena el identificador ddel gen si tambien se encontro en el archivo genes-go.txt
	#### Buscar las lineas que contengan el identificador del gen actual
	#### Conservar solo la primera columna que contiene los identificadores
	#### Eliminar las repeticiones
	CONCORDANCES=$(grep "$GENE_ARRAYS" data/genes-go.txt | cut -f1 | sort -u)
	### Guardar el identificador del gen si es que se encontro en genes-go.txt
	echo $CONCORDANCES
## Redirigir el standard output a un archivo temporal llamado concordances.txt
done > concordances.txt


## La variable NUMBER_OF_CONCORDANCES almacena el conteo de las concordancias entre ambos archivos
### En este caso no es necesario ordenar y filtrar pero ayuda a que el conteo no aparezca seguido del nombre del archivo
### Contar las concordancias
NUMBER_OF_CONCORDANCES=$(sort -u concordances.txt | wc -l)

## Imprimir a pantalla el conteo de concordancias precedido de un texto informativo al usuario
### Si el numero de genes comunes en ambos archivos es igual a la cantidad de genes reportados en cada uno de los dos archivos
#### se deduce que todos los genes son los mismos en ambos archivos
### Si no es asi entonces no todos los genes son los mismos
echo "Numero de genes que son los mismos en ambos archivos:" $NUMBER_OF_CONCORDANCES
## Imprimir un mensaje al usuario sobre como interpretar los resultados
echo "Si el numero de concordancias es igual al numero de genes reportados en cada uno de los archivos, entonces todos los genes son los mismos en ambos archivos"

## Eliminar el archivo temporal concordances.txt porque ya cumplio su utilidad
rm concordances.txt
