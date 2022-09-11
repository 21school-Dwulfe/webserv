NAME 			= webserver

# last slash is requered
SRCS_DIR 		= srcs/
OBJS_DIR 		= objs/
HEADERS_DIR		= srcs/

SRCS 			:= $(shell find ${SRCS_DIR} -type f -name  '*.cpp')
OBJS 			:= $(join $(dir $(SRCS:$(SRCS_DIR)%=$(OBJS_DIR)%)), $(notdir $(SRCS:.cpp=.o)))
HEADERS 		:= $(shell find $(SRCS_DIR) -type f -name '*.hpp') 

FLAGS 			= -Wall -Wextra -Werror -std=c++98
DEBUG 			= -g -fsanitize=address

COMPILE			= c++
RM 				= rm -rf
OPTIM			= -O2



$(OBJS_DIR)%.o:	$(SRCS_DIR)%.cpp $(HEADER)
				@mkdir -p $(dir $@)
				$(COMPILE)  $(FLAGS) -I $(HEADERS_DIR)  -c $< -o $@

all			:	$(NAME)

$(NAME)		:	$(OBJS) $(HEADERS) Makefile
				$(COMPILE) $(FLAGS) $(DEBUG) $(OBJS) -o $(NAME)

$(OBJS)		: | $(OBJS_DIR)

$(OBJS_DIR) :
				mkdir -p  $(OBJS_DIR)

clean		:
				$(RM) $(OBJS_DIR)

fclean		:	clean
				$(RM) $(NAME)

re			:	fclean all

print:
		echo $(SRCS)
		echo $(OBJS)

.PHONY		: all clean fclean re print

# Language: makefile

# FILES 								a/b/c.d 			a/b/e.f

# FILE := $(FILES:a/%=g/%) 				g/b/c.d				g/b/e/f		change main directory

# $(dir $(FILE))       					g/b/ 				g/b/

# $(notdir $(FILE))   					c.d 				e.f

# $(basename $(FILE))  					g/b/c 				g/b/e

# $(suffix $(FILE))    					.d 					.f

# $(addprefix $(FILE), $(SUFFIX))   	$(SUFFIX)g/b/c.d 	g/b/e.f

# $(addsuffix $(FILE), $(PREFIX))   	g/b/c.d$(PREFIX) 	g/b/e.f$(PREFIX)

# $(join $(FILE), $(FILE))  			g/b/c.da/b/e.f