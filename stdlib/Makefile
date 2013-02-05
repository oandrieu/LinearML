include ../Makefile.config

CC_OPT = -O3

default: libliml.a

SOURCES =\
	thread.c\
	array.c\
	print.c\
	math.c\
	string.c\
	share.c\
	debug.c

LML_SOURCES =\
	option.lml\
	pervasives.lml\
	array.lml \
	print.lml \
	string.lml \
	math.lml \
	thread.lml\
	share.lml\
	closure.lml\
	list.lml

OBJECTS = $(SOURCES:.c=.o)	

libliml.a: $(OBJECTS) $(LML_SOURCES) ../compiler/limlc
	../compiler/limlc -no-stdlib $(LML_SOURCES) -lib libliml.lmli 
	$(AR) rc libliml.a $(OBJECTS)

##############################################################################

%.o : %.c
	$(CC) $(CC_OPT) -Wall -c $<


###############################################################################

clean: 
	rm -f *.o *~ libliml.a \#*

