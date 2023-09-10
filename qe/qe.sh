#!/bin/bash
# HQ --name=QE-run
#HQ --cpus="56 compact"
#HQ --pin taskset
#HQ --stdout stdout
#HQ --stderr stderr

module load LUMI/23.03
module load partition/G
module load cray-libsci/23.02.1.1
module load cray-fftw

export OMP_NUM_THREADS=1

srun -n 56 --mem-per-cpu=500 /pfs/lustrep1/scratch/project_465000416/sipintar/qe72/qe-bin/bin/pw.x -in scf.in  > scf.out
