#!/bin/bash
# This script is named: data-recall.sh
#SBATCH -t 72:00:00
#SBATCH -p archivelong
#SBATCH -N 1
#SBATCH -J recall_files
#SBATCH --mail-type=ALL

########################################################
# Submission script to recover data from the HPSS tape-archival system @ the Niagara SuperComputer
# Based on examples from
#       https://docs.scinet.utoronto.ca/index.php/HPSS#Scripted_File_Transfers
#
# Marcelo Ponce
########################################################

 
trap "echo 'Job script not completed';exit 129" TERM INT
mkdir -p $SCRATCH/recalled-from-hpss
 
# individual tarballs previously organized in HPSS inside the put-away-on-2010/ folder
hsi  -v << EOF
cget $SCRATCH/90-90_b-xi.tar : $ARCHIVE/TILTs/90-90_b-xi.tar
cget $SCRATCH/HR_90-m90_h-conduc.tar : $ARCHIVE/TILTs/HR_90-m90_h-conduc.tar
end
EOF
status=$?
 
trap - TERM INT
 
if [ ! $status == 0 ]; then
   echo 'HSI returned non-zero code.'
   /scinet/niagara/bin/exit2msg $status
   exit $status
else
   echo 'TRANSFER SUCCESSFUL'
fi
