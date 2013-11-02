quantum_runif = function(n, min=0, max=1,..., user, password) {
	ret = .Call("QRNG", as.integer(n), user, password)
	ret * max + min
}
