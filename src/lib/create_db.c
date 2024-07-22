

#include <minidb/minidb.h>
#include <stdlib.h>
#include <string.h>
#include <memory.h>

void mdb_memcpy(char *to, char *from, size_t len) {
    while (len) {
        len--;
        *to = *from;
        to++;
        from++;
    }
}

char *parse_table( mdb *_db, char *db) {
    
    // allocate new table
    mtable *table = malloc(sizeof(table));
    
    // get key
    table->key = malloc(strlen(db));
    mdb_memcpy(table->key, db, strlen(db));
    
    // get width and hieght from db
    db += strlen(db);
    table->width = *((size_t*)db);
    db += sizeof(size_t);
    table->hieght = *((size_t*)db);
    db += sizeof(size_t);

    // get column names
    table->names = malloc(sizeof(char*) * table->width);
    for (size_t w1=0; w1<=table->width; ++w1) {
        
        // copy over the name
        table->names[w1] = malloc(strlen(db));
        mdb_memcpy(table->names[w1], db, strlen(db));
        db+=strlen(db);
    }

    // create rows
    table->rows = malloc(sizeof(mrow)*table->hieght);

    // loop for hieght
    for (size_t h=0; h<=table->hieght; ++h) {
        table->rows[h] = malloc(sizeof(mcell)*table->width);
        for (size_t w2=0; w2<=table->width; ++w2) {
            table->rows[h]->cells[w2] = *((int*)db);
            db += sizeof(int);
        }
    }
    
    _db->len++;
    _db->tables = realloc(_db->tables, (_db->len+1)*sizeof(mtable*));
    _db->tables[len] = table;
    return db;
}

mdb *create_db(char *db, char *db_name) {
    
    // create new database
    mdb *_db = malloc(sizeof(mdb));
    _db->len = -1;
   
    while (true) {

        // get next char from database
        char c = *db;
        db++;

        // check for end of database
        if (c == 0xff) {
            break;
        }

        // otherwise parse next table
        db = parse_table(_db, db);
    }
    return _db;
}
