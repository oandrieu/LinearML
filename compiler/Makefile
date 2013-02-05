
include ../Makefile.config

LLVM_LIBS = llvm.cma llvm_analysis.cma llvm_bitwriter.cma llvm_scalar_opts.cma llvm_target.cma

OCAMLC_OPTS = -dtypes -warn-error A
OCAML_INCLUDE = $(LLVM_INCLUDE)
LIBS = unix.cma $(LLVM_LIBS)
LIBSOPT = $(LIBS:.cma=.cmxa)

default: limlc

OBJECTS_ML = \
	genGlobals.ml\
	global.ml\
	pos.ml\
	ident.ml\
	utils.ml\
	error.ml\
	ast.ml\
	lexer.ml\
        parser.ml\
	nast.ml\
	naming.ml\
	nastCheck.ml\
	neast.ml\
	nastExpand.ml\
	neastCheck.ml\
	tast.ml\
	typing.ml\
	stast.ml\
	stastOfTast.ml\
	stastCheck.ml\
	recordCheck.ml\
	linearCheck.ml\
	boundCheck.ml\
	ist.ml\
	istPp.ml\
	istOfStast.ml\
	istTail.ml\
	extractFuns.ml\
	est.ml\
	estSubst.ml\
	estPp.ml\
	estOfIst.ml\
	estOptim.ml\
	estCompile.ml\
	estNormalizePatterns.ml\
	llst.ml\
	llstPp.ml\
	llstOfEst.ml\
	llstFree.ml\
	llstOptim.ml\
	emit.ml\
	eval.ml\
	main.ml
#	istAdhoc.ml

#	boundCheck2.ml\
# 	id.ml\
# 	ast.ml\
# 	astOfCst.ml\
# 	statesOfAst.ml
#	istRecords.ml\
	istOptim.ml\


OBJECTS_CMO = $(OBJECTS_ML:.ml=.cmo)	
OBJECTS_CMX = $(OBJECTS_ML:.ml=.cmx)	

limlc: $(OBJECTS_CMX)
	$(OCAMLOPT) -o $@ -g $(OCAML_INCLUDE) $(LIBSOPT) -cclib -lstdc++ $(OBJECTS_CMX)

limlc.bc: $(OBJECTS_CMO)
	$(OCAMLC) -o $@ -g $(OCAML_INCLUDE) $(OCAMLC_OPTS) $(LIBS) -cclib -lstdc++ $(OBJECTS_CMO)

##############################################################################

%.cmo : %.ml
	$(OCAMLC) $(OCAML_INCLUDE) $(OCAMLC_CFLAGS) -c -g $<

%.cmi : %.mli
	$(OCAMLOPT) $(OCAMLOPT_CFLAGS) $(OCAML_INCLUDE) $<  

%.cmx : %.ml
	$(OCAMLOPT) $(OCAMLOPT_CFLAGS) $(OCAML_INCLUDE) $(PP) -c $<  

%.ml : %.mll
	$(OCAMLLEX) $<

%.ml %.mli : %.mly
	$(OCAMLYACC) $<

###############################################################################

.depend: $(OBJECTS_ML)
	$(OCAMLDEP) -native -slash $(OCAML_INCLUDE) $(OBJECTS_ML) > .depend

clean: 
	rm -f *.cm* *.o* lexer.ml parser.ml parser.mli
	rm -f limlc limlc.bc liml liml.bc *.annot .depend
	rm -f test/*.o test/*.s 
	rm -f test/*.bc test/*~
	$(MAKE) -C ../stdlib clean

-include .depend
