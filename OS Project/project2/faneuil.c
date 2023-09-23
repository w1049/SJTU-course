//
// The Faneuil Hall problem
// Immigrants must invoke enter, checkIn, sitDown, swear, getCertificate and leave.
// The judge invokes enter, confirm and leave.
// Spectators invoke enter, spectate and leave.
// While the judge is in the building, no one may enter and immigrants may not leave.
// The judge can not confirm until all immigrants, who have invoked enter, have also invoked checkIn.
//

#include <stdio.h>
#include <stdlib.h>
#include <err.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#include <time.h>

// Probability, spec_per = 1 - 0.6 - 0.2 = 0.2
const double IMM_PER = 0.6;
const double JUD_PER = 0.2;

const int IMM_LIM = IMM_PER * RAND_MAX;
const int JUD_LIM = JUD_PER * RAND_MAX + IMM_LIM;

const int MAXSLEEP = 50; // ms
// sleep between actions
#define SLEEP usleep(rand() % MAXSLEEP * 1000)
// sleep between thread creation
#define LONGSLEEP usleep(rand() % MAXSLEEP * 1000 * 10)

#define MAXTHREAD 12345

// semaphores
sem_t all_checkin, confirm, confirmed;
// mutex
sem_t judge, mutex;

int entered; // protected by judge
int checked; // protected by mutex

// the only judge in the hall
int judge_id = -1; // protected by judge

// for recording id
int imms, juds, specs; // protected by judge

void *imm() {
    sem_wait(&judge);
    // enter
    int id = imms++;
    ++entered;
    SLEEP;
    printf("Immigrant #%d enter\n", id);
    sem_post(&judge);

    sem_wait(&mutex); // acquire the mutex to modify checked
    // checkin
    ++checked;
    SLEEP;
    printf("Immigrant #%d checkIn\n", id);
    if (judge_id >= 0 && checked == entered)
        sem_post(&all_checkin); // wake up judge, and give mutex to him
    else sem_post(&mutex); // give mutex to anybody

    // sitdown
    SLEEP;
    printf("Immigrant #%d sitDown\n", id);

    sem_wait(&confirm); // I need to be confirmed
    // confirm
    SLEEP;
    printf("Judge #%d confirm the immigrant #%d\n", judge_id, id);
    sem_post(&confirmed); // I have been confirmed

    // swear
    SLEEP;
    printf("Immigrant #%d swear\n", id);
    // get certificate
    SLEEP;
    printf("Immigrant #%d getCertificate\n", id);
    
    sem_wait(&judge);
    // leave
    SLEEP;
    printf("Immigrant #%d leave\n", id);
    sem_post(&judge);
    pthread_exit(0);
}

void *jud() {
    sem_wait(&judge);
    sem_wait(&mutex);
    // enter
    int id = juds++;
    judge_id = id;
    SLEEP;
    printf("Judge #%d enter\n", id);

    if (entered > checked) { // if not all imms checked in
        sem_post(&mutex); // give them a chance to check in
        sem_wait(&all_checkin); // wait for all imms to check in
    } 
    
    // confirm
    for (int i = 0; i < entered; i++) sem_post(&confirm); // tell all imms, you can be confirmed
    for (int i = 0; i < entered; i++) sem_wait(&confirmed); // after all imms are confirmed
    entered = checked = 0;

    // leave
    judge_id = -1;
    SLEEP;
    printf("Judge #%d leave\n", id);
    sem_post(&mutex);
    sem_post(&judge);
    pthread_exit(0);
}

void *spec() {
    sem_wait(&judge);
    // enter
    int id = specs++;
    SLEEP;
    printf("Spectator #%d enter\n", id);
    sem_post(&judge);

    // spec
    SLEEP; 
    printf("Spectator #%d spectate\n", id);
    LONGSLEEP; // spectate for a longer time

    // leave
    SLEEP;
    printf("Spectator #%d leave\n", id);
    pthread_exit(0);
}

pthread_t t[MAXTHREAD];
void new_thread(int tid) {
    int typ, r = rand();

    if (r < IMM_LIM) typ = 1;
    else if (r < JUD_LIM) typ = 2;
    else typ = 3;
    // if MAXTHREAD is small, the last judge finish all the work
    if (tid == MAXTHREAD - 1) typ = 2;

    switch (typ) {
    case 1: pthread_create(&t[tid], NULL, imm, NULL);
        break;
    case 2: pthread_create(&t[tid], NULL, jud, NULL);
        break;
    case 3: pthread_create(&t[tid], NULL, spec, NULL);
        break;
    }
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    sem_init(&judge, 0, 1);
    sem_init(&mutex, 0, 1);
    sem_init(&all_checkin, 0, 0);
    sem_init(&confirm, 0, 0);
    sem_init(&confirmed, 0, 0);

    int tid = 0;
    while (tid < MAXTHREAD) {
        new_thread(tid);
        ++tid;
        LONGSLEEP;
    }

    for (int i = 0; i < MAXTHREAD; i++)
        pthread_join(t[i], NULL);
    
    sem_destroy(&judge);
    sem_destroy(&mutex);
    sem_destroy(&all_checkin);
    sem_destroy(&confirm);
    sem_destroy(&confirmed);
}
