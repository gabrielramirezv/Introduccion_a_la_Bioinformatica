#!/bin/bash

TFS=$(grep -v "#" data/TFSet.txt | cut -f2 | sort -u)

for TF in ${TFS[@]};do
        EFFECTS=$(awk -F "\t" -v TF="$TF" '$1 == TF {print $2,3}' data/network_tf_gene.txt | sort -u)
        echo -e $TF '\t' $EFFECTS
done
