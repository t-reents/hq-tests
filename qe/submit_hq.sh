#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="HQ-debug"
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

echo "Job ID: $SLURM_JOB_ID"
echo "Node List: $SLURM_JOB_NODELIST"
echo "Number of Nodes: $SLURM_JOB_NUM_NODES"
echo "Total Number of tasks: $SLURM_NTASKS"
echo "CPUs on this Node: $SLURM_CPUS_ON_NODE"

/pfs/lustrep3/users/mabercx/bin/hq worker start --no-hyper-threading &
sleep 1
/pfs/lustrep3/users/mabercx/bin/hq worker start --no-hyper-threading &
sleep 1
/pfs/lustrep3/users/mabercx/bin/hq worker start --no-hyper-threading &
sleep 1
/pfs/lustrep3/users/mabercx/bin/hq worker start --no-hyper-threading &

wait
