#!/bin/bash
# This script is named: data-offload.sh
#SBATCH -t 72:00:00
#SBATCH -p archivelong 
#SBATCH -N 1
#SBATCH -J offload
#SBATCH --mail-user=YOURemailHERE
#SBATCH --mail-type=ALL


########################################################
# Submission script to transfer data to the HPSS tape-archival system @ the Niagara SuperComputer
# Based on examples from
#       https://docs.scinet.utoronto.ca/index.php/HPSS#Scripted_File_Transfers
#
# Marcelo Ponce
########################################################

 
trap "echo 'Job script not completed';exit 129" TERM INT
# individual tarballs already exist


# Note that your initial directory in HPSS will be $ARCHIVE
ARCHIVE=/archive/PATHtoLOCATION/USERSPACE
#SOURCE=S_1ms1ms_100kms-a
# read source from command line as an argument passed to sbatch script
SOURCE=$1
DEST=$ARCHIVE/$2

echo "SOURCE: "$SOURCE "--" "DEST: "$DEST 
 
/usr/local/bin/hsi  -v <<EOF1
cd $DEST
cput $SOURCE : $SOURCE
end
EOF1
status=$?

if [ ! $status == 0 ];then
   echo 'HSI returned non-zero code.'
   /scinet/niagara/bin/exit2msg $status
   exit $status
else
   echo 'TRANSFER SUCCESSFUL'
fi
 
 
trap - TERM INT
