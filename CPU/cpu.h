#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef CPU_H_
#define CPU_H_

//struct para instruções
struct command{
    char instruction_part[3][30];           //cada instrução tem 3 partes(strings de tamanho 10)
};

struct memory
{
    char status;
    int content;
};

struct cacheLine 
{
	char status;
	int tag;
	int  *content;
};

struct cacheSet
{
    struct cacheLine *lines;
};

//array de memória de dados
struct memory memory_list[1000000];

//implementação de cache em arrays de struct
struct cacheLine *cache_memory;
struct cacheSet *cacheset_memory;

int size_cache, associativity, block_size;

#endif //CPU_H_