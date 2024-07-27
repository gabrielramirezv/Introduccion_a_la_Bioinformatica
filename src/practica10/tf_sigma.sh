
#### Para cada uno de los TFs con evidencia fuerte obten todos los promotores
#### regulados y para cada promotor el factor sigma asociado
#Obtener los TFs con evidencia fuerte
#Para cada TF obtener los promotores
#Para cada promotor de un TF obtener el factor Sigma
#Imprimir TF promotor factorSigma (separados por tabuladores)


#TFS=$(awk -F "\t" '$8 == "Strong" { print $2}' data/TFSet.txt)
TFS=$(cut -f2,8 data/TFSet.txt | grep -v "#" | grep -i "strong" | cut -f1 | sort -u)
#echo $TFS

for TF in ${TFS[@]};do
	PROMOTERS=$(awk -F "\t" -v TF="$TF" '$2 == TF { print $12}' data/BindingSiteSet.txt)
#	echo $TF $PROMOTERS

	for PROM in ${PROMOTERS[@]};do
		SIGMA=$(awk -F "\t" -v PROM="$PROM" '$2 == PROM { print $5}' data/PromoterSet.txt)
		SIGMA=$(echo $SIGMA | sed -e 's/ //g')
		echo $TF $PROM $SIGMA
	done
done
#awk -F "\t" '$2 == "AcrR" { print $12}' data/BindingSiteSet.txt


#awk -F "\t" '$2 == "marRp" { print $5}' data/PromoterSet.txt


