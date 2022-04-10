rm -f results.csv

OMP_NUM_THREADS=128 OMP_PLACES=threads OMP_PROC_BIND=close julia-beta --project=.. ../bench.jl OpenBLAS highAI
OMP_NUM_THREADS=64 OMP_PLACES=cores OMP_PROC_BIND=spread julia-beta --project=.. ../bench.jl OpenBLAS highMB
OMP_NUM_THREADS=128 OMP_PLACES=threads OMP_PROC_BIND=close julia-beta --project=.. ../bench.jl MKL highAI
OMP_NUM_THREADS=64 OMP_PLACES=cores OMP_PROC_BIND=spread julia-beta --project=.. ../bench.jl MKL highMB
export LD_PRELOAD=/scratch/pc2-mitarbeiter/bauerc/devel/julia-mkl-amd/mkl_workaround/libfakeintel.so
OMP_NUM_THREADS=128 OMP_PLACES=threads OMP_PROC_BIND=close julia-beta --project=.. ../bench.jl MKL highAI
OMP_NUM_THREADS=64 OMP_PLACES=cores OMP_PROC_BIND=spread julia-beta --project=.. ../bench.jl MKL highMB

julia-beta --project ../plot_results.jl
