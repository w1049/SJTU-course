//
// Larry, Curly and Moe are planting seeds.
// Larry digs the holes.
// Moe places a seed in each hole.
// Curly then fills the hole up.
//

#include <stdio.h>
#include <stdlib.h>
#include <err.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#include <time.h>

const int MAXSLEEP = 50; // ms
#define SLEEP usleep(rand() % MAXSLEEP * 1000)

int endnum = 123; // num to exit the program

// semaphores
sem_t shovel, filled, unfilled, planted;

void *Larry() {
    int id = 0;
    while (1) {
        sem_wait(&filled);
        sem_wait(&shovel); // require the shovel when larry can dig
 
        SLEEP;
        printf("Larry digs another hole #%d.\n", ++id);

        sem_post(&shovel);
        sem_post(&unfilled);
        SLEEP;
        if (id >= endnum) pthread_exit(0);
    }
}

void *Moe() {
    int id = 0;
    while (1) {
        sem_wait(&unfilled);
        
        SLEEP;
        printf("Moe plants a seed in a hole #%d.\n", ++id);
        
        sem_post(&planted);
        SLEEP;
        if (id >= endnum) pthread_exit(0);
    }
}

void *Curly() {
    int id = 0;
    while (1) {
        sem_wait(&planted);
        sem_wait(&shovel); // require the shovel when there's a planted hole

        SLEEP;
        printf("Curly fills a planted hole #%d.\n", ++id);

        sem_post(&shovel);
        sem_post(&filled);
        SLEEP;
        if (id >= endnum) pthread_exit(0);
    }
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    if (argc < 2) errx(1, "Usage: %s <Maxnum>", argv[0]);
   
    int maxnum = atoi(argv[1]);
    printf("Maximum number of unfilled holes: %d\n", maxnum);
    
    sem_init(&shovel, 0, 1);
    sem_init(&filled, 0, maxnum);
    sem_init(&unfilled, 0, 0);
    sem_init(&planted, 0, 0);

    printf("Begin run.\n");
    pthread_t t[3];
    pthread_create(&t[0], NULL, Larry, NULL);
    pthread_create(&t[1], NULL, Moe, NULL);
    pthread_create(&t[2], NULL, Curly, NULL);

    pthread_join(t[0], NULL);
    pthread_join(t[1], NULL);
    pthread_join(t[2], NULL);
    
    sem_destroy(&shovel);
    sem_destroy(&filled);
    sem_destroy(&unfilled);
    sem_destroy(&planted);
    
    printf("End run.\n");
}
