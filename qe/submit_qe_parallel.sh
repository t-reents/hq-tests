#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="aiida-139820"
#SBATCH --get-user-env
#SBATCH --output=_scheduler-stdout.txt
#SBATCH --error=_scheduler-stderr.txt
#SBATCH --ntasks-per-node=56
#SBATCH --cpus-per-task=1
#SBATCH --time=2:00:00
##SBATCH --gres=gpu:8
#SBATCH --account=project_465000416
#SBATCH --partition=standard-g
#SBATCH --hint=nomultithread
#SBATCH --mem=200000

module load LUMI/23.03
module load partition/G
module load cray-libsci/23.02.1.1
module load cray-fftw

export OMP_PLACES=threads
export OMP_PROC_BIND=close
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

SLURM_PARA_DIR=slurm-para

for (( i=1; i<=$SLURM_JOB_NUM_NODES; i++ )); do
    cd ${SLURM_PARA_DIR}$i
    srun -n 56 --mem-per-cpu=500 /scratch/project_465000106/src/qe-7.2/bin/pw.x -in scf.in  > scf.out &
    cd ..
done

wait
