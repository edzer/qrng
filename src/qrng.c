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
	if (err)
		PROBLEM "qrng error: %s", qrng_error_strings[err] ERROR;
	if (n_ret == 0)
		PROBLEM "zero random numbers retrieved: wrong login or passwd?" ERROR;
	if (n_ret != n)
		PROBLEM "random numbers retrieved: %d", n_ret ERROR;
	for (i = 0; i < n; i++)
		NUMERIC_POINTER(rn)[i] = d[i];
	UNPROTECT(1);
	return(rn);
}

static int connected = 0, buf_size = 0, i = -1;
static double *buf = NULL;

SEXP setup_QRNG(SEXP s_usr, SEXP s_passwd, SEXP s_ssl, SEXP s_bufsize) {
	int err, ssl;
	ssl = INTEGER_POINTER(s_ssl)[0];
	if (ssl)
		err = qrng_connect_SSL(CHAR(STRING_ELT(s_usr, 0)), CHAR(STRING_ELT(s_passwd, 0)));
	else
		err = qrng_connect(CHAR(STRING_ELT(s_usr, 0)), CHAR(STRING_ELT(s_passwd, 0)));
	if (err) {
		PROBLEM "qrng error: %s", qrng_error_strings[err] ERROR;
		connected = 0;
	} else
		connected = 1;
	buf_size = INTEGER_POINTER(s_bufsize)[0];
	buf = (double *) realloc(buf, buf_size * sizeof(double));
	if (buf == NULL)
		PROBLEM "cannot allocate buffer for qrng" ERROR;
	return(s_ssl);
}

double *user_unif_rand() {
	int err, rcvd;
	if (i == buf_size || i < 0) {
		err = qrng_get_double_array(buf, buf_size, &rcvd);
		if (err)
			PROBLEM "qrng error: %s", qrng_error_strings[err] ERROR;
		if (rcvd != buf_size)
			PROBLEM "recieved qrng numbers: %d", rcvd ERROR;
		i = 0;
	}
	return(&(buf[i++]));
}

static R_CallMethodDef CallEntries[] = {
    {"QRNG", (DL_FUNC) &QRNG, 3},
	{"setup_QRNG", (DL_FUNC) setup_QRNG, 4},
    {NULL, NULL, 0}
};
static const R_CMethodDef CEntries[]  = {
	{"user_unif_rand", (DL_FUNC) &user_unif_rand, 0},
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
