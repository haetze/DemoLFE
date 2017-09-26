# Author: Richard Stewing
# Init for variables
CWD           != pwd
# Name of the application, should be set after package-init
NAME           = uno
# List of Erlang-Source files in src
ERL_FILES     != ls src/*.erl || echo ""
# List of LfE-Source files in src
LFE_FILES     != ls src/*.lfe || echo ""
# List of Beam-files 
ERL_BEAM_FILES = ${ERL_FILES:S/src/ebin/:.lfe=.beam}
LFE_BEAM_FILES = ${LFE_FILES:S/src/ebin/:.lfe=.beam}
# run test in compile/build phase (not supportet for LfE yet
TESTS          = 0
# Suffixes that are used in Package
.SUFFIXES: .erl .lfe .beam .boot .rel .app

# sets the flags accordingly
.if $(TESTS) == 1
FLAGS          = -o ebin
.else
FLAGS          = -DNOTEST -o ebin
.endif


# creates directory structure for a package with a given Name
# $(Name).app and $(Name).rel need to be added
package-init:
	mkdir $(NAME)
	mkdir ./$(NAME)/src
	mkdir ./$(NAME)/ebin
	mkdir ./$(NAME)/include
	mkdir ./$(NAME)/priv
	mkdir ./$(NAME)/tests
	cp create_boot.beam ./$(NAME)/
	cp default.app ./$(NAME)/ebin/$(NAME).app
	cp default.rel ./$(NAME)/ebin/$(NAME).rel
	cp Makefile ./$(NAME)/Makefile

# compiles .lfe files 
$(LFE_BEAM_FILES): $(.PREFIX:S/ebin/src/).lfe
	lfec -o ebin src/$(.PREFIX:T).lfe
.if $(TESTS) == 12 ##lfe doesn't use eunit (yet?)
	cd ebin && \
	lfe -noshell -run $(.PREFIX:T) test  -run init stop > ../tests/$(.PREFIX:T).test_log
.endif

# compiles .erl files and runs tests if set
$(ERL_BEAM_FILES): $(.PREFIX:S/ebin/src/).erl
	erlc  $(FLAGS) src/$(.PREFIX:T).erl
.if $(TESTS) == 1
	cd ebin && \
	erl -noshell -run $(.PREFIX:T) test  -run init stop > ../tests/$(.PREFIX:T).test_log
.endif

# unifies erl and lfe file compilation
compile:  $(ERL_BEAM_FILES) $(LFE_BEAM_FILES)
#alias for compile
build: compile

# rebuild project and creates boot file 
create-boot-file: build boot-file

# creates boot file 
boot-file: ebin/$(NAME).app ebin/$(NAME).rel
	cp create_boot.beam ./ebin/  && \
	cd ebin			     && \
	lfe -noshell -run create_boot create $(NAME) && \
	rm create_boot.beam          && \
	cp $(NAME).boot ../ 


