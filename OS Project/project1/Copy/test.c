#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
#ifndef MINI
    int g = 16; // Test times
    int a[] = {
        1, 4, 8, 16, 32, 64,
        128, 256
    }; // file size (MiB)
    int b[] = {
        64, 128, 256,
        512, 1024, 2048, 4096,
        8192, 16384, 32768, 65536,
        131072, 262144, 524288
    }; // buffer size (B)
#else
    int g = 1;
    int a[] = {
        32, 64, 128
    };
    int b[] = {
        512, 1024, 4096, 8192,
        32768, 65536, 131072, 262144
    }; // buffer size (B)
#endif

    int asize = sizeof(a) / sizeof(int);
    int bsize = sizeof(b) / sizeof(int);
    char cmd[256];
    char buf[256];
    FILE *test = fopen("test.txt", "w");
    for (int j = 0; j < asize; j++) { 
        sprintf(cmd, "./gen %d", a[j]);
        system(cmd);
        for (int k = 0; k < bsize; k++) {
            int bufsize = b[k];
            sprintf(cmd, "./Copytest test.in test.out %d", bufsize);
            double total = 0;
            printf("File %d MiB, Buffer %d B\n", a[j], bufsize);
            for (int i = 0; i < g; i++) {
                system("rm test.out");
                FILE *fp = popen(cmd, "r");
                fread(buf, 256, 1, fp);
                double runtime;
                sscanf(buf, "%lf", &runtime);
                total += runtime;
                printf("%d: %f\n", i, runtime);
                pclose(fp);
            }
            fprintf(test, "%d %d %f\n", a[j], bufsize, total / g);
        }
    }
    system("rm test.in test.out");
    fclose(test);
}
