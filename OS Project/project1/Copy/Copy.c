//
// Copy a file using two processes.
// The two processes communicate using pipe system call.
//

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

#if defined(TIME1) || defined(TIME2)
#include <time.h>
#else
#include <sys/time.h>
#endif

#define ERROR "\033[31m[Error]\033[0m "

int main(int argc, char *argv[]) {
    if (argc < 3)
        errx(1, "Usage: %s <InputFile> <OutputFile> [BufferSize]", argv[0]);

    // open files
    FILE *src, *dest;
    src = fopen(argv[1], "r");
    if (!src) err(1, ERROR "%s", argv[1]);

    dest = fopen(argv[2], "w");
    if (!dest) fclose(src), err(1, ERROR "%s", argv[2]);

    // create a buf
    int bufsize = argc >= 4 ? atoi(argv[3]) : 131072;
    if (bufsize <= 0) errx(1, ERROR "Invalid buffer size: %s -> %d", argv[3], bufsize);
    char *buf = malloc(bufsize);

    // create a pipe
    int pipefd[2];
    if (pipe(pipefd) == -1) err(1, ERROR "Failed to pipe");

    // fork
    pid_t pid = fork();
    if (pid == -1) err(1, ERROR "Failed to fork");
    else if (pid) {
        // parent
        // close unused
        fclose(src);
        close(pipefd[1]);

        // timer
        double elapsed;
#ifdef TIME1
        clock_t start, end;
        start = clock();
#elif TIME2
        struct timespec start, end;
        clock_gettime(CLOCK_MONOTONIC_COARSE, &start);
#else
        struct timeval start, end;
        gettimeofday(&start, NULL);
#endif

        // read from pipe, write to file
        int readbytes;
        while ((readbytes = read(pipefd[0], buf, bufsize)) > 0) {
            fwrite(buf, readbytes, 1, dest);
            if (ferror(dest)) err(1, ERROR "Writing file");
        }
        if (readbytes == -1) err(1, ERROR "Reading pipe");
        
#ifndef TEST
        printf("Write file end.\n");
#endif
        close(pipefd[1]);
        fclose(dest);
        
        // wait for child
        int status = 0;
        wait(&status);
        if (status) errx(1, ERROR "Child exited with code %d", status);

#ifdef TIME1
        end = clock();
        elapsed = (end - start) * 1000.0 / CLOCKS_PER_SEC;
#elif TIME2
        clock_gettime(CLOCK_MONOTONIC_COARSE, &end);
        elapsed = (end.tv_sec - start.tv_sec) * 1000 +
            (double)(end.tv_nsec - start.tv_nsec) / 1000000;
#else
        gettimeofday(&end, NULL);
        elapsed = (end.tv_sec - start.tv_sec) * 1000 +
            (double)(end.tv_usec - start.tv_usec) / 1000;
#endif
#ifndef TEST
        printf("\033[32mSuccess!\033[0m Time used: %f ms\n", elapsed);
#else
        printf("%f\n", elapsed);
#endif
    } else {
        // child
        // close unused
        fclose(dest);
        close(pipefd[0]);

        // read until EOF, write to pipe
        int readbytes;
        while ((readbytes = fread(buf, 1, bufsize, src)) > 0)
            if (write(pipefd[1], buf, readbytes) == -1) err(1, ERROR "Writing pipe");
        if (ferror(src)) err(1, ERROR "Reading file");
#ifndef TEST
        printf("Read file end.\n");
#endif
        // close the pipe, send EOF
        close(pipefd[1]);
        fclose(src);
    }

    // don't forget to free buf
    free(buf);
    exit(0);
}
