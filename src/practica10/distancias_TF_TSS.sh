#!/bin/bash

TFS=$(grep -v "#" data/TFSet.txt | cut -f2 | sort -u)

for TF in ${TFS[@]};do
        EFFECTS=$(awk -F "\t" -v TF="$TF" '$1 == TF {print $3}' data/network_tf_gene.txt | sort -u)
	for EFFECT in ${EFFECTS[@]};do
        	DISTANCE=$(awk -F "\t" -v TF="$TF" '$2 == TF {print $13}' data/BindingSiteSet.txt)
	done
done

echo -e $TF"\t"$EFFECT"\t"$DISTANCE
