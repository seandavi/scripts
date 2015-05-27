#!/usr/bin/env bash
# $1 is the input VCF file
# $2 is the output VCF file
# 
# NOTE: the ordering of the last two steps is important.  
#       Other step orderings are not important.

# Grab the important environment variables
source /data/ngs/scripts/annotation/setup.sh

# and the actual annotation, piped
java -Xmx1g -jar $SNPEFFHOME/SnpSift.jar  dbnsfp   -f 'aaref,aaalt,Uniprot_acc,Uniprot_id,Uniprot_aapos,Interpro_domain,cds_strand,refcodon,codonpos,fold-degenerate,Ancestral_allele,Ensembl_geneid,Ensembl_transcriptid,aapos,SIFT_score,Polyphen2_HDIV_pred,Polyphen2_HVAR_pred,LRT_score,LRT_pred,MutationTaster_score,MutationTaster_pred,MutationAssessor_score,MutationAssessor_pred,FATHMM_score,GERP++_NR,GERP++_RS,phyloP,29way_pi,29way_logOdds,LRT_Omega,UniSNP_ids,1000Gp1_AC,1000Gp1_AF,1000Gp1_AFR_AC,1000Gp1_AFR_AF,1000Gp1_EUR_AC,1000Gp1_EUR_AF,1000Gp1_AMR_AC,1000Gp1_AMR_AF,1000Gp1_ASN_AC,1000Gp1_ASN_AF,ESP6500_AA_AF,ESP6500_EA_AF' $DBNSFP $1 | \
java -Xmx1g -jar $SNPEFFHOME/SnpSift.jar  annotate    $COSMICVCF /dev/stdin | \
java -Xmx1g -jar $SNPEFFHOME/SnpSift.jar  annotate    $DBSNPVCF /dev/stdin | \
java -Xmx1g -jar $SNPEFFHOME/SnpSift.jar  annotate    $CLINVARVCF /dev/stdin | \
java -Xmx1g -jar $SNPEFFHOME/SnpSift.jar  gwasCat     $GWASCATALOG /dev/stdin | \
java -Xmx6g -jar $SNPEFFHOME/snpEff.jar -sequenceOntolgy -hgvs -c $SNPEFFHOME/snpEff.config $SNPEFFGENOME > $2
