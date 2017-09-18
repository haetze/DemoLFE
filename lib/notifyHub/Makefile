CWD != pwd
NAME=$(CWD:T)
ERL_FILES != ls src/*.erl || echo ""
LFE_FILES != ls src/*.lfe || echo ""
ERL_BEAM_FILES = ${ERL_FILES:S/src/ebin/:.lfe=.beam}
LFE_BEAM_FILES = ${LFE_FILES:S/src/ebin/:.lfe=.beam}
TESTS = 0

.if $(TESTS) == 0
FLAGS=-DNOTEST -o ebin
.else
FLAGS=-o ebin
.endif

.SUFFIXES: .erl .lfe .beam

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

$(LFE_BEAM_FILES): $(.PREFIX:S/ebin/src/).lfe
	lfec -o ebin src/$(.PREFIX).lfe
.if $(TESTS) == 12 ##lfe doesn't use eunit (yet?)
	cd ebin && \
	lfe -noshell -run $(.PREFIX:T) test  -run init stop > ../tests/$(.PREFIX:T).test_log
.endif

$(ERL_BEAM_FILES): $(.PREFIX:S/ebin/src/).erl
	erlc  $(FLAGS) src/$(.PREFIX).erl
.if $(TESTS) == 1
	cd ebin && \
	erl -noshell -run $(.PREFIX:T) test  -run init stop > ../tests/$(.PREFIX:T).test_log
.endif


compile:  $(ERL_BEAM_FILES) $(LFE_BEAM_FILES)

build: compile

install: build boot

boot: ebin/$(NAME).app ebin/$(NAME).rel
	cp create_boot.beam ./ebin/  && \
	cd ebin			     && \
	lfe -noshell -run create_boot create $(NAME) -run init stop && \
	rm create_boot.beam          && \
	cp $(NAME).boot ../ 


