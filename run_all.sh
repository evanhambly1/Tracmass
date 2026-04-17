#!/bin/bash

for YEAR in {1990..1999}; do
    for MONTH in $(seq -w 1 12); do
        JOBNAME="${MONTH}_${YEAR}_1m_eORCA025"
        echo "Submitting $JOBNAME"
        sbatch --job-name=$JOBNAME --export=YEAR=$YEAR,MONTH=$MONTH submit_tracmass_eORCA025_all.slurm
    done
done
