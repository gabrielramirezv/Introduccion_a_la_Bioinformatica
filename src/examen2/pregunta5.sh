#!/bin/bash

# PREGUNTA 5. MICROARREGLOS, GOS Y FUNCIONES
## Escrito por Gabriel Ramirez Vilchis

# CONSIDERACIONES
## Este script esta disenado para ejecutarse desde un directorio de trabajo que contiene una carpeta data/
## La carpeta data/ debe contener los archivos genes-arrays.txt y genes-go.txt
## El script toma algunos segundos en terminar su ejecucion
## Se consideraron como funciones las mencionadas como GO term name


## La variable AFFY_GENES almacena el listado de genes que hay en el archivo genes-array.txt para el arreglo Affy
### Eliminar encabezados
### Imprimir identificador del gene si se encuentra en una sonda del arreglo Affy
### Ordenar y eliminar repeticiones
AFFY_GENES=$(tail -n +2 data/genes-arrays.txt | awk -F "\t" '$2 {print $1}' | sort -u)

## La variable ILLUMINA_GENES almacena el listado de genes que hay en el archivo genes-array.txt para el arreglo Illumina
### Eliminar encabezados
### Imprimir identificador del gene si se encuentra en una sonda del arreglo Illumina
### Ordenar y eliminar repeticiones
ILLUMINA_GENES=$(tail -n +2 data/genes-arrays.txt | awk -F "\t" '$3 {print $1}' | sort -u)


# PREGUNTA 5.1
## Para cada gen en el arreglo Affy
### Buscar el gen actual en el archivo genes-go.txt e imprimir sus funciones (GO term name)
### Redirigir el standard output a un archivo
for AFFY_GENE in ${AFFY_GENES[@]}; do
	awk -F "\t" -v AFFY_GENE="$AFFY_GENE" '$1 == AFFY_GENE && $3 {print $3}' data/genes-go.txt >> goname_affy.txt
done

## La variable FUNCTIONS_AFFY almacena la cantidad de funciones cubiertas en el microarreglo Affy
### Ordenar y eliminar repeticiones en el ultimo archivo generado
### Contar las funciones
FUNCTIONS_AFFY=$(sort -u goname_affy.txt | wc -l)

## Imprimir el conteo de funciones cubiertas en el microarreglo Affy precedido de un mensaje informativo al usuario
echo "Cantidad de funciones (GO term name) en microarreglo Affy:" $FUNCTIONS_AFFY

## Para cada gen en el arreglo Illumina
### Buscar el gen actual en el archivo genes-go.txt e imprimir sus funciones (GO term name)
### Redirigir el standard output a un archivo
for ILLUMINA_GENE in ${ILLUMINA_GENES[@]}; do
	awk -F "\t" -v ILLUMINA_GENE="$ILLUMINA_GENE" '$1 == ILLUMINA_GENE && $3 {print $3}' data/genes-go.txt >> goname_illumina.txt
done

## La variable FUNCTIONS_ILLUMINA almacena la cantidad de funciones cubiertas en el microarreglo Illumina
### Ordenar y eliminar repeticiones en el ultimo archivo generado
### Contar las funciones
FUNCTIONS_ILLUMINA=$(sort -u goname_illumina.txt | wc -l)

## Imprimir el conteo de funciones cubiertas en el microarreglo Illumina precedido de un mensaje informativo al usuario
echo "Cantidad de funciones (Go term name) en microarreglo Illumina:" $FUNCTIONS_ILLUMINA


# PREGUNTA 5.2
# La cantidad de GO names ya se consiguio con el procedimiento anterior
## Para cada gen en el arreglo Affy
### Buscar el gen actual en el archivo genes-go.txt e imprimir sus GO term accession
### Redirigir el standard output a un archivo
for AFFY_GENE in ${AFFY_GENES[@]}; do
	awk -F "\t" -v AFFY_GENE="$AFFY_GENE" '$1 == AFFY_GENE && $6 {print $6}' data/genes-go.txt >> goaccession_affy.txt
done

## La variable GOS_AFFY almacena la cantidad de GO term accession cubiertas en el microarreglo Affy
### Ordenar y eliminar repeticiones en el ultimo archivo generado
### Contar los GO term accession
GOS_AFFY=$(sort -u goaccession_affy.txt | wc -l)

## Imprimir el conteo de GO accession cubiertas en el microarreglo Affy precedido de un mensaje informativo al usuario
echo "GO accession asociados a genes en Affy:" $GOS_AFFY

## Para cada gen en el arreglo Illumina
### Buscar el gen actual en el archivo genes-go.txt e imprimir sus GO term accession
### Redirigir el standard output a un archivo
for ILLUMINA_GENE in ${ILLUMINA_GENES[@]}; do
        awk -F "\t" -v ILLUMINA_GENE="$ILLUMINA_GENE" '$1 == ILLUMINA_GENE && $6 {print $6}' data/genes-go.txt >> goaccession_illumina.txt
done

## La variable GOS_ILLUMINA almacena la cantidad de GO term accession cubiertas en el microarreglo Illumina
### Ordenar y eliminar repeticiones en el ultimo archivo generado
### Contar los GO term accession
GOS_ILLUMINA=$(sort -u goaccession_illumina.txt | wc -l)

## Imprimir el conteo de GO accession cubiertas en el microarreglo Illumina precedido de un mensaje informativo al usuario
echo "GO accession asociados a genes en Illumina:" $GOS_ILLUMINA


# Como dato adicional se contaron las combinaciones de GO name y GO accession
## Para cada gen en el arreglo Affy
### Buscar el gen actual en el archivo genes-go.txt e imprimir sus GO name y sus GO accession
### Redirigir el standard output a un archivo
for AFFY_GENE in ${AFFY_GENES[@]}; do
	awk -F "\t" -v AFFY_GENE="$AFFY_GENE" '$1 == AFFY_GENE && ($3 || $6)  {print $3,$6}' data/genes-go.txt >> gos_affy.txt
done

## La variable GOS_COMB_AFFY almacena la cantidad de combinaciones de GO name y GO accession cubiertas en el microarreglo Affy
### Ordenar y eliminar repeticiones en el ultimo archivo generado
### Contar las combinaciones
GOS_COMB_AFFY=$(sort -u gos_affy.txt | wc -l)

## Imprimir el conteo de combinaciones cubiertas en el microarreglo Affy precedido de un mensaje informativo al usuario
echo "Combinaciones de GO name y GO accession asociadas a genes en Affy:" $GOS_COMB_AFFY

## Para cada gen en el arreglo Illumina
### Buscar el gen actual en el archivo genes-go.txt e imprimir sus GO name y sus GO accession
### Redirigir el standard output a un archivo
for ILLUMINA_GENE in ${ILLUMINA_GENES[@]}; do
        awk -F "\t" -v ILLUMINA_GENE="$ILLUMINA_GENE" '$1 == ILLUMINA_GENE && ($3 || $6)  {print $3,$6}' data/genes-go.txt >> gos_illumina.txt
done

## La variable GOS_COMB_ILLUMINA almacena la cantidad de combinaciones de GO name y GO accession cubiertas en el microarreglo Illumina
### Ordenar y eliminar repeticiones en el ultimo archivo generado
### Contar las combinaciones
GOS_COMB_ILLUMINA=$(sort -u gos_illumina.txt | wc -l)

## Imprimir el conteo de combinaciones cubiertas en el microarreglo Illumina precedido de un mensaje informativo al usuario
echo "Combinaciones de GO name y GO accession asociadas a genes en Illumina:" $GOS_COMB_ILLUMINA


# DEPURACION
## Eliminar todos los archivos no solicitados generados en la ejecucion
rm go*.txt
