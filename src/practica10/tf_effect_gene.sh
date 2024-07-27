#!/bin/bash

TFS=$(grep -v "#" data/TFSet.txt | cut -f2 | sort -u)

for TF in ${TFS[@]};do
	EFFECTS=$(awk -F "\t" -v TF="$TF" '$1 == TF {print $3}' data/network_tf_gene.txt | sort -u)
	COUNT=$(awk -F "\t" -v TF="$TF" '$1 == TF {print $3}' data/network_tf_gene.txt | sort | uniq  -c)
	for EFFECT in ${EFFECTS[@]};do
		GENES=$(awk -F "\t" -v EFFECT="$EFFECT" -v TF="$TF" '$3 == EFFECT && $1 == TF {print $2}' data/network_tf_gene.txt)
		echo -e $TF '\t' $EFFECT '\t' $GENES
	done
done
