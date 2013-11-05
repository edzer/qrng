R interface to a [quantum random number service](https://qrng.physik.hu-berlin.de/download), based on the quantum randomness of photon arrival times, hosted by the Humboldt university in Berlin.

You need to register for this site, but the random numbers are for free. The registration serves the purpose of avoiding that a single user dominates the download bandwidth.

The package is not on [CRAN](http://cran.r-project.org) because of its dependency on the binary libQRNG library, binary executable code is [not allowed](http://cran.r-project.org/web/packages/policies.html) in CRAN source packages.

# sample session:
```
> library(qrng)
> quantum_runif(10, user = "edzer", password = "YourPW")
 [1] 0.20538839 0.90860514 0.17295354 0.32030059 0.36653032 0.94955527
 [7] 0.35582723 0.88221983 0.29111428 0.09642045
> setup_QRNG(user = "edzer", password = "YourPW", ssl = TRUE, 1e4)
> RNGkind()
[1] "user-supplied" "Inversion"
> runif(10) # user-supplied now means use the QRNG numbers
 [1] 0.4278956 0.3804281 0.8409188 0.6872713 0.7990998 0.1479594 0.2394953
 [8] 0.7209651 0.8623249 0.9671532
```
