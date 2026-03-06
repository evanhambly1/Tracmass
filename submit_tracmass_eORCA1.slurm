#!/bin/bash

#SBATCH --job-name="eORCA1_1m_36N"
#SBATCH --time=05:00:00
#SBATCH --mem=24G
#SBATCH --account=hpcuser
#SBATCH --partition=compute
#SBATCH --qos=batch

# ------------------------------------------------
# Run Tracmass v7.1 eORCA12.
# Created on: 11/03/2025
# Created by: Ollie Tooth (oliver.tooth@noc.ac.uk)
# ------------------------------------------------

# -- Loading Modules -- # jaspy only for on jasmin
#module load jaspy
# -- Loading Modules -- #
module load GCC/12.3.0
module load OpenMPI/4.1.5-GCC-12.3.0
module load HDF5/1.14.0-gompi-2023a
module load netCDF/4.9.2-gompi-2023a
module load netCDF-Fortran/4.6.1-gompi-2023a


# -- Running Tracmass v7.1 -- #
rm Makefile
ln -s personal_Makefile Makefile

# Compile Tracmass v7.1.
make clean
make

# Run TRACMASS:
#srun --unbuffered ./runtracmass
srun --unbuffered ./runtracmass &> ./logs/runtracmass_log.out
