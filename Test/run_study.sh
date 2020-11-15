#!/bin/bash

# Exit if a command fails
set -e

if [ -e SolverStudyWork ]; then
  echo "./SolverStudyWork exists already, remove it first"
  exit 1
fi

# Configure environment
export SOLVERSTUDY_DIR_BASE=WORK

# Go to base directory
cd Python_Scripts

# Run download
time python script_download_jws_sedml_sbml.py
time python script_download_biomodels_sbml.py

# run model regrouping
time python script_regroup_models.py

# Run amici import and compilation
time python sbml2amici.py
# time python sbml2copasi.py # TBD: automated Copasi import

# Run JWS trajectory comparison
time python compare_state_trajectories.py

# Select models to include in main study
time python filter_models_by_error.py

# Run main study
time python execute_study_algorithms.py
time python execute_study_tolerances.py

# TODO Run Plots