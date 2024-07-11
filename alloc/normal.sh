#!/bin/bash
#SBATCH --no-requeue
#SBATCH --get-user-env
#SBATCH --job-name="HQ_worker"
#SBATCH --uenv=/capstor/scratch/cscs/simonpi/uenv-images/qe-sirius-md-8.1.30.sqfs
#SBATCH --output=_scheduler-stdout.txt
#SBATCH --error=_scheduler-stderr.txt
#SBATCH --partition=normal
#SBATCH --account=g168
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=72
#SBATCH --time=12:00:00
#SBATCH --mem=250000

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_SMP_SINGLE_COPY_MODE=xpmem


/users/treents/bin/hq worker start --no-hyper-threading --manager slurm --heartbeat 10m &
wait
