# Generic GNUMakefile
 
# Just a snippet to stop executing under other make(1) commands
# that won't understand these lines
ifneq (,)
This makefile requires GNU Make.
endif

PROGRAM = sensor
C_FILES := $(wildcard *.c)
OBJS := $(patsubst %.c, %.o, $(C_FILES))
CC = cc
CFLAGS = -Wall -pedantic -std=c99 -ggdb
LDFLAGS =

all: $(PROGRAM)

$(PROGRAM): .depend $(OBJS)
	gcc $(CFLAGS) $(OBJS) $(LDFLAGS) -o $(PROGRAM)

depend: .depend

.depend: cmd = gcc -MM -MF depend $(var); cat depend >> .depend;
.depend:
	@echo "Generating dependencies..."
	@$(foreach var, $(C_FILES), $(cmd))
	@rm -f depend

-include .depend

# These are the pattern matching rules. In addition to the automatic
# variables used here, the variable $* that matches whatever % stands for
# can be useful in special cases.
%.o: %.c
	gcc $(CFLAGS) -c $< -o $@

%: %.c
	gcc $(CFLAGS) -o $@ $<

clean:
	rm -f .depend *.o

.PHONY: clean depend