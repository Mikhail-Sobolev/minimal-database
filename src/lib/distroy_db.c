
#include <minidb/minidb.h>
#include <stdlib.h>
#include <memory.h>
#include <string.h>

void distroy_table(mtable *table) {

    // free all rows
    for (int r=table->hieght; r != 0; r--) {
        free(table->rows[r].cells);
    } 

    // free all names 
    for (int n=table->width; n != 0; n--) {
        free(table->names[n]);
    }
    
    // free arrays
    free(table->names);
    free(table->rows);

    // free key and table
    free(table->key);
    free(table);
}

void distroy_db(mdb *db) {
    // distory each table 
    for (int t=db->len; t != 0; t--) {
        distroy_table(db->tables[t]);
    }

    // free array
    free(db->tables);

    // free key and database
    free(db->name);
    free(db);
}
