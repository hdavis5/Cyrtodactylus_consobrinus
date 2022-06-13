#!/bin/sh
 plink --vcf ./central_group.recode.vcf --geno 0.999 --allow-extra-chr --set-missing-var-ids @:# --make-bed  -out plink
# if a line5, abort trap: 6 error appears OR if results are blank noting that errors were disable do the following:
 awk '{$1=0;print $0}' plink.bim > plink.bim.tmp
 mv plink.bim.tmp plink.bim
# however make sure file name matches name of .bed file
for j in {1..10}; do
	mkdir run$j
	cd run$j
  		for k in {1..10}; do
    	admixture ~/Desktop/consobrinus_malayanus/rad_data/consobrinus_outfiles/admixture_central/plink.bed --seed=$RANDOM --cv -C 0.0000001 $k >results$k.txt
    	done
    grep "CV error" results*.txt >> ./CVerror.txt
    cd ../
done

# After being done, there will be multiple independent files. To concatenate the CVerror.txt file to compare support do this:
# find ./run* -type f -name 'CVerror.txt' -exec cat {} + >mergedfile.txt
# then to prepare the file for excel to get a graph of the support values, isolate each of the run numbers
# using grep in word processor ^results<number>.*$