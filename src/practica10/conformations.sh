#! /usr/bin/bash

# La variable TF ti
TFS=$(grep -v "#" /home/gramirez/practica10/data/TFSet.txt | cut -f2)

for TF in ${TFS[@]};do
	EFFECTS=$(awk -F "\t" -v TF="$TF" '$1 == TF {print $3}' data/network_tf_gene.txt | sort -u)
	EFFECTS=$(echo $EFFECTS | sed -e 's/ /,/g')
	CONFORMATIONS=$(awk -F "\t" -v TF="$TF" '$2 == TF && $7 == "Active" {print $9}' data/Conformation_active_inactive_Set.txt | sort -u)
	CONFORMATIONS=$(echo $CONFORMATIONS | sed -e 's/ /,/g')
	echo -e $TF ';' $EFFECTS ';' $CONFORMATIONS

done > tf_effects_conformations.txt

cut -d ';' -f2,3 tf_effects_conformations.txt | tr ';' '\t' |  sort | uniq -c
