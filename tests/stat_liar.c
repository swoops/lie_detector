#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>
#include <sys/stat.h> /*stat*/

extern int __xstat (int __ver, const char *__filename, struct stat *__stat_buf){
    static int (*original_stat) (int __ver, const char *__filename, struct stat *__stat_buf) = NULL;
    if ( original_stat == NULL ){
      original_stat = dlsym(RTLD_NEXT, "__xstat");
      if ( ! original_stat ){
        perror("original_stat null");
        exit(-1);
      }
    }

    int ret = original_stat(__ver, __filename, __stat_buf);
    int r = random()%100;
    fprintf(stderr, "[__xstat LIAR] I Lied on file: %s, realsize: %lld, fake: %lld\n",
      __filename, (long long) __stat_buf->st_size, (long long)
      __stat_buf->st_size+r);

    __stat_buf->st_size += r;

    return ret;
}
