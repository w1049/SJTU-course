//
// Multiply two matrices using O(n^3) algorithm
// with pthread
//
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#include <sys/time.h>
#include <math.h>

static inline int *create(int n) {
    return calloc(n * n, sizeof(int));
}

static inline void read_matrix(int *A, int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            scanf("%d", A + i * n + j);
}

static inline void gen_matrix(int *A, int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            A[i * n + j] = rand() % 100;
}

FILE *fp;

static inline void print_matrix(int *A, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++)
            fprintf(fp, "%d ", A[i * n + j]);
        fprintf(fp, "\n");
    }
}

static inline void print_random_matrix(int *A, int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            fprintf(fp, "%d %d %d\n", i, j, A[i * n + j]);
}

#ifndef NTHREAD
int nthread = 4;
#else
int nthread = NTHREAD;
#endif

int bsize = 32;

int *A, *B, *C;
int n;

void do_block(int n, int *A, int *B, int *C, int si, int sj, int sk) {
    for (int i = si; i < si + bsize; i++)
        for (int j = sj; j < sj + bsize; j++) {
            int cij = C[i * n + j];
            for (int k = sk; k < sk + bsize; k++)
                cij += A[i * n + k] * B[k * n + j];
            C[i * n + j] = cij;
        }
}

struct data {
    int begin, end;
};

void *worker(void *arg_v) {
    struct data *arg = (struct data *)arg_v;
    for (int sj = arg->begin; sj < arg->end; sj++) {
        for (int si = 0; si < n; si += bsize)
            for (int sk = 0; sk < n; sk += bsize)
                do_block(n, A, B, C, si, sj * bsize, sk);
    }
    pthread_exit(0);
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        n = atoi(argv[1]);
        fp = fopen("random.out", "w");
    }
    else {
        freopen("data.in", "r", stdin);
        fp = fopen("data.out", "w");
        scanf("%d", &n);
    }
    A = create(n);
    B = create(n);
    C = create(n);

    if (argc > 1) {
        srand(time(0));
        gen_matrix(A, n);
        gen_matrix(B, n);
    } else {
        read_matrix(A, n);
        memcpy(B, A, n * n * sizeof(int));
    }

#ifdef TIME
    struct timeval start, end;
    gettimeofday(&start, NULL);
#endif

    // if a thread cannot even get one block
    // then use a smaller bsize
    if (bsize * nthread > n) {
        bsize = n / nthread;
        // find the largest power of 2
        while (bsize & (bsize - 1)) bsize &= bsize - 1;
    }
    // if nthread is larger than n
    // don't create so many threads
    if (bsize == 0) bsize = 1, nthread = n;
    
    pthread_t *tid = malloc(nthread * sizeof(pthread_t));
    struct data *arg = malloc(nthread * sizeof(struct data));
    
    // assign blocks to threads
    int tmp = n / bsize / nthread;
    for (int i = 0; i < nthread; i++) {
        pthread_attr_t attr;
        pthread_attr_init(&attr);
        arg[i].begin = i * tmp;
        if (i == nthread - 1) arg[i].end = n / bsize;
        else arg[i].end = i * tmp + tmp;
        pthread_create(tid + i, &attr, worker, arg + i);
    }
    for (int i = 0; i < nthread; i++) pthread_join(tid[i], NULL);

#ifdef TIME
    gettimeofday(&end, NULL);
    double elapsed = (end.tv_sec - start.tv_sec) * 1000 +
        (double)(end.tv_usec - start.tv_usec) / 1000;
    printf("%f", elapsed);
#endif

    if (argc > 1) {
        fprintf(fp, "%d\n", n);
        print_random_matrix(A, n);
        print_random_matrix(B, n);
        print_random_matrix(C, n);
    } else {
        print_matrix(C, n);
    }
    free(A);
    free(B);
    free(C);
    free(tid);
    free(arg);
}
