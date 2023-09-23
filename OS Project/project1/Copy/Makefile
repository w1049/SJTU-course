TARGET = Copy

SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)
ELF = $(SRC:%.c=%)
ELF += Copytest
CC = gcc
CFLAGS += -Wall -Werror

ifeq ($(TIME),1)
CFLAGS += -DTIME1
else ifeq ($(TIME),2)
CFLAGS += -DTIME2
endif

ifeq ($(MINI),1)
CFLAGS += -DMINI
endif

app: $(TARGET)

clean:
	rm -f $(OBJ) $(ELF)

$(TARGET): $(TARGET).o
	$(CC) $(CFLAGS) $^ -o $@

test: Copy.c test.c gen
	$(CC) $(CFLAGS) -DTEST Copy.c -o Copytest
	$(CC) $(CFLAGS) test.c -o test
	./test

gen: gen.o
	$(CC) $(CFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: app test gen clean
