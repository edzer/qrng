R interface to a [quantum random number service](https://qrng.physik.hu-berlin.de/download), based on the quantum randomness of photon arrival times, hosted by the Humboldt university in Berlin.

You need to register for this site, but the random numbers are for free. The registration serves the purpose of avoiding that a single user dominates the download bandwidth.

The package is not on [CRAN](http://cran.r-project.org) because of its dependency on the binary libQRNG library, binary executable code is [not allowed](http://cran.r-project.org/web/packages/policies.html) in CRAN source packages.
