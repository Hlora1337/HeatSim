# HeatSim
My first HPC program.
It's basically calculating from data what temperature is considering size of field and temperature in the centre.

Recommend writing all required data in input.txt

## Requirements
gcc-gfortran or other fortran compiler
fpm (more actual version - better)

## Build
Download source from git: https://github.com/Hlora1337/HeatSim

Take your fpm, put in folder with program, open terminal and go to the folder.

Then the most important (all work with fpm under administrator rights): fpm build --flag "-O3 -march=native -funroll-loops -ffast-math"

And you built your program

## Usage
print all required data in input.txt (Example exists) and then just "fpm run" and it'll do all job