SRC = $(wildcard *.c)
ELF = $(SRC:%.c=%)
CC = gcc
CFLAGS += -Wall -Werror

all: $(ELF)

multi: multi.c
	$(CC) $(CFLAGS) $^ -o $@ -lpthread

clean:
	rm -f $(ELF) multitest

.PHONY: all clean
