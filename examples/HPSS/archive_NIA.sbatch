#!/bin/bash -l
#SBATCH -t 72:00:00
#SBATCH -p archivelong 
#SBATCH -N 1
#SBATCH -J htar_create_tarball_in_hpss
#SBATCH --mail-type=ALL
 
########################################################
# Submission script to transfer data to the HPSS tape-archival system @ the Niagara SuperComputer
# Based on examples from
#	https://docs.scinet.utoronto.ca/index.php/HPSS#Scripted_File_Transfers
#
# Marcelo Ponce
########################################################

echo "Creating a htar of $TARGET directory tree into HPSS"
 
trap "echo 'Job script not completed';exit 129" TERM INT
# Note that your initial directory in HPSS will be $ARCHIVE
ARCHIVE=/archive/s/scinet/mponce
 
#SOURCE=S_1ms1ms_100kms-a
#SOURCE=tilted
SOURCE=tiltedARB
DEST=$ARCHIVE/${SOURCE}.tar

echo hello world!!! $ARCHIVE !!!
  
# htar WILL overwrite an existing file with the same name so check beforehand.
 
hsi ls $DEST &> /dev/null
status=$?
 
if [ $status == 0 ]; then  
    echo 'File $DEST already exists. Nothing has been done'
    exit 1
fi
 
echo $SLURM_SUBMIT_DIR  ::: $SOURCE  :::  $DEST
cd $SLURM_SUBMIT_DIR
ls -d $SOURCE
htar -Humask=0137 -cpf $DEST $SOURCE
status=$?
  
trap - TERM INT
  
if [ ! $status == 0 ]; then
   echo 'HTAR returned non-zero code.'
   /scinet/niagara/bin/exit2msg $status
   exit $status
else
   echo 'TRANSFER SUCCESSFUL'
fi
