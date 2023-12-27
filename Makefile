# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: akdovlet <akdovlet@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/27 23:52:43 by akdovlet          #+#    #+#              #
#    Updated: 2023/12/27 23:53:28 by akdovlet         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libftprintf.a

INCLUDES := include/ft_printf.h

SRCS := c_handler.c \
		d_handler.c \
		ft_draft.c \
		ft_printf.c \
		p_handler.c \
		s_handler.c \
		u_handler.c \
		x_handler.c \
		ft_int.c	\
		parsing.c	\
		pad_manager.c
SRCS := $(addprefix srcs/, $(SRCS))

OBJS = $(patsubst srcs/%.c,objs/%.o,$(SRCS))

CC := cc
CFLAGS := -Wall -Werror -Wextra

COLORS := $(shell seq 31 37)

all: create_dirs $(NAME) $(INCLUDES)

main: main.c libftprintf.a
	@cc ${CFLAGS} main.c libftprintf.a && ./a.out

create_dirs:
	@if [ ! -d "objs" ]; then mkdir objs; fi

objs/%.o: srcs/%.c $(INCLUDES)
	@COLOR_CODE=$$(echo "$(COLORS)" | awk '{srand(); print int(rand()*7)}'); \
	printf "\033[1;%sm\t\tCompiling: $<\033[0m\r" $$((30+COLOR_CODE));
	@$(CC) $(CFLAGS) -c $< -o $@;

bonus: all

clean:
	@if [ -d "objs" ]; then rm -rf objs && echo "\033[0;32mObject files have been deleted\033[0m"; fi

fclean: clean
	@if [ -f "libftprintf.a" ]; then rm -rf libftprintf.a  && echo "\033[0;32mLibray file has been deleted\033[0m"; fi

re: fclean all

$(NAME): $(OBJS)
	@ar rc $(NAME) $(OBJS)

.PHONY: all clean fclean re create_dirs main
