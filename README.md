qrng
====

R interface to a free [quantum random number service](https://qrng.physik.hu-berlin.de/download), based on the quantum randomness of photon arrival times, hosted by the Humboldt university in Berlin.

You need to register for this site, but the random numbers are for free. The registration serves the purpose of avoiding that a single user dominates the download bandwidth. 


The package is not on [CRAN](http://cran.r-project.org) because of its dependency on the binary libQRNG library, binary executable code is [not allowed](http://cran.r-project.org/web/packages/policies.html) in CRAN source packages. After logging in, the required libQRNG library can be downloaded.

### Installing qrng

You can install the shared library (.dll or .so) in an appropriate directory. For linux, take
the following steps:

1. install the `.so` file in  `/usr/local/lib`
1. make sure that `/etc/ld.so.conf` contains `/usr/local/lib`, or if it refers to files included that one of these files contain it
1. run `sudo ldconfig`, or on systems without `sudo` run `ldconfig` as root.

### Installing the qrng R package

Make sure that package `devtools` is installed, otherwise install it with

```
install.packages("devtools")
```

and then install directly from github:

```
library(devtools)
install_github("edzer/qrng")
```

### sample session:
```
> library(qrng)
```
get quantum random numbers:
```
> quantum_runif(10, user = "edzer", password = "YourPW")
 [1] 0.20538839 0.90860514 0.17295354 0.32030059 0.36653032 0.94955527
 [7] 0.35582723 0.88221983 0.29111428 0.09642045
```
get a quantum integer, to be used as random seed:
```
> QRNG_seed("edzer", "YourPW")
[1] -1438960125
```
set currend RNG seed with a new quantum value:
```
> set.seed(QRNG_seed("edzer", "YourPW"))
```
what is the current RNG?
```
> RNGkind()
[1] "Mersenne-Twister" "Inversion"
```
change it into using the QRNG:
```
> setup_QRNG(user = "edzer", password = "YourPW", ssl = TRUE, 1e4)
> RNGkind()
[1] "user-supplied" "Inversion"
```
user-supplied means we now obtain QRNG numbers by calling:
```
> runif(10) 
 [1] 0.4278956 0.3804281 0.8409188 0.6872713 0.7990998 0.1479594 0.2394953
 [8] 0.7209651 0.8623249 0.9671532
```
note that this sequence is unique and non-reproducible by construction. Using `set.seed` does
not have any effect when using this RNG.
