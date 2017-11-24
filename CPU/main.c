#include "cpu.h"
#include "functions.h"
#define DATA_MEMORY "memory.txt"
#define INSTRUCT_MEMORY "memory/matriz.txt"

extern const int total_blocks;

struct command instruction_list[100];

int cacheHit = 0, cacheMiss = 0;

void freeMemory(int count, ...)
{
    va_list args;
    va_start(args, count);
    void** ptr;

    for(int i = 0; i < count; i++)
    {
        ptr = va_arg(args, void*);

        if(*ptr)
        {
            free(*ptr);
            *ptr = NULL;
        }
    }
    va_end(args);
}


int main(void)
{
    //getline
    FILE *fp, *fpMemory;
    char *line = NULL, *lineMemory = NULL;
    size_t len = 0, lenMemory = 0;
    ssize_t read, readMemory;

    //strtok
    char *pch, *pchMemory;
    
    //strtol
    char *pEndMemory;

    //instruction pointer
    int inst_pointer = 1;
    char operation, stage='F', end = 0;

    int nInstructions = 0;                      //funciona no loop de leitura das instruções e serve como número total de insts
    int nData = 0;                              //numero de dados total lidos no arquivo

    struct command current_command;    

    printf("Tamanho da cache: ");
    scanf("%d", &size_cache);
    cache_memory = (struct cacheLine*) malloc(size_cache * sizeof(struct cacheLine));        //Definição da Cache(Array de blocos de memória cache)


    block_size = 1000000/total_blocks;              //Tamanho do bloco = tamanho da memória principal / número total de blocos

    printf("Nível de Associatividade: ");
    scanf("%d", &associativity);

    if(associativity >= 2)
    {
        cacheset_memory = (struct cacheSet*) malloc(size_cache * sizeof(struct cacheSet));                   //seta os sets(tamanho da cache)

        for(int i = 0; i < size_cache; ++i)
        {
            cacheset_memory[i].lines = (struct cacheLine*) malloc(associativity * sizeof(struct cacheLine));  //seta as linhas de cada set(associativiadde)
        }
        for(int j = 0; j < size_cache; ++j)
        {
            for(int k = 0; k < associativity; k++)
            {
                cacheset_memory[j].lines[k].status = 0;
            }
        }
    }

    fp = fopen(INSTRUCT_MEMORY, "r");

    fpMemory = fopen(DATA_MEMORY, "r");
    if ((fp == NULL) || (fpMemory == NULL))
    {
        exit(EXIT_FAILURE);
    }

    //loop para leitura do arquivo de instruções
    while ((read = getline(&line, &len, fp)) != -1)
    {        

        pch = strtok(line, " ");                    //necessário para começar a dividir tokens

        for(int i = 0; pch != NULL; i++)            //copia as instruções do arquivo pro array de instruções
        {             
            strcpy(instruction_list[nInstructions].instruction_part[i], pch);
            pch = strtok(NULL, " ");
        }
        nInstructions++;
    }

    //loop para leitura do arquivo de dados
    while ((readMemory = getline(&lineMemory, &lenMemory, fpMemory)) != -1)
    {        
        pchMemory = strtok(lineMemory, " ");                //necessário para começar a dividir tokens
        
        if(*pchMemory == '\n')
        {
            memory_list[nData].status = 0;
            nData++;
            continue;
        }

        memory_list[nData].content = (int)strtol(pchMemory, &pEndMemory, 10);
        memory_list[nData].status = 1;
        nData++;
    }

    while(!end)
    {
        switch(stage)
        {
            case 'F':           //FETCH
                if(inst_pointer <= nInstructions)
                {
                    current_command = instruction_list[inst_pointer - 1];        //copia instrução para variável da inst atual
                    inst_pointer++;
                }
                else
                {
                    end = 1;
                }
                stage = 'D';
                break;

            case 'D':           //DECOD
                operation = Decod(current_command.instruction_part[0]);
                if(operation == 23)
                {
                    stage = 'F';
                }
                else{
                    stage = 'E';
                }
                break;

            case 'E':           //EXEC
                stage = Exec(current_command, operation, &inst_pointer);
                break; 

            case 'S':           //STORE
                fpMemory = fopen(DATA_MEMORY, "w");
                if (fpMemory == NULL)
                {
                    exit(EXIT_FAILURE);
                }

                for(int i = 0; i < 100; i++)                                        //Imprime toda a saída no arquivo txt de dados
                {
                    if(memory_list[i].status)
                    {
                        fprintf(fpMemory, "%d\n", memory_list[i].content);
                    }
                    else
                    {
                        fprintf(fpMemory, "\n");
                    }
                }
                end = 1;
                break;

            case 'I':           //INVALID
                return -1;
        }
    }

    printf("\nCacheHit = %d\tCacheMiss = %d\n", cacheHit, cacheMiss);

    fclose(fp);
    fclose(fpMemory);

    freeMemory(5, &line, &lineMemory, &cacheset_memory, &pch, &cache_memory);

    exit(EXIT_SUCCESS);

    return 0;
}