#  This script allows users to find the tree of dependencies of a given job,
#  specified by the jobID.
#
#  USAGE:  jobtree JOBID
#
# Mar. 2015 --[:M.Ponce]

if [[ $# -eq 2 ]]; then
   level=$2;
else
   level=0;
fi

if [[ $# -ge 1 ]]; then
   #listN=$(checkjob -v $1 | grep depend | awk -Fdepend= '{print $2}' | awk -F: '{for(i=1;i<NF;i++) print $i}')
   listN=$(checkjob -v $1 | grep "Submit Args:" |  awk -Fdepend= '{print $2}' | awk -F: '{for(j=2;j<=NF;j++) print $j}' | awk '{print $1}')
   #echo $listN
   for i in $listN; do
       for (( k=0; k<=$level; k++ )); do
           printf "    ";
       done;
       echo "+-->"$i "("$level")";
       level=$((level+1));
       source ~/jobtools/jobdep.sh $i $level;
   done;
   level=0;
   if [ "$i" = "" ]; then
      echo "Couldn't find any job dependencies for " $1;
      echo "Be sure you have specfied the correct jobID";
   fi;
else
    echo "Please indicate jobId";
fi

