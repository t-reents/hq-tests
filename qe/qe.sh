#!/bin/bash
#HQ --name=QE-run
#HQ --cpus="128 compact"
#HQ --pin taskset
#HQ --stdout stdout
#HQ --stderr stderr

module purge
module load PrgEnv-gnu/8.3.3
module load craype-x86-milan
module load cray-libsci/23.02.1.1
module load cray-fftw/3.3.10.3
module load cray-hdf5-parallel/1.12.2.3
module load cray-netcdf-hdf5parallel/4.9.0.3

printenv > env

srun -n 128 --mem-per-cpu=500 /scratch/project_465000106/src/qe-7.2/bin/pw.x -in scf.in  > scf.out
