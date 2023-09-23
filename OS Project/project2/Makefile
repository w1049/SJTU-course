SRC = $(wildcard *.c)
CC = gcc
CFLAGS += -Wall -Werror -lpthread

all: LCM faneuil

LCM: LarryCurlyMoe.c
	$(CC) $(CFLAGS) $^ -o $@

faneuil: faneuil.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f LCM faneuil

.PHONY: all clean
