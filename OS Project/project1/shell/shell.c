//
// A shell-like program as a server
//

#include <assert.h>
#include <err.h>
#include <errno.h>
#include <netdb.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <arpa/inet.h>
#include <unistd.h>

#define ERROR "\033[31m[Error]\033[0m "

// the max number of args
#define MAXARGS 32

extern int errno;

const char welcome[] = "Welcome to shell!\n";
const char cd_usage[] = "Usage: cd <path>\n";
const char too_many_args[] = "Too many args!\n";

char message[1024];
char buf[1024];
char *commands[MAXARGS];

// fork with error check
pid_t fork1() {
    pid_t pid = fork();
    if (pid == -1) err(1, ERROR "Failed to fork");
    return pid;
}

// parse a line into commands
int parse(char *line, char *commands[]) {
    char *p;
    int argc = 0;
    p = strtok(line, " ");
    while (p) {
        commands[argc++] = p;
        if (argc >= MAXARGS) return -1;
        p = strtok(NULL, " ");
    }
    commands[argc] = NULL;
    return argc;
}

// never return
void run(char *commands[]) {
    for (int i = 0; commands[i]; i++) {
        if (strcmp(commands[i], "|") == 0) {
            // if a pipe is found
            if (i == 0) {  // first |
                errx(1, "Pipe at the beginning");
            } else if (commands[i + 1] == NULL) {  // last |
                errx(1, "Pipe at the end");
            }

            int pipefd[2];
            if (pipe(pipefd) == -1) err(1, ERROR "Failed to pipe");

            if (fork1() == 0) {
                close(1);
                dup(pipefd[1]);
                close(pipefd[0]);
                close(pipefd[1]);
                commands[i] = NULL;
                run(commands);
            }
            if (fork1() == 0) {
                close(0);
                dup(pipefd[0]);
                close(pipefd[0]);
                close(pipefd[1]);
                run(commands + i + 1);
            }
            close(pipefd[0]);
            close(pipefd[1]);
            wait(NULL);
            wait(NULL);
            exit(0);
        }
    }
    if (execvp(commands[0], commands) == -1) {
        err(1, "Failed to execvp '%s'", commands[0]);
    }
}

// print the prefix "/home/user$ "
void print_prefix(int clientfd) {
    char *wd = getcwd(NULL, 0);
    sprintf(message, "\033[36m%s\033[0m$ ", wd);
    write(clientfd, message, strlen(message));
}

// for displaying
int port;

// serve the client
// return when the client exits
void serve(int clientfd) {
    // send welcome
    write(clientfd, welcome, sizeof(welcome));
    print_prefix(clientfd);

    // handle commands
    size_t n;
    while ((n = read(clientfd, buf, sizeof(buf))) > 0) {
        buf[n] = 0;
        printf("Received from port %d: %s", port, buf);

        // remove trailing \r and \n
        while (n > 0 && (buf[n - 1] == '\r' || buf[n - 1] == '\n'))
            buf[--n] = 0;

        int argc = parse(buf, commands);

        if (argc == 0) {
            // do nothing
        } else if (argc == -1) {
            write(clientfd, too_many_args, sizeof(too_many_args));
        } else if (strcmp(commands[0], "cd") == 0) {
            if (argc != 2) {
                write(clientfd, cd_usage, sizeof(cd_usage));
            } else if (chdir(commands[1]) == -1) {
                sprintf(message, "Failed to cd '%s': %s\n", commands[1],
                        strerror(errno));
                write(clientfd, message, strlen(message));
            }
        } else if (strcmp(commands[0], "exit") == 0) {
            printf("Client on port %d exited\n", port);
            return;
        } else {
            // fork a child to run the command
            if (fork1() == 0) {
                // redirect all stdio to clientfd
                close(0);
                close(1);
                close(2);
                dup(clientfd);
                dup(clientfd);
                dup(clientfd);
                close(clientfd);

                run(commands);
            }
            wait(NULL);
        }
        print_prefix(clientfd);
    }
}

// collect zombie processes
// after a client exits
void sigchlc_handler(int sig) {
    while (waitpid(-1, NULL, WNOHANG) > 0);
}

int main(int argc, char *argv[]) {
    if (argc < 2) errx(1, "Usage: %s <Port>", argv[0]);
    // create listen socket
    int sockfd;
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) err(1, ERROR "socket()");

    // bind the socket to ANY localhost address
    struct sockaddr_in serv_addr;
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(atoi(argv[1]));
    if (bind(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)))
        err(1, ERROR "bind()");

    // start listening
    if (listen(sockfd, 5)) err(1, ERROR "listen()");

    signal(SIGCHLD, sigchlc_handler);

    printf("Start listening on port %d...\n", atoi(argv[1]));
    // accept() wait for connecting
    int client_sockfd;
    struct sockaddr_in client_addr;
    socklen_t len;
    while (1) {
        len = sizeof(client_addr);
        client_sockfd = accept(sockfd, (struct sockaddr *)&client_addr, &len);
        if (client_sockfd < 0) err(1, ERROR "accept()");
        printf("Client connected from %s:%d\n", inet_ntoa(client_addr.sin_addr), client_addr.sin_port);

        // if connect sucessfully, serve the client
        if (fork1() == 0) {
            port = client_addr.sin_port;
            close(sockfd);
            serve(client_sockfd);
            close(client_sockfd);
            exit(0);
        }
        close(client_sockfd);
    }

    while (wait(NULL));
    // close fd before exiting
    close(sockfd);
    exit(0);
}
