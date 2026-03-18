#!/bin/bash
#SBATCH --job-name="1m_eORCA1"
#SBATCH --time=05:00:00
#SBATCH --mem=128G
#SBATCH --account=hpcuser
#SBATCH --partition=compute
#SBATCH --qos=batch
#SBATCH --exclude=compute023,compute037,compute041,compute042,compute043

source /etc/profile.d/modules.sh
module load GCC/12.3.0
module load OpenMPI/4.1.5-GCC-12.3.0
module load HDF5/1.14.0-gompi-2023a
module load netCDF/4.9.2-gompi-2023a
module load netCDF-Fortran/4.6.1-gompi-2023a

SRCDIR=$(pwd)
BUILDDIR="/tmp/tracmass_${YEAR}_${MONTH}_$$"
mkdir -p $BUILDDIR

# Copy everything needed to compile
cp -r $SRCDIR/src $BUILDDIR/
cp $SRCDIR/personal_Makefile $BUILDDIR/Makefile
cp -r $SRCDIR/project_1m_RAPID $BUILDDIR/
cp -r $SRCDIR/projects $BUILDDIR/

cd $BUILDDIR

mkdir -p ${SRCDIR}/logs/eORCA_1/RAPID/${YEAR}/${MONTH}
make clean
make YEAR=$YEAR MONTH=$MONTH 2>&1 | tee ${SRCDIR}/logs/eORCA_1/RAPID/${YEAR}/${MONTH}/make_log.out || { echo "Compilation failed"; exit 1; }

export TRMPROJDIR=${BUILDDIR}/project_1m_RAPID/eORCA1/eORCA1_files/${YEAR}
./runtracmass &> ${SRCDIR}/logs/eORCA_1/RAPID/${YEAR}/${MONTH}/runtracmass_log.out

# Cleanup
rm -rf $BUILDDIR
