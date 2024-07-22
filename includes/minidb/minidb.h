
#ifndef MINIDB_MINIDB_H
#define MINIDB_MINIDB_H

#include <stddef.h>
#include <stdint.h>

typedef struct _mcell {
    int value;
} mcell;

typedef struct _mrow {
    mcell *cells;
} mrow;

typedef struct _mtable {
    char *key;
    size_t width, hieght;
    char **names;
    mrow *rows;
} mtable;

typedef struct _mdb {
    char *name;
    size_t len;
    mtable **tables;
} mdb;

char *parse_table(mdb *_db, char *db);
mdb *create_db(char *db, char *name);

void distroy_db(mdb *db); 
void distory_table(mtable *table);

#endif
