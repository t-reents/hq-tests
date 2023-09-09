#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="HQ-debug"
#SBATCH --get-user-env
#SBATCH --output=_scheduler-stdout.txt
#SBATCH --error=_scheduler-stderr.txt
#SBATCH --partition=debug
#SBATCH --account=project_465000106
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=200000

srun -n 128 --mem-per-cpu=50 bash -c  'date >> out1 && taskset -c -p $$ >> out1 && sleep 10 && date >> out1' &
srun -n 128 --mem-per-cpu=50 bash -c  'date >> out2 && taskset -c -p $$ >> out2 && sleep 10 && date >> out2' &

wait
