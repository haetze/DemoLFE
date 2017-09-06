CWD != pwd
NAME=$(CWD:T)
ERL_FILES != ls src/*.erl || echo ""
ERL_OUTPUT_FILES = ${ERL_FILES:.erl=.beam}
LFE_FILES != ls src/*.lfe || echo ""
LFE_OUTPUT_FILES = ${LFE_FILES:.lfe=.beam}
TESTS = 0

.if $(TESTS) == 1
FLAGS = -o ebin
.else
FLAGS = -DNOTEST -o ebin
.endif

.SUFFIXES: .erl .lfe .beam 

package-init:
	mkdir $(NAME)
	mkdir ./$(NAME)/src
	mkdir ./$(NAME)/ebin
	mkdir ./$(NAME)/include
	mkdir ./$(NAME)/priv
	mkdir ./$(NAME)/tests
	cp default.app ./$(NAME)/ebin/$(NAME).app
	cp default.rel ./$(NAME)/ebin/$(NAME).rel
	cp Makefile ./$(NAME)/Makefile

##Needs to integrate tests in lfe
##ltest, what supposed to be eunit for lfe has some bullshit dependencies (rebar)
##no idea why someone decided it was a good idea to make a new framework instead of making eunit work with lfe
$(LFE_OUTPUT_FILES): $(LFE_FILES) 
	lfec -o ebin  $(.PREFIX).lfe
.if $(TESTS) == 2
	cd ebin && \
	lfe -noshell -run $(.PREFIX:T) test  -run init stop > ../tests/$(.PREFIX:T).test_log
.endif

$(ERL_OUTPUT_FILES): $(ERL_FILES)
	erlc  $(FLAGS) $(.PREFIX).erl
.if $(TESTS) == 1
	cd ebin && \
	erl -noshell -run $(.PREFIX:T) test  -run init stop > ../tests/$(.PREFIX:T).test_log
.endif

compile:  ${LFE_OUTPUT_FILES} ${ERL_OUTPUT_FILES}


build: compile
	cp src/*.beam ebin/
	cp src/create_boot.beam ./

install: build
	cp src/$(NAME).rel ./ebin/  && \
	cp src/$(NAME).app ./ebin/  && \
	cd src			    && \
	lfe -noshell -run create_boot create $(NAME) -run init stop && \
	cp $(NAME).script ../ebin/$(NAME).script && \
	cp $(NAME).boot ../ebin/$(NAME).boot && \
	cp $(NAME).boot ../ 
