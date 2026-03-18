#!/bin/bash

for YEAR in {1994..1999}; do
    for MONTH in $(seq -w 1 12); do
        JOBNAME="${MONTH}_${YEAR}_1m_eORCA1"
        echo "Submitting $JOBNAME"
        sbatch --job-name=$JOBNAME --export=YEAR=$YEAR,MONTH=$MONTH submit_tracmass_eORCA1_all.slurm
    done
done
