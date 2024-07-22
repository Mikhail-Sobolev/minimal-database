
#include <minidb/minidb.h>
#include <stdio.h>

void main(int argc, char **argv) {
    
    // check usage is correct
    if (argc != 2) {
        printf("failure: invalid usage.\nusage: ./minidb [file-name]\n");
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

    fclose(fd);
}
