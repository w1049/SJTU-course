#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define M (1024 * 1024 / 8) /* 1 MiB */

int main(int argc, char *argv[]) {
    freopen("test.in", "w", stdout);
    int n = 0;
    if (argc >= 2)
        n = atoi(argv[1]);
    n = n ? n * M : 128 * M;
    for (int i = 0; i < n; i++)
        printf("%08x", rand());
    fclose(stdout);
}

