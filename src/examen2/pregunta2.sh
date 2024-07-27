#!/usr/bin/bash

# PREGUNTA 2. GOs ASOCIADOS A LOS GENES DE LA BANDA q11.2
## Escrito por Gabriel Ramirez Vilchis

# CONSIDERACIONES
## Este script esta disenado para ejecutarse desde un directorio de trabajo que contiene una carpeta data/
## La carpeta data/ debe contener los archivos genes-arrays.txt y genes-go.txt
## El script toma algunos segundos en terminar su ejecucion

# GENERAR EL ARCHIVO
## La variable GENES almacena los genes de la banda q11.2 reportados en el archivo genes-go.txt
### Si la columna 5 de genes-go.txt que contiene la banda cariotipica q11.2 se imprime el identificador del gene
### Se ordenan los identificadores de los genes y se eliminan las repeticiones
GENES=$(awk -F "\t" '$5 == "q11.2" {print $1}' data/genes-go.txt | sort -u)

## Contar los GOs para cada gen reportado en el archivo gene-go.txt
### Para esto se considera que hay un GO por renglon en cada gene
for GENE in ${GENES[@]}; do
	### La variable GOS_COUNT almacena el conteo de los GOs en el gen actual
	#### Se cuentan los renglones que estan relacionados al gene actual y que tienen un GO registrado
	GOS_COUNT=$(awk -F "\t" -v GENE="$GENE" 'BEGIN{ count = 0 }; $1 == GENE &&  $3 {count++}; END{ print count };' data/genes-go.txt)
	### La variable GOS almacena cada uno de los GOs asociados al gen actual seguidos del caracter '|'
	GOS=$(awk -F "\t" -v GENE="$GENE" '$1 == GENE && $3 {print $3 "|"}' data/genes-go.txt)
	#### Eliminar los espacios que existen despues de cada '|' en el listado de GOs asociados al gene actual
	GOS=$(echo $GOS | sed -e 's/| /|/g')
	### Imprimir el gene, el conteo de GOs y el listado de GOs en tres columnas separadas por tabuladores
	echo -e $GENE '\t' $GOS_COUNT '\t' $GOS
### Redirigir el standard output al archivo result2_genes_gos.txt
done > result2_genes_gos.txt


# PREGUNTA 2.1
## La variable MORE_GOS almacena el identificador del gene con mas GOs asociados
### Ordenar el archivo creado con base en el conteo de GOs de mayor a menor
### Conservar solo los identificadores
### Conservar solo el identificador del gene con mas GOs asociados
MORE_GOS=$(sort -k2 -nr result2_genes_gos.txt | cut -f1 | head -n 1)

## Imprimir el identificador del gene con mas GOs asociados precedido de un mensaje informativo al usuario
echo "Gene de la banda q11.2 con mas GOs asociados:" $MORE_GOS

## La variable GOS_MORE_GOS almacena la cantidad de GOs asociados al gene con mas GOs asociados
### Ordenar el archivo creado con base en el conteo de GOs de mayor a menor
### Conservar solo los conteos de GOs
### Conservar solo el conteo del gene con mas GOs asociados
GOS_MORE_GOS=$(sort -k2 -nr result2_genes_gos.txt | cut -f2 | head -n 1)

## Imprimir el conteo del gene con mas GOs asociados precedido de un mensaje informativo al usuario
echo -e '\t' "Cantidad de GOs de" $MORE_GOS ":" $GOS_MORE_GOS


# PREGUNTA 2.2
## La variable GOS_COUNT_IN_SPECIFIC_GENE almacena el conteo de los GOs asociados al gene ENSG00000168234
### Conservar solo la linea del archivo creado que hace referencia al gene ENSG00000168234
### Conservar solo el conteo de GOs asociados al gene ENSG00000168234
GOS_COUNT_IN_SPECIFIC_GENE=$(grep "ENSG00000168234" result2_genes_gos.txt | cut -f2)

## Imprimir el conteo de GOs asociados al gene ENSG00000168234 precedido de un mensaje informativo al usuario
echo "Cantidad de GOs asociados al gene ENSG00000168234:" $GOS_COUNT_IN_SPECIFIC_GENE


# PREGUNTA 2.3
## La variable GOS_IN_SPECIFIC_GENE almacena el listado de los GOs asociados al gene ENSG00000168234
### Conservar solo la linea del archivo creado que hace referencia al gene ENSG00000168234
### Conservar solo el listado de GOs asociados al gene ENSG00000168234
GOS_IN_SPECIFIC_GENE=$(grep "ENSG00000168234" result2_genes_gos.txt | cut -f3)

## Imprimir el listado de los GOs asociados al gene ENSG00000168234 precedido de un mensaje informativo al usuario
echo "Los" $GOS_COUNT_IN_SPECIFIC_GENE "GOs que se encuentran en el gene ENSG00000168234 son:" $GOS_IN_SPECIFIC_GENE


# INFORMACION ADICIONAL
## Imprimir un mensaje informativo al usuario para que consulte el archivo generado al ejecutar este script
echo -e '\n' "Para ver la lista de genes de la banda q11.2 junto con el conteo y listado de sus GOs asociados, visualice el archivo result2_genes_gos.txt" '\n'
