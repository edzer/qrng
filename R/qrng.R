quantum_runif = function(n, min = 0.0, max = 1.0,..., user, password) {
	ret = .Call("QRNG", as.integer(n), user, password)
	min + ret * max
}

setup_QRNG = function(user, password, ssl = TRUE, bufsize = 1e5) {
	stopifnot(!missing(user))
	stopifnot(!missing(password))
	stopifnot(is.logical(ssl))
	stopifnot(bufsize > 0)
	.Call("setup_QRNG", user, password, as.integer(ssl), as.integer(bufsize))
	RNGkind("user")
}

.onUnload <- function(libpath) {
	.C("close_QRNG")
    library.dynam.unload("qrng", libpath)
}
