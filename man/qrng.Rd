\name{quantum_runif}
\alias{quantum_runif}
\alias{setup_QRNG}
\alias{QRNG_seed}
\title{ using the quantum number generator server }
\description{ using the quantum number generator server }
\usage{ 
quantum_runif(n, min = 0, max = 1,..., user, password)
setup_QRNG(user, password, ssl = TRUE, bufsize = 1e5)
QRNG_seed(user, password)
}
\arguments{
\item{n}{ number of random numbers to generate }
\item{min}{ minimum value}
\item{max}{ maximum value}
\item{user}{ user name; see note }
\item{password}{ password; see note }
\item{ssl}{ boolean; use SSL (secure, encrypted) connection }
\item{bufsize}{ integer; amount of random numbers per request to RNG }
\item{...}{ ignored }
}
\value{ \code{quantum_runif} returns a numeric vector of length
\code{n} with random numbers uniformly distributed between \code{min}
and \code{max}. 

\code{setup_QRNG} sets up the connection to the quantum random number
generator and has as side effect that subsequent random numbers in
R are taken from this random number generator, e.g. those produced
by \code{runif} and the like.  See \link{Random.user} to find out
how this works.

\code{QRNG_seed} returns an quantum random integer that can be used
to seed another random number generator, see \link{set.seed}
}
\note{ Registered users (see \url{https://qrng.physik.hu-berlin.de/})
can obtain random number streams from a quantum random number
generator, which ``provides randomness [...] based on the fundamental
laws of nature.'' Registration is used to avoid that a single user
dominates a shared resource (bandwidth). }

\examples{
# fill in correct user and password, or set them by
# options("qrng.user" = "my_user")
# options("qrng.password" = "my_password")
source("~/.Rprofile")
quantum_runif(100)
setup_QRNG()
# your quantum random numbers are now produced by:
runif(10)
}
\keyword{dplot}
