# julia-mkl-amd

Intel MKL vs OpenBLAS in Julia on [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) with .

**Remarks:**
* "MKL faked" uses the `LD_PRELOAD` described [here](https://danieldk.eu/Posts/2020-08-31-MKL-Zen.html).
* Used MKL: [MKL_jll](https://github.com/JuliaBinaryWrappers/MKL_jll.jl) `v2022.0.0+0`.
* The tests have been run with Julia version 1.8.0-beta3 since in 1.7 (current stable version) the maximal number of OpenBLAS threads is fixed to 32 and our nodes have more cores available.
* We used an (exclusive) login node of Noctua 2 to run the test since hyperthreading is disabled on the compute nodes.

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
