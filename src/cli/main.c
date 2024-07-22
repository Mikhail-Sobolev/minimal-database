
#include <minidb/minidb.h>
#include <stdio.h>
#include <stdbool.h>

bool end=false;

void query(mdb *database) {
    
    char *command=malloc(1);
    command[0] = 0;
    
    while (true) {
        char c = getchar();
        if (c == '\n') {
            break;
        }
        command = realloc(command, strlen(command)+2);
        command[strlen(command)+1] = 0;
        command[strlen(command)] = c;
    }

    printf("command: %s\n", command);
    end=true;
}

void main(int argc, char **argv) {
    
    // check usage is correct
    if (argc != 2) {
        printf("failure: invalid usage.\nusage: ./minidb [database-path]\n");
        exit(1);
    }

    // get db file name
    char *filename = argv[1];

    // read file
    FILE *fd = fopen(filename, "rb");
    
    // failed to read?
    if (fd == NULL) {
        printf("failure: couldn't open file.\n");
        exit(1);
    }

    // get file size
    size_t file_size=0;
    fseek(fd, 0, SEEK_END);
    file_size = ftell(fd);

    // read all file data
    char *fdata = malloc(file_size);

    // read data
    fread(fdata, 1, file_size, fd);
    
    fclose(fd);
    
    // parse db
    mdb *database = create_db(fdata, filename, file_size);
    
    // free data
    free(fdata);

    while (!end) {
        query(database);
    }
    
    // distroy data base
    distroy_db(database);

}
