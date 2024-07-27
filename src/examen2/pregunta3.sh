#!/bin/bash

# PREGUNTA 3. GOs, GENES Y BANDAS CARIOTIPICAS
## Escrito por Gabriel Ramirez Vilchis

# CONSIDERACIONES
## Este script esta disenado para ejecutarse desde un directorio de trabajo que contiene una carpeta data/
## La carpeta data/ debe contener los archivos genes-arrays.txt y genes-go.txt
## El script toma algunos segundos en terminar su ejecucion
## Por las caracteristicas propias de genes-go.txt, cada GO aparece solo una vez por gene


# GENERAR EL ARCHIVO
## La variable GOS almacena el listado de GOs asociados a genes en la banda q22.1
### Imprimir los GO term accession del archivo genes-go.txt solo si se encuentran en la banda q22.1
### Ordenar y eliminar las repeticiones
GOS=$(awk -F "\t" '$5 == "q22.1" {print $6}' data/genes-go.txt | sort -u)

## Contar y enlistar los genes y bandas relacionadas para cada GO asociado a genes en la banda q22.1
for GO in ${GOS[@]}; do
	### La variable GENE_COUNT almacena el conteo de los genes a los que esta asociado el GO actual
	#### Inicializar el conteo en 0
	#### Contar los renglones del archivo genes-go.txt que correspondan al GO actual, considerando que cada GO aparece solo una vez por gene
	#### Imprimir el conteo
	GENE_COUNT=$(awk -F "\t" -v GO="$GO" 'BEGIN{ count = 0 }; $6 == GO {count++}; END{ print count };' data/genes-go.txt)
	### La variable GENES almacena el listado de genes a los que esta asociado el GO actual
	#### Imprimir el identificador del gene seguido del caracter ',' si tiene asociado al gene actual (columna 6 de genes-go.txt)
	GENES=$(awk -F "\t" -v GO="$GO" '$6 == GO {print $1 ","}' data/genes-go.txt)
	#### Eliminar los espacios que existen despues de cada ','
	GENES=$(echo $GENES | sed -e 's/, /,/g')
	### La variable BAND_COUNT almacena el conteo de las bandas que contienen genes asociados al GO actual
	#### Conservar solo las columnas que contienen la banda citogenetica y el GO term accession del archivo genes-go.txt
	#### Ordenar y eliminar las repeticiones
	#### Inicializar el conteo en 0
	#### Contar las lineas que corresponden al GO actual
	#### Imprimir el conteo
	BAND_COUNT=$(cut -f5,6 data/genes-go.txt | sort -u | awk -F "\t" -v GO="$GO" 'BEGIN{ count = 0 }; $2 == GO {count++}; END{ print count };')
	### La variable BANDS almacena el listado de las bandas citogeneticas que contienen genes asociados al GO actual
	#### Conservar solo las columnas que contienen la banda citogenetica y el GO term accession del archivo genes-go.txt
        #### Ordenar y eliminar las repeticiones
	#### Imprimir el nombre de la banda citogenetica seguido del caracter '|' si esta relacionado con el GO actual
	BANDS=$(cut -f5,6 data/genes-go.txt | sort -u | awk -F "\t" -v GO="$GO" '$2 == GO {print $1 "|"}')
	#### Eliminar los espacios que existen despues de cada '|'
	BANDS=$(echo $BANDS | sed -e 's/| /|/g')
	### Imprimir el GO term accession, el conteo de genes, el listado de genes, el conteo de bandas y el listado de bandas separados por tabuladores
	echo -e $GO '\t' $GENE_COUNT '\t' $GENES '\t' $BAND_COUNT '\t' $BANDS
## Redirigir el standard output al archivo result3_gos_genes_bands.txt
done > result3_gos_genes_bands.txt 


# PREGUNTA 3.1
## La variable MOST_GENES almacena el GO term accession del GO con mas genes asociados
### Ordenar el archivo creado de mayor a menor con base en el conteo de genes
### Conservar solo el GO con mas genes asociados
### Conservar solo el GO term accession
MOST_GENES=$(sort -k2 -nr result3_gos_genes_bands.txt | head -n 1 | cut -f1)

## Imprimir a pantalla el GO term accession del GO con mas genes asociados, precedido de un mensaje informativo al usuario
echo "GO con mas genes:" $MOST_GENES


# PREGUNTA 3.2
## La variable WHICH_GENES almacena el listado de genes asociados al GO con mas genes asociados
### Ordenar el archivo creado de mayor a menor con base en el conteo de genes
### Conservar solo el GO con mas genes asociados
### Conservar solo el listado de genes
WHICH_GENES=$(sort -k2 -nr result3_gos_genes_bands.txt | head -n 1 | cut -f3)

## Imprimir a pantalla el listado de genes asociados al GO con mas genes asociados, precedido de un mensaje informativo al usuario
echo "   Genes asociados a" $MOST_GENES ":" $WHICH_GENES


# PREGUNTA 3.3
## La variable MOST_BANDS almacena el GO term accession del GO con genes en un mayor numero de bandas
### Ordenar el archivo creado de mayor a menor con base en el conteo de bandas
### Conservar solo los GO con genes en mas bandas
### Conservar solo el GO term accession
### Cambiar los saltos de linea por comas, por legibilidad
MOST_BANDS=$(sort -k4 -nr result3_gos_genes_bands.txt | head -n 5 | cut -f1 | tr '\n' ',')

## Imprimir a pantalla el GO term accession del GO con genes en un mayor numero de bandas, precedido de un mensaje informativo al usuario
echo -e '\n' "GOs con genes en un mayor numero de bandas:" $MOST_BANDS


# Pregunta 3.4
## Imprimir un mensaje informativo al usuario
echo "   Bandas con genes relacionados con los GOs mencionados anteriormente:"

## Imprimir los listados de bandas
### Ordenar el archivo creado de mayor a menor con base en el conteo de bandas
### Conservar solo los GO con genes en mas bandas
### Conservar solo los listados de bandas precedidos por el GO term accession, por legibilidad
sort -k4 -nr result3_gos_genes_bands.txt | head -n 5 | cut -f1,5


# INFORMACION ADICIONAL
## Imprimir un mensaje informativo al usuario para que consulte el archivo generado al ejecutar este script
echo -e '\n' "Para mas informacion, visualice el archivo result3_gos_genes_bands.txt" '\n'
