TARGET = lie_detector

CC = gcc
CFLAGS = -Wall -g 
NASM = nasm   
NASMFLAGS = -f elf64 -F stabs  

OBJS = asm_stat.o 

all: $(TARGET)

default: $(TARGET)  

$(TARGET): main.c $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET)  $(OBJS)  main.c

asm_stat.o: asm_stat.asm
	$(NASM) $(NASMFLAGS) asm_stat.asm -o asm_stat.o

clean: 
	rm $(TARGET) $(OBJS)

# uninstall: 
# 	rm /opt/$(TARGET)

# install: $(TARGET)
# 	install -o root -g root -m 4111 $(TARGET) /opt/$(TARGET)

