# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: akdovlet <akdovlet@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/27 23:52:43 by akdovlet          #+#    #+#              #
#    Updated: 2024/01/03 20:31:19 by akdovlet         ###   ########.fr        #
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

OBJS := $(patsubst srcs/%.c,objs/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

CC := cc
CFLAGS := -Wall -Werror -Wextra -MMD -MP -Iinclude

COLORS := $(shell seq 31 37)

all: create_dirs $(NAME)

main: main.c libftprintf.a
	@cc ${CFLAGS} main.c libftprintf.a && ./a.out

create_dirs:
	@if [ ! -d "objs" ]; then mkdir objs; fi

objs/%.o: srcs/%.c
# @COLOR_CODE=$$(echo "$(COLORS)" | awk '{srand(); print int(rand()*7)}');
	@printf "\033[0;32%sm\tCompiling: $<\033[0m\n";
	@$(CC) $(CFLAGS) -c $< -o $@;

bonus: all

clean:
	@if [ -d "objs" ]; then rm -rf objs && echo "\t\033[1;31mObject files have been deleted\033[0m"; fi

fclean: clean
	@if [ -f "libftprintf.a" ]; then rm -rf libftprintf.a  && echo "\t\033[1;31mLibray file has been deleted\033[0m"; fi

re: fclean all

$(NAME): $(OBJS)
	@ar rc $(NAME) $(OBJS)

-include $(DEPS)

.PHONY: all clean fclean re create_dirs main
