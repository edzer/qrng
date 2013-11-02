\name{quantum_runif}
\alias{quantum_runif}
\title{ runif() using the quantum number generator server }
\description{ runif() using the quantum number generator server }
\usage{ 
quantum_runif(n, min=0, max=1,..., user, password)
}
\arguments{
\item{n}{ number of random numbers to generate }
\item{min}{ minimum value}
\item{max}{ maximum value}
\item{user}{ user name; see note }
\item{password}{ password; see note }
\item{...}{ ignored}
}
\value{numeric vector with random uniform numbers between min and
max.  }

\note{ registered users (see \url{https://qrng.physik.hu-berlin.de/})
can obtain random number streams from a quantum random number
generator, which ``provides randomness [...] based on the fundamental
laws of nature.'' }

\examples{
\dontrun{
# fill in correct user and password
quantum_runif(100, user = "edzer", password = "theRightPasswd")
}
}
\keyword{dplot}
