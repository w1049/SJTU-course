SRC = $(wildcard *.c)
ELF = $(SRC:%.c=%)
CC = gcc
CFLAGS += -Wall -Werror

all: $(ELF)

clean:
	rm -f $(ELF)

.PHONY: all clean
