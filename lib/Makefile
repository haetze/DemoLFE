CWD != pwd
NAME=$(CWD:T)
ERL_FILES != ls src/*.erl || echo ""
ERL_OUTPUT_FILES = ${ERL_FILES:.erl=.beam}
LFE_FILES != ls src/*.lfe || echo ""
LFE_OUTPUT_FILES = ${LFE_FILES:.lfe=.beam}


package-init:
	mkdir $(NAME)
	mkdir ./$(NAME)/src
	mkdir ./$(NAME)/ebin
	mkdir ./$(NAME)/include
	mkdir ./$(NAME)/priv
	cp default.app ./$(NAME)/ebin/$(NAME).app
	cp default.rel ./$(NAME)/ebin/$(NAME).rel
	cp Makefile ./$(NAME)/Makefile

$(LFE_OUTPUT_FILES): $(LFE_FILES) 
	lfec -o src $(.TARGET:R).lfe 

$(ERL_OUTPUT_FILES): $(ERL_FILES)
	erlc -o src $(.TARGET:R).erl 

compile:  ${LFE_OUTPUT_FILES} ${ERL_OUTPUT_FILES}
	echo "compiled"

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
