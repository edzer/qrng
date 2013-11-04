R interface to a [quantum random number service](https://qrng.physik.hu-berlin.de/download), based on the quantum randomness of photon arrival times, hosted by the Humboldt university in Berlin.

You need to register for this site, but otherwise the random numbers are for free. I guess the registration serves the purpose that you don't get the same random numbers twice. 

The package is not on [CRAN](http://cran.r-project.org) because of its dependency on the binary libQRNG library, binary executable code is [not allowed](http://cran.r-project.org/web/packages/policies.html) in CRAN source packages.
