TARGET = stat_liar.so

CC = gcc
CFLAGS = -Wall -g 
default = $(TARGET)  

$(TARGET): stat_liar.c
	$(CC) -shared stat_liar.c -fPIC -ldl $(CFLAGS) -o $(TARGET)

clean:
	rm $(TARGET)
