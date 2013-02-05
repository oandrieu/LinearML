AC_INIT([LinearML], [0.0.1])
AC_PRESERVE_HELP_ORDER


# Detect compilers
AC_PROG_AWK
AC_PROG_OCAML
AC_PROG_CC
AC_SUBST([AR],[ar])


# Detect LLVM install
AC_CHECK_PROG([LLC], [llc], [llc])
test -z "$LLC" && AC_MSG_ERROR([cannot find llc])
AC_CHECK_PROG([OPT], [opt], [opt])
test -z "$OPT" && AC_MSG_ERROR([cannot find opt])
$LLC -version | grep version

AC_MSG_CHECKING([LLVM OCaml bindings])
AC_ARG_VAR([LLVM_DIR],[directory of LLVM OCaml bindings])
_ocaml_libdir="$($OCAMLC -where)"
unset _llvm_dir
for d in "$LLVM_DIR" "$_ocaml_libdir" ; do
    if test -r "$d/llvm.a" ; then
       AC_MSG_RESULT([$d])
       _llvm_dir="$d"
       break
    fi
done
if test -z "$_llvm_dir" ; then
  AC_MSG_RESULT([no])
  AC_MSG_ERROR([cannot find LLVM OCaml bindings])
fi
LLVM_DIR="$_llvm_dir"
test "$LLVM_DIR" != "$_ocaml_libdir" && LLVM_INCLUDE="-I $LLVM_DIR"
AC_SUBST([LLVM_INCLUDE])


# Check C type sizes
AC_CHECK_SIZEOF([long])
AC_CHECK_SIZEOF([void *])


# Configure the linml compiler
echo
_type_size="${ac_cv_sizeof_long}:${ac_cv_sizeof_void_p}"
AS_IF(
[test "$_type_size" == "4:4"],[
echo -e "Architecture\t\t: 32 bits"
march=ARCH_32
stack_align=4
trampoline_size=10
max_reg_ret=4
data_layout="s0:32:32"
AC_DEFINE([ARCH_32])],

[test "$_type_size" == "8:8"],[
echo -e "Architecture\t\t: 64 bits (LP64)"
march=ARCH_64
stack_align=8
trampoline_size=16
max_reg_ret=4
data_layout="s0:64:64"
AC_DEFINE([ARCH_64])],

[test "$_type_size" == "4:8"],[
echo -e "Architecture\t\t: 64 bits (LLP64)"
AC_MSG_ERROR([Unsupported architecture])],

[AC_MSG_ERROR([Unknown architecture])]
)
AC_SUBST([march])
AC_SUBST([stack_align])
AC_SUBST([trampoline_size])
AC_SUBST([max_reg_ret])
AC_SUBST([data_layout])

echo -e "Stack alignment\t\t: $stack_align"
echo -e "Trampoline size\t\t: $trampoline_size"
echo -e "Return in registers\t: $max_reg_ret"
echo


# linml stdlib
AC_ARG_VAR([stdlibdir],[linml stdlib directory])
AS_IF([test -z "$stdlibdir"], [stdlibdir="$PWD/stdlib"])


AC_CONFIG_FILES([Makefile.config])
AC_CONFIG_HEADERS([stdlib/config.h])
AC_CONFIG_FILES([compiler/genGlobals.ml])
AC_OUTPUT
