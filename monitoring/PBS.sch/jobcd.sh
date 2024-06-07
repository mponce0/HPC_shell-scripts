#!/bin/bash
#
#  This script allows users to quickly move into the working directory of a given job,
#  specified by the jobID or jobNAME.
#
#  USAGE:  jobcd JOBID||JOBNAME
#
# Feb. 2015 --[:M.Ponce]


if [[ $# -eq 1 ]]; then
   ttt=$(qstat -a | grep -w $1 | awk '{print $1}');
   echo $ttt;
   for j in `qstat -a | grep -w $1 | awk '{print $1}'`; do
       echo $j;
       if [ "$j" != "" ]; then
          echo $j;
          for i in `qstat -f $j | grep WORKDIR | awk -F = {'print $2'} | awk -F , '{print $1}'`; do
              if [ "$i" = "" ]; then
                 echo $i
                 echo "Job NOT found"
              else
                   cd $i
              fi
          done;
        else
          echo "what happened?";
          echo $i,$j;
        fi;
    done;
#    if [ "$j" = ""]; then
#       echo "JobID or JobNAME NOT found!";
#    fi;
else
    echo "Please indicate jobId or jobName";
fi

