#  This script allows users to find the tree of dependencies of a given job,
#  specified by the jobID.
#
#  USAGE:  jobtree username 
#
# Mar. 2015 --[:mponce]


if [[ $# -eq 0 ]]; then
   echo "Assuming the current user" $USER
   username=$USER;
else
    username=$1;
fi

listN=$(showq | grep $username | awk '{print $1}')

   echo $listN
   for i in $listN; do
       echo "* "$i":";
       source ~/jobtools/jobdep.sh $i;
       printf "\n\n";
   done;
   if [ "$i" = "" ]; then
      echo "Couldn't find any jobs for " $username
   fi;

