#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="QE-debug"
#SBATCH --get-user-env
#SBATCH --output=_scheduler-stdout.txt
#SBATCH --error=_scheduler-stderr.txt
#SBATCH --partition=debug
#SBATCH --account=project_465000106
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=200000

module purge
module load PrgEnv-gnu/8.3.3
module load craype-x86-milan
module load cray-libsci/23.02.1.1
module load cray-fftw/3.3.10.3
module load cray-hdf5-parallel/1.12.2.3
module load cray-netcdf-hdf5parallel/4.9.0.3

SLURM_PARA_DIR=slurm-para

for i in 1 2 3 4; do
    cd ${SLURM_PARA_DIR}$i
    srun -n 128 --mem-per-cpu=500 /scratch/project_465000106/src/qe-7.2/bin/pw.x -in scf.in  > scf.out &
    cd ..
done

wait
