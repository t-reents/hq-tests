# How to use

This setup is based on a manual allocation of resources. To request resources, i.e. slurm jobs, run the script `hq_alloc_resources.sh`:

```
bash hq_alloc_resources.sh <number of workers> <sleep time> <slurm file>
```
You only need to specify the number of workers that should be available all the time, the sleeping time in case the maximum number of workers is reached and the slurm job file to allocate the resources.

The script runs an infinite while loop and submits as many slurm jobs as worker slots are available (difference between current number of workers and the desired one).
