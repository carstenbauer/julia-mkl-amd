# julia-mkl-amd

Intel MKL vs OpenBLAS in Julia on [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) with AMD EPYC 7763 64-Core CPU.

## Results

<img src="https://github.com/carstenbauer/julia-mkl-amd/raw/master/figure.png">

**Remarks:**
* "MKL faked" uses the `LD_PRELOAD` described [here](https://danieldk.eu/Posts/2020-08-31-MKL-Zen.html).
* Used MKL: [MKL_jll](https://github.com/JuliaBinaryWrappers/MKL_jll.jl) `v2022.0.0+0`.
* The tests have been run with Julia version 1.8.0-beta3 since in 1.7 (current stable version) the maximal number of OpenBLAS threads is fixed to 32 and our nodes have more cores available.
* We used an (exclusive) login node of Noctua 2 to run the test since hyperthreading is disabled on the compute nodes.

## Acknowledgements

Heavily inspired by https://docs.nersc.gov/development/languages/python/python-amd/.
