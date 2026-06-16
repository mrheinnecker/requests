#!/usr/bin/env bash


srun -p htc --time=0-02:00:00 -c 10 --ntasks-per-node 16 --mem 64G --pty bash

module load Nextflow/24.10.4

nextflow run "/g/schwab/marco/repos/requests/main.nf" \
  --input_table "/g/schwab/marco/repos/requests/paolo_in.tsv" \
  --outdir "/g/schwab/marco/omezarr_paolo"

