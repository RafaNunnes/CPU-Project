#define _GNU_SOURCE
#ifndef FUNCTIONS_H_
#define FUNCTIONS_H_

const int total_blocks;

extern char Decod(const char* current_command);
extern char Exec(struct command current_command, int op, int* inst_pointer);

#endif //FUNCTIONS_H_
