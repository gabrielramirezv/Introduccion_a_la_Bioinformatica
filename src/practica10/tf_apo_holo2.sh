#!/bin/bash

TFS=$(grep -v "#" data/TFSet.txt | cut -f2 | sort -u)

for TF in ${TFS[@]}; do
	EFFECT=$(awk -F "\t" -v TF="$TF" '$1 == TF {print $3}' data/network_tf_gene.txt | sort -u)
	CONFORMATION=$(awk -F "\t" -v TF="$TF" '$2 == TF && $7 == "Active" {print $9}' data/Conformation_active_inactive_Set.txt | sort -u)
	
	echo -e $TF '\t' $EFFECT '\t' $CONFORMATION


done > tf_conformations_effects.txt

cut -f2,3 tf_conformations_effects.txt | sort | uniq -c

