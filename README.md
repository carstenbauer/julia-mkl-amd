# julia-mkl-amd

Intel MKL vs OpenBLAS on [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) (AMD EPYC 7763 64-Core CPU) in Julia.

**Remarks:**
* The tests have been run with Julia version 1.8.0-beta3 since in 1.7 (current stable version) the maximal number of OpenBLAS threads is fixed to 32 and our nodes have more cores available.

## Results

<img src="https://github.com/carstenbauer/julia-mkl-amd/raw/master/figure.png">

## Acknowledgements

Heavily inspired by https://docs.nersc.gov/development/languages/python/python-amd/.
