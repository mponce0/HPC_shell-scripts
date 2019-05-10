# example of a submission capable of passing coomand line arguments to a PBS submission script
# -mponce

qsub -N $1 -v var1=$1,$2 test.pbs -q debug
