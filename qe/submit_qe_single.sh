#!/bin/bash
##SBATCH --no-requeue
#SBATCH --job-name="aiida-139820"
#SBATCH --get-user-env
#SBATCH --output=_scheduler-stdout.txt
#SBATCH --error=_scheduler-stderr.txt
#SBATCH --nodes=1
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

srun -n 56 --mem-per-cpu=500 /pfs/lustrep1/scratch/project_465000416/sipintar/qe72/qe-bin/bin/pw.x -in scf.in  > scf.out
