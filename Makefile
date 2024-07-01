## -*- mode: makefile-gmake -*-

EMACS	    = emacs
EMACS_BATCH = $(EMACS) -batch

TARGET = $(patsubst %.el,%.elc,init.el)

DIRS    = lisp
SUBDIRS = $(shell find $(DIRS) -maxdepth 2	\
		       ! -name .git		\
		       ! -name doc		\
		       ! -name test		\
		       ! -name tests		\
		       ! -name obsolete		\
		       -type d -print)

MY_LOADPATH = -L . $(patsubst %,-L %, $(SUBDIRS))
BATCH_LOAD  = $(EMACS_BATCH) $(MY_LOADPATH)

.PHONY: test build clean

# Main rule
all: init.elc

# Generate lisp and compile it
init.el: init.org
	@rm -f $@
	@$(BATCH_LOAD)						\
		--eval "(require 'org)"				\
		--eval "(org-babel-load-file \"init.org\")"
	@chmod 444 $@

init.elc: init.el

%.elc: %.el
	@echo Compiling file $<
	@$(BATCH_LOAD) -f batch-byte-compile $<

speed: init.elc
	time $(BATCH_LOAD) -Q -L . -l init		\
	    --eval "(message \"Hello, world\!\")"

slow: init.elc
	time $(BATCH_LOAD) -Q -L . -l init --debug-init	\
	    --eval "(message \"Hello, world\!\")"

clean:
	rm -f init.el *.elc *~
