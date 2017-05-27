NAME="default"

package-init:
	mkdir $(NAME)
	mkdir ./$(NAME)/src
	mkdir ./$(NAME)/ebin
	mkdir ./$(NAME)/include
	mkdir ./$(NAME)/priv
	cp default.app ./$(NAME)/ebin/$(NAME).app
	cp default.rel ./$(NAME)/ebin/$(NAME).rel
	cp Makefile ./$(NAME)/Makefile
	cp create_boot.lfe ./$(NAME)/src/create_boot.lfe

compile:
	lfec -o src src/*.lfe 
	cd ..

build: compile
	cp src/*.beam ebin/
	cp src/create_boot.beam ./

install: build
	cp ebin/$(NAME).rel ./
	cp ebin/$(NAME).app ./
	lfe -noshell -run create_boot create $(NAME) -run init stop 
	cp $(NAME).script ebin/$(NAME).script
	cp $(NAME).boot ebin/$(NAME).boot
	rm $(NAME).rel
	rm $(NAME).script
	rm $(NAME).app
