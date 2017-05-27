NAME=default


package-init:
	mkdir $(NAME)
	mkdir ./$(NAME)/src
	mkdir ./$(NAME)/ebin
	mkdir ./$(NAME)/include
	mkdir ./$(NAME)/priv
	cp ../default.app ebin/$(NAME).app
	cp ../default.rel ebin/$(NAME).rel
