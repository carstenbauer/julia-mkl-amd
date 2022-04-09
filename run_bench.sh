# OMP_NUM_THREADS=128 OMP_PLACES=cores OMP_PROC_BIND=close srun -u -n 1 -c 128 --cpu_bind=sockets julia --project bench.jl highAI
# OMP_NUM_THREADS=128 OMP_PLACES=cores OMP_PROC_BIND=spread srun -u -n 1 -c 128 --cpu_bind=sockets julia --project bench.jl highMB

# OMP_NUM_THREADS=128 OMP_PLACES=cores OMP_PROC_BIND=close julia --project bench.jl highAI
# OMP_NUM_THREADS=128 OMP_PLACES=cores OMP_PROC_BIND=spread julia --project bench.jl highMB

OMP_NUM_THREADS=64 OMP_PLACES=cores OMP_PROC_BIND=close julia --project bench.jl highAI
OMP_NUM_THREADS=64 OMP_PLACES=cores OMP_PROC_BIND=spread julia --project bench.jl highMB

julia --project plot_results.jl