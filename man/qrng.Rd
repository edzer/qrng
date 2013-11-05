\name{quantum_runif}
\alias{quantum_runif}
\alias{setup_QRNG}
\title{ using the quantum number generator server }
\description{ using the quantum number generator server }
\usage{ 
quantum_runif(n, min=0, max=1,..., user, password)
setup_QRNG(user, password, ssl = TRUE, bufsize = 1e6)
}
\arguments{
\item{n}{ number of random numbers to generate }
\item{min}{ minimum value}
\item{max}{ maximum value}
\item{user}{ user name; see note }
\item{password}{ password; see note }
\item{ssl}{ use SSL (secure, encrypted) connection }
\item{bufsize}{ integer; amount of random numbers buffered
before a new set is requested }
\item{...}{ ignored}
}
\value{ \code{quantum_runif} returns a numeric vector of length
\code{n} with random numbers uniformly distributed between \code{min}
and \code{max}. 

\code{setup_QRNG} sets the quantum random number generator as the
default RNG used by R, so that e.g. \code{runif} uses it. See
\link{Random.user} to find out how this works.
}
\note{ Registered users (see \url{https://qrng.physik.hu-berlin.de/})
can obtain random number streams from a quantum random number
generator, which ``provides randomness [...] based on the fundamental
laws of nature.'' Registration is used to avoid that a single user
dominates a shared resource (bandwidth). }

\examples{
\dontrun{
# fill in correct user and password
quantum_runif(100, user = "edzer", password = "theRightPasswd")
setup_QRNG("edzer", "theRightPasswd")
# your quantum random numbers are now produced by:
runif(10)
}
}
\keyword{dplot}
