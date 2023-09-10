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

echo "Job ID: $SLURM_JOB_ID"
echo "Node List: $SLURM_JOB_NODELIST"
echo "Number of Nodes: $SLURM_JOB_NUM_NODES"
echo "Total Number of tasks: $SLURM_NTASKS"
echo "CPUs on this Node: $SLURM_CPUS_ON_NODE"

for (( i=1; i<=$SLURM_JOB_NUM_NODES; i++ )); do
    /pfs/lustrep3/users/mabercx/bin/hq worker start --no-hyper-threading --no-detect-resources &
done

wait