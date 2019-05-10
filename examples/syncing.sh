#!/bin/bash

########################################################
# Shell script to synchronize a remote location with a local one
# it will attempt NBRattempts times...
#
# M.Ponce
########################################################


# define this variables according to your system and directories you want to sync...
LOGINnode="gpc-logindm01"
REMOTEtarget="/scratch2/s/scinet/mponce/spinning"
LOCALtarget="."
NBRattempts=100

for i in {1..$NBRattempts}; do   ### try NBRattempts times
    rsync -rlv --progress -e ssh  $USER@$LOGINnode:$REMOTEtarget  $LOCALtarget ;
    [ "$?" == "0" ] && break;
    echo "Error... retrying...",$0, $i;
done

