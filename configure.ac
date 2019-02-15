dnl Configure template for pam_sqlite3
dnl $Id: configure.in,v 1.7 2003/06/22 22:59:45 ek Exp $

AC_INIT(pam_sqlite3, 1.0.1)
AC_CONFIG_HEADER(config.h)

AM_INIT_AUTOMAKE
LT_INIT([disable-static])


dnl Checks for libraries.
AC_CHECK_LIB(pam, pam_get_user)

dnl Checks for header files.
AC_CANONICAL_HOST
AC_HEADER_STDC

dnl check system headers
AC_CHECK_HEADERS([crypt.h syslog.h unistd.h sys/types.h sqlite3.h])
AC_CHECK_HEADERS_ONCE([security/pam_modules.h security/openpam.h security/pam_misc.h])

dnl Check for library functions
AC_CHECK_FUNCS([crypt])

AC_ARG_ENABLE(securedir,
    AS_HELP_STRING([--enable-securedir=DIR],
        [path to location of PAMs @<:@default=LIBDIR/security@:>@]),
    SECUREDIR=$enableval, SECUREDIR=$libdir/security)
AC_SUBST(SECUREDIR)

dnl
dnl Check for crypt() capabilities
dnl
AC_DEFUN(AC_CRYPT_CAP,[

  if test "$ac_cv_func_crypt" = "no"; then
  AC_CHECK_LIB(crypt, crypt, [
    LIBS="-lcrypt $LIBS -lcrypt"
    AC_DEFINE(HAVE_CRYPT, 1, [ ])
  ])
  fi
  
  AC_CACHE_CHECK(for standard DES crypt, ac_cv_crypt_des,[
  AC_TRY_RUN([
#if HAVE_CRYPT_H
#include <crypt.h>
#endif

main() {
#if HAVE_CRYPT
    exit (strcmp((char *)crypt("rasmuslerdorf","rl"),"rl.3StKT.4T8M"));
#else
	exit(0);
#endif
}],[
    ac_cv_crypt_des=yes
  ],[
    ac_cv_crypt_des=no
  ],[
    ac_cv_crypt_des=yes
  ])
  ])
  if test "$ac_cv_crypt_des" = "yes"; then
    ac_result=1
  else
    ac_result=0
  fi
  AC_DEFINE_UNQUOTED(HAVE_STD_DES_CRYPT, $ac_result, [Whether the system supports standard DES salt])

  AC_CACHE_CHECK(for extended DES crypt, ac_cv_crypt_ext_des,[
  AC_TRY_RUN([
#if HAVE_CRYPT_H
#include <crypt.h>
#endif

main() {
#if HAVE_CRYPT
    exit (strcmp((char *)crypt("rasmuslerdorf","_J9..rasm"),"_J9..rasmBYk8r9AiWNc"));
#else
	exit(0);
#endif
}],[
    ac_cv_crypt_ext_des=yes
  ],[
    ac_cv_crypt_ext_des=no
  ],[
    ac_cv_crypt_ext_des=no
  ])
  ])
  if test "$ac_cv_crypt_ext_des" = "yes"; then
    ac_result=1
  else
    ac_result=0
  fi
  AC_DEFINE_UNQUOTED(HAVE_EXT_DES_CRYPT, $ac_result, [Whether the system supports extended DES salt])

  AC_CACHE_CHECK(for MD5 crypt, ac_cv_crypt_md5,[
  AC_TRY_RUN([
#if HAVE_CRYPT_H
#include <crypt.h>
#endif

main() {
#if HAVE_CRYPT
    char salt[15], answer[40];

    salt[0]='$'; salt[1]='1'; salt[2]='$'; 
    salt[3]='r'; salt[4]='a'; salt[5]='s';
    salt[6]='m'; salt[7]='u'; salt[8]='s';
    salt[9]='l'; salt[10]='e'; salt[11]='$';
    salt[12]='\0';
    strcpy(answer,salt);
    strcat(answer,"rISCgZzpwk3UhDidwXvin0");
    exit (strcmp((char *)crypt("rasmuslerdorf",salt),answer));
#else
	exit(0);
#endif
}],[
    ac_cv_crypt_md5=yes
  ],[
    ac_cv_crypt_md5=no
  ],[
    ac_cv_crypt_md5=no
  ])
  ])
  if test "$ac_cv_crypt_md5" = "yes"; then
    ac_result=1
  else
dnl    if test "$ac_cv_crypt_des" != "yes"; then
dnl      PHP_DEBUG_MACRO(debug.log)
dnl    fi
    ac_result=0
  fi
  AC_DEFINE_UNQUOTED(HAVE_MD5_CRYPT, $ac_result, [Whether the system supports MD5 salt])

  AC_CACHE_CHECK(for Blowfish crypt, ac_cv_crypt_blowfish,[
  AC_TRY_RUN([
#if HAVE_CRYPT_H
#include <crypt.h>
#endif

main() {
#if HAVE_CRYPT
    char salt[30], answer[70];
    
    salt[0]='$'; salt[1]='2'; salt[2]='a'; salt[3]='$'; salt[4]='0'; salt[5]='7'; salt[6]='$'; salt[7]='\0';
    strcat(salt,"rasmuslerd............");
    strcpy(answer,salt);
    strcpy(&answer[29],"nIdrcHdxcUxWomQX9j6kvERCFjTg7Ra");
    exit (strcmp((char *)crypt("rasmuslerdorf",salt),answer));
#else
	exit(0);
#endif
}],[
    ac_cv_crypt_blowfish=yes
  ],[
    ac_cv_crypt_blowfish=no
  ],[
    ac_cv_crypt_blowfish=no
  ])
  ])
  if test "$ac_cv_crypt_blowfish" = "yes"; then
    ac_result=1
  else
    ac_result=0
  fi
  AC_DEFINE_UNQUOTED(HAVE_BLOWFISH_CRYPT, $ac_result, [Whether the system supports BlowFish salt])
])

AC_CRYPT_CAP

AC_CHECK_LIB(sqlite3, sqlite3_open, 
    [LIBS="$LIBS -lsqlite3"],
    [AC_MSG_ERROR(could not determine SQLite library location)])
LDFLAGS="$old_LDFLAGS"

if test "`uname`" = "Linux" >/dev/null 2>/dev/null; then
    # Debian needs this
    LIBS="$LIBS -lpam_misc"
fi

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST

AC_SUBST(host_os)
AC_OUTPUT(Makefile)
