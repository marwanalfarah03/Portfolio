#include <stdio.h>
#include <stdlib.h>
#include <sys/shm.h>
#include <unistd.h>
#include <wait.h>
#define BUFFER_SIZE 5

// Indices for the control variables in the shared array
#define HEAD_INDEX BUFFER_SIZE     // Location for the head index
#define TAIL_INDEX BUFFER_SIZE + 1 // Location for the tail index

// Producer function
void producer(int* shared, int producer_id) {
    int start, end, i = 0;
    if (producer_id == 1) {
        start = 1;
        end = 3;
    } else {
        start = 4;
        end = 6;
    }

    while (1) {
        int item = start + (i % (end - start + 1));

        // Busy wait if buffer is full
        while ((shared[HEAD_INDEX] + 1) % BUFFER_SIZE == shared[TAIL_INDEX]);

        shared[shared[HEAD_INDEX]] = item;
        shared[HEAD_INDEX] = (shared[HEAD_INDEX] + 1) % BUFFER_SIZE;

        printf("Producer %d produced: %d\n", producer_id, item);
        sleep(2); // Producer produces every 2 seconds
        i++;
    }
}

// Consumer function
void consumer(int* shared, int consumer_id) {
    while (1) {
        // Busy wait if buffer is empty
        while (shared[HEAD_INDEX] == shared[TAIL_INDEX]);
        int item = shared[shared[TAIL_INDEX]];
        shared[TAIL_INDEX] = (shared[TAIL_INDEX] + 1) % BUFFER_SIZE;

        printf("Consumer %d consumed: %d\n", consumer_id, item);
        sleep(3); // Consumer consumes every 3 seconds
    }
}

int main() {    
    // Create the shared memory segment
    int shm_id = shmget(200, (BUFFER_SIZE + 2) * sizeof(int), 0666 | IPC_CREAT);
    
    // Attach the shared memory segment
    int* shared = (int*)shmat(shm_id, NULL, 0);

    // Initialize buffer indices
    shared[HEAD_INDEX] = 0;
    shared[TAIL_INDEX] = 0;

    // Fork child processes for producers and consumers
    pid_t pid;
    for (int i = 0; i < 4; i++) {
        pid = fork();
	if (pid == 0) {
            if (i < 2)// First two processes are producers
                producer(shared, i + 1);
            else
                consumer(shared, i - 1);
        }
    }
	
    // Parent acts as a consumer
    consumer(shared, 3);
    
    return 0;
}
