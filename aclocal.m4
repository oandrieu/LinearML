dnl -*- autoconf -*- macros for OCaml

#
# AC_OCAML_CHECK_VERSION(COMMAND)
# -------------------------------
AC_DEFUN([AC_OCAML_CHECK_VERSION],[
if test "$OCAMLVERSION" != "$($$1 -version)" ; then
  AC_MSG_WARN([$(basename $$1) version differs from that of ocamlc])
fi
])

#
# AC_OCAML_RUN_PROGRAM(PROGRAM, RESULT_VAR, ADDITIONAL ARGS)
# ----------------------------------------------------------
AC_DEFUN([AC_OCAML_RUN_PROGRAM],[
cat > conftest.ml << EOF
$1
EOF
$2=$($OCAML $3 conftest.ml)
])

#
# AC_OCAML_PATH_PROG(VARIABLE, PROGS, ACTION-IF-NOT-FOUND, PATH)
# --------------------------------------------------------------
AC_DEFUN([AC_OCAML_PATH_PROG],[
AC_PATH_PROGS([$1],[$2],,[$4])
AS_IF([test -z "$$1"],[$3])
])

#
# AC_OCAML_CONFIG_KEY(VARIABLE, KEY)
# --------------------------------------------------------------
AC_DEFUN([AC_OCAML_CONFIG_KEY],[
AC_MSG_CHECKING([OCaml config $2])
$1="$($OCAMLC -config | $AWK '/^$2:/ { print $[]2 }')"
AC_SUBST($1)
AC_MSG_RESULT([$$1])
])


#
# AC_PROG_OCAML
# -------------
AC_DEFUN([AC_PROG_OCAML],[
AC_OCAML_PATH_PROG([OCAML],[ocaml],[AC_MSG_ERROR([Cannot find ocaml])])
OCAML_BASE_DIR=$(dirname $OCAML)

AC_OCAML_PATH_PROG([OCAMLC],[ocamlc.opt ocamlc],
                   [AC_MSG_ERROR([Cannot find ocamlc])],
                   [$OCAML_BASE_DIR])
AC_MSG_CHECKING([OCaml version])
OCAMLVERSION="$($OCAMLC -version)"
AC_SUBST(OCAMLVERSION)
AC_MSG_RESULT([$OCAMLVERSION])

AC_MSG_CHECKING([OCaml os_type])
AC_OCAML_RUN_PROGRAM([print_endline Sys.os_type],[OCAMLOS])
AC_SUBST(OCAMLOS)
AC_MSG_RESULT([$OCAMLOS])

AC_OCAML_CONFIG_KEY([OCAMLEXTOBJ],[ext_obj])
AC_OCAML_CONFIG_KEY([OCAMLEXTLIB],[ext_lib])

AC_OCAML_PATH_PROG([OCAMLOPT],[ocamlopt.opt ocamlopt],
                   [AC_MSG_ERROR([Cannot find ocamlopt])],
                   [$OCAML_BASE_DIR])
AC_OCAML_CHECK_VERSION([OCAMLOPT])
AC_OCAML_PATH_PROG([OCAMLDEP],[ocamldep.opt ocamldep],
                   [AC_MSG_ERROR([Cannot find ocamldep])],
                   [$OCAML_BASE_DIR])
AC_OCAML_PATH_PROG([OCAMLLEX],[ocamllex.opt ocamllex],
                   [AC_MSG_ERROR([Cannot find ocamllex])],
                   [$OCAML_BASE_DIR])
AC_OCAML_PATH_PROG([OCAMLYACC],[ocamlyacc],
                   [AC_MSG_ERROR([Cannot find ocamlyacc])],
                   [$OCAML_BASE_DIR])
AC_OCAML_PATH_PROG([OCAMLDOC],[ocamldoc],
                   [AC_MSG_WARN([Cannot find ocamldoc])],
                   [$OCAML_BASE_DIR])
AC_OCAML_PATH_PROG([CAMLP4],[camlp4],
                   [AC_MSG_WARN([Cannot find camlp4])],
                   [$OCAML_BASE_DIR])
AC_OCAML_CHECK_VERSION([CAMLP4])
AC_OCAML_PATH_PROG([CAMLP4O],[camlp4o.opt camlp4o],
                   [AC_MSG_WARN([Cannot find camlp4o])],
                   [$OCAML_BASE_DIR])
AC_PATH_PROG([OCAMLBUILD],[ocamlbuild],[],[$OCAML_BASE_DIR])

AC_MSG_CHECKING([checking whether ocamlopt accepts -g])
touch conftest.ml
if $OCAMLOPT -c -g conftest.ml 2>&1 >/dev/null | grep -q 'unknown option' ; then
  unset OCAMLOPT_HAS_G
  AC_MSG_RESULT([no])
else
  OCAMLOPT_HAS_G=-g
  AC_MSG_RESULT([yes])
fi
AC_SUBST(OCAMLOPT_HAS_G)
])
