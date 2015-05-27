#!/bin/bash
I=$1
O=$2
module load VEP/77
module load tabix # needed for numerous plugins
CADD_DIR=/data/CCRBioinfo/public/CADD
EXAC_DIR=/fdb/exac/release0.3
CACHE_DIR=/fdb/VEP/77/cache
variant_effect_predictor.pl -i ${I} --offline --cache \
  --dir_cache ${CACHE_DIR} --fasta /fdb/VEP/77/cache/human.fa \
  --output ${O} --sift s --polyphen s --vcf --canonical \
  --symbol --biotype --hgvs --assembly GRCh37 --per_gene --gmaf \
  --check_existing --pubmed --fork 8 --buffer_size 100000 --force_overwrite \
  --maf_1kg --maf_esp --regulatory --domains --numbers \
  --uniprot \
  --plugin CADD,${CADD_DIR}/whole_genome_SNVs.tsv.gz \
  --plugin ExAC,${EXAC_DIR}/ExAC.r0.3.sites.vep.vcf.gz \
  --plugin CSN,1 \
  --plugin Carol