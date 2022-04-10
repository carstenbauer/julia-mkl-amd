# julia-mkl-amd

Intel MKL vs OpenBLAS in Julia on HPC clusters at the [Paderborn Center for Parallel Computing (PC2)](https://pc2.uni-paderborn.de/):
* [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) (single and dual-socket AMD EPYC Milan 7763 64-Core CPUs)
* [DGX-A100 @ Noctua 1](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua1) (dual-socket AMD EPYC Rome 7742 64-Core CPUs)

**Remarks:**
* "MKL faked" tries to implement the `LD_PRELOAD` workaround described [here](https://danieldk.eu/Posts/2020-08-31-MKL-Zen.html).

**Versions:**
* Julia version 1.8.0-beta3 since the maximal number of OpenBLAS threads is fixed to 32 in 1.7 (current stable version).
* [MKL_jll](https://github.com/JuliaBinaryWrappers/MKL_jll.jl) `v2022.0.0+0`.

## Acknowledgements

Heavily inspired by a similar Python benchmark run at NERSC: https://docs.nersc.gov/development/languages/python/python-amd/.

## Results

### [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2)

#### Login node

Single **AMD EPYC 7763 64-Core CPU** with hyperthreading **enabled**.

<img src="https://github.com/carstenbauer/julia-mkl-amd/raw/master/n2login3/figure.png">

#### Compute node

Two **AMD EPYC 7763 64-Core CPUs** with hyperthreading **disabled**.

TODO

### [Noctua 1](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua1)

#### DGX-A100

Two **AMD EPYC 7742 64-Core CPUs** with hyperthreading **disabled**.

##### Using only single CPU

<img src="https://github.com/carstenbauer/julia-mkl-amd/raw/master/dgx-a100-singleCPU/figure.png">

##### Using both CPUs

<img src="https://github.com/carstenbauer/julia-mkl-amd/raw/master/dgx-a100/figure.png">
