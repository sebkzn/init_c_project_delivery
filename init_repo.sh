#!/bin/bash
##
## EPITECH PROJECT, 2020
## Init Repository | sebastien.raoult@epitech.eu
## File description:
## clone project repository and create the basic architecture for Epitech projects.
##

show_help() {
    echo """
USAGE:
    ./init_repo.sh [-l|--lib] <libmy_path> [-b|--binary] <binary_name> <repo_url>

DESCRIPTION:
    clone project repository and create the basic architecture for Epitech projects.

EXAMPLE:
    ./init_repo.sh --lib \"~/epitech/lib/my\" -b my_ls git@github.com:EpitechIT2020/B-EPITECH-PROJECT-1-1-firstname.lastname.git
"""
}

create_base_tree() {
    project_name="$1"
    libmy_path="$2"
    mkdir include && mkdir src && mkdir tests && mkdir lib && mkdir bonus
    cp -r $libmy_path ./lib/
    cp ./lib/my/my.h ./include/
    cat << "EOF" > main.c
/*
** EPITECH PROJECT, 2020
** project_name
** File description:
** main
*/

#include "my.h"

int main(int argc, char * const *argv)
{
    return (0);
}
EOF
    sed -i "s/project_name/${project_name}/g" main.c
    touch src/.gitkeep
    touch tests/.gitkeep
}

create_makefile() {
    binary_name="$1"
    project_name="$2"
    cat << "EOF" > Makefile
##
## EPITECH PROJECT, 2020
## project_name
## File description:
## Makefile
##

NAME      = binary_name

CC        = gcc -g

RM        = rm -f

SRCS      = $(wildcard ./*.c) $(wildcard ./src/*.c) $(wildcard ./src/**/*.c)
OBJS      = $(SRCS:.c=.o)

CFLAGS 	  += -I ./include -Wall -Wextra
LDFLAGS   = -L ./lib/my
LDLIBS    = -lmy

all: $(NAME)

$(NAME): $(OBJS)
	 $(MAKE) -C ./lib/my
	 $(CC) $(CFLAGS) $(OBJS) -o $(NAME) $(LDFLAGS) $(LDLIBS)

clean:
	$(RM) $(OBJS)
	$(MAKE) -C ./lib/my clean

fclean: clean
	$(RM) $(NAME)
	$(MAKE) -C ./lib/my fclean

re: fclean all

.PHONY: all clean fclean re
EOF
    sed -i "s/binary_name/${binary_name}/g" Makefile
    sed -i "s/project_name/${project_name}/g" Makefile
}

create_gitignore() {
    binary_name="$1"
    cat << "EOF" > .gitignore
###folders##
bonus/
bin/

###files##
binary_name
a.out
*.a
*.o
unit_tests
*.gcno
*.gcda
*~
\#*\#
EOF
    sed -i "s/binary_name/${binary_name}/g" .gitignore
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -h|--help)
        show_help
        exit 0
        ;;
        -b|--binary)
        binary_name="$2"
        shift
        shift
        ;;
        -l|--lib)
        libpath="$2"
        shift
        shift
        ;;
        *)
        POSITIONAL+=("$1")
        shift
        ;;
    esac
done
set -- "${POSITIONAL[@]}"
if [[ -n $1 ]]; then
    repo_url="$1"
fi

if git clone -q $repo_url; then
    repo_dir=$(echo "$repo_url" | cut -d '/' -f2 | sed 's/\.git//g')
    cd $repo_dir;
    create_base_tree $repo_dir $libpath && create_gitignore $binary_name && create_makefile $binary_name $repo_dir
    echo "repository created with basic architecture"
    echo -n "Do you want to push your repository? [y/n]: "
    read ans
    if [[ $ans == n || $ans == no ]]; then
        echo "bye"
        exit 0
    else
        git add .
        git commit -m "Initial commit with usual project architecture"
        git push origin master
    fi
else
    echo "error" >&2
    exit 84
fi
