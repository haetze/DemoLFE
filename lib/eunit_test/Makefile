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
	cp create_boot.beam ./$(NAME)/
	cp default.app ./$(NAME)/ebin/$(NAME).app
	cp default.rel ./$(NAME)/ebin/$(NAME).rel
	cp Makefile ./$(NAME)/Makefile

$(LFE_OUTPUT_FILES): $(LFE_FILES) 
	lfec -o ebin $(.PREFIX).lfe
.if $(TESTS) == 1
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


install: build
	cp src/$(NAME).rel ./ebin/  && \
	cp src/$(NAME).app ./ebin/  && \
	cd src			    && \
	lfe -noshell -run create_boot create $(NAME) -run init stop && \
	cp $(NAME).script ../ebin/$(NAME).script && \
	cp $(NAME).boot ../ebin/$(NAME).boot && \
	cp $(NAME).boot ../ 
