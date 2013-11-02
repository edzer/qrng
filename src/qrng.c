# include <R.h>
# include <Rdefines.h>
# include <Rinternals.h>
#include <R_ext/Rdynload.h>

# include <libQRNG.h>

SEXP QRNG(SEXP s_n, SEXP s_usr, SEXP s_passwd) {
	const char *usr, *passwd;
	int n, n_ret, err, i;
	double *d;
	SEXP rn;

	usr = CHAR(STRING_ELT(s_usr, 0));
	passwd = CHAR(STRING_ELT(s_passwd, 0));
	n = INTEGER_POINTER(s_n)[0];
	PROTECT(rn = NEW_NUMERIC(n));
	/*
	d = (double *) R_alloc((size_t) rn, sizeof(double));
	bug -- reported by Marek Smigielski, Mar 12, 2013 - should be:
	*/
	d = (double *) R_alloc((size_t) n, sizeof(double));
	err = qrng_connect_and_get_double_array(usr, passwd, d, n, &n_ret);
	if (n_ret != n)
		PROBLEM "random numbers retrieved: %d", n_ret ERROR;
	for (i = 0; i < n; i++)
		NUMERIC_POINTER(rn)[i] = d[i];
	UNPROTECT(1);
	return(rn);
}

static R_CallMethodDef CallEntries[] = {
    {"QRNG", (DL_FUNC) &QRNG, 3},
    {NULL, NULL, 0}
};
static const R_CMethodDef CEntries[]  = {
    {NULL, NULL, 0}
};

void
#ifdef HAVE_VISIBILITY_ATTRIBUTE
__attribute__ ((visibility ("default")))
#endif
R_init_qrng(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
