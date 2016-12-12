#include <stdio.h>
#include <sys/stat.h> /*stat*/
#include <string.h>   /*strcmp*/
#include "asm_stat.h"


int main(int argc, char *argv[]){
  int i=1, ret=0, one_flag=0;
	struct stat s;
	struct stat a;
  
  if ( argc <= 1  ){
    fprintf(stderr, "usage: %s [-1] [FILE...]\n", argv[0]);
    fprintf(stderr, "\t-1\t:\tStop as soon as one file fails\n");
    return 0;
  }

  /* probably a faster way, but this works for now */
  if ( strcmp(argv[1], "-1") == 0 ){
    i=2; /* start iterating one further in*/
    one_flag = 1;
  }

  for (; i<argc; i++){
    if (stat(argv[i], &s) == -1){
      fprintf(stderr, "%s   ", argv[i]);
      perror("stat: ");
      continue;
    }

    if (asm_stat(argv[i], &a) == -1){
      fprintf(stderr, "%s   ", argv[i]);
      perror("asm_stat: ");
      continue;
    }

    if ( a.st_size != s.st_size ){
      printf("stat(%s) disagrees! stat == %lld != %lld == asm_stat\n", argv[i], (long long) s.st_size, (long long) a.st_size);
      if (one_flag) return 1;
      else ret=1;
    }
    /* else{ printf("%s : %lld fine\n", argv[i], size); } */
  }

  return ret;
}
