//
// Multiply two matrices using O(n^3) algorithm
//
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static inline int *create(int n) {
    return calloc(n * n, sizeof(int));
}

static inline void read_matrix(int *A, int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            scanf("%d", A + i * n + j);
}

static inline void print_matrix(int *A, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++)
            printf("%d ", A[i * n + j]);
        printf("\n");
    }
}

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

int main() {
    freopen("data.in", "r", stdin);
    freopen("data.out", "w", stdout);

    scanf("%d", &n);
    A = create(n);
    B = create(n);
    C = create(n);

    read_matrix(A, n);
    memcpy(B, A, n * n * sizeof(int));

    // if n is too small, we don't need block
    if (bsize > n) bsize = n;

    for (int sj = 0; sj < n; sj += bsize)
        for (int si = 0; si < n; si += bsize)
            for (int sk = 0; sk < n; sk += bsize)
                do_block(n, A, B, C, si, sj, sk);

    print_matrix(C, n);

    free(A);
    free(B);
    free(C);
}
