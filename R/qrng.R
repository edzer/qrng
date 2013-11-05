quantum_runif = function(n, min = 0.0, max = 1.0,..., user, password) {
	ret = .Call("QRNG", as.integer(n), user, password)
	min + ret * max
}

setup_QRNG = function(usr, passwd, ssl = 0L, bufsize = 1e6) {
	stopifnot(!missing(usr))
	stopifnot(!missing(passwd))
	stopifnot(ssl == 0 || ssl == 1)
	stopifnot(bufsize > 0)
	.Call("setup_QRNG", usr, passwd, as.integer(ssl), as.integer(bufsize))
	RNGkind("user")
}
