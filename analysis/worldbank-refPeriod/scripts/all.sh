#!/bin/bash
time ./get.worldbank.metadata.sh
time ./get.worldbank.observation.sh
time Rscript create.worldbank.correlation.R
time Rscript create.worldbank.metadata.subset.R
time ./create.worldbank.similarity.sh
time Rscript create.worldbank.similarity-correlation.R

