CLEANFILES = *~

TESTS = test

securelibdir = $(SECUREDIR)
secureconfdir = $(SCONFIGDIR)

AM_CFLAGS = -Wall
AM_LDFLAGS = -module -export-dynamic -shared -avoid-version $(LDFLAGS_NOUNDEFINED)

securelib_LTLIBRARIES = pam_sqlite3.la
pam_sqlite3_la_SOURCES = pam_sqlite3.c pam_get_pass.c pam_std_option.c pam_get_service.c
pam_sqlite3_la_LIBADD = -lpam -lsqlite3
