#!/bin/bash -l
# SLURM submission script for SciNet NIAGARA supercomputer

## Specify queue if neeeded
##SBATCH -p debug
# Select number of nodes
#SBATCH -N 3
#SBATCH --ntasks-per-node=40
#SBATCH -t 24:00:00
#SBATCH -J NAME.of.your.JOB
#SBATCH --mail-user=YOUR.EMAIL.HERE
#SBATCH --mail-type=ALL

# load neeeded modules...
module load intel intelmpi gsl hdf5 fftw

# Change to directory from where the job was submitted
echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR

date

time mpiexec.hydra ./myPROG  parameter.FILE  >& output.log

echo $?
