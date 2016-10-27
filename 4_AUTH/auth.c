#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sqlite3.h>
#include <string.h>
#include <stdbool.h>
// #include <math.h>
int usr_id = 0;
int max (int a, int b) {
  return a > b ? a: b;
}
int my_exec(sqlite3* db, char*  tail, int (*f)(sqlite3_stmt*), char* err);

void update_usr_id_call_back(sqlite3_stmt* stmt) {
  usr_id = max(usr_id, atoi(sqlite3_column_text(stmt, 0))) + 1;
}

int update_usr_id(sqlite3 * db) {
  char* error;
  return my_exec(db, "SELECT id FROM users",update_usr_id_call_back, &error);
}


int call_back_user_print(sqlite3_stmt* stmt) {
  printf("%s\n", "-----------------");
  for (int i = 0; i < sqlite3_column_count(stmt); i++) {
    const char* s = sqlite3_column_text(stmt, i);
    printf("%s\n", s);
  }
  return 0;
}

int call_back_check_email(sqlite3_stmt* stmt, bool* f, char** email) {
  if (strcmp(sqlite3_column_text(stmt, 1), (*email)) == 0)
    (*f) = 0;
  else
    (*f) = 1;
  return 0;
}

int my_exec(sqlite3* db, char*  tail, int (*f)(sqlite3_stmt*), char* err) {
  sqlite3_stmt* stmt;
  int rc;
  while (strlen(tail) > 0) {
    sqlite3_prepare(db, tail, strlen(tail), &stmt, &tail);
    while ((rc = sqlite3_step(stmt)) == SQLITE_ROW) {
      int f_desk = f(stmt); 
    }
    if (rc != SQLITE_DONE) {
      fprintf(stderr, "SQL error %s\n", err);
      sqlite3_free(err);
    }
    sqlite3_finalize(stmt);
  }
}

int check_email(sqlite3* db, char*  tail, int (*f)(sqlite3_stmt*, bool*, char*), char* err, char** email, bool* res) {
  sqlite3_stmt* stmt;
  int rc;
  (*res) = true;
  while (strlen(tail) > 0) {
    sqlite3_prepare(db, tail, strlen(tail), &stmt, &tail);
    while ((rc = sqlite3_step(stmt)) == SQLITE_ROW) {
      bool tmp_bool;
      int f_desk = f(stmt, &tmp_bool, email); 
      if (!tmp_bool) {
        (*res) = 0;
        return 0;
      }
    }
    if (rc != SQLITE_DONE) {
      fprintf(stderr, "SQL error %s\n", err);
      sqlite3_free(err);
    }
  }
  return 0;
}


bool check(sqlite3* db, char* zErrMsg) {
  char* req = "SELECT * FROM users";
  printf("%s\n", "in db now:");
  int desc_exec = my_exec(db, req, call_back_user_print, &zErrMsg);
}

int add(sqlite3* db, char* email, char* password) {
  char* req = malloc((strlen("INSERT INTO users (id, email, password) values(") + 100) * sizeof(char*));
  strcpy(req, "INSERT INTO users (id, email, password) VALUES(");
  char buffer[20];
  update_usr_id(db);
  sprintf(buffer, "%d", usr_id);
  strcat(req, buffer);
  // strcat(req, "123");
  strcat(req, ",\'");
  strcat(req, email);
  strcat(req, "\',\'");
  strcat(req, password);
  strcat(req, "\')");
  char* zErrMsg;
  printf("%s\n", req);
  int execDesk = sqlite3_exec(db, req, NULL , 0, &zErrMsg);
  // printf("%s\n", zErrMsg);
  free(req);
  return execDesk;
}

int main(int argc, char **argv) {  
  sqlite3 *db;
  char *zErrMsg = 0;
  int rc;
  rc = sqlite3_open("myDB",  &db);
  if (rc) {
    fprintf(stderr, "failed to open %s\n", sqlite3_errmsg(db));
    sqlite3_close(db);
    exit(1);
  }
  char* tail;
  int execDesk = sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS users (id INT NOT NULL PRIMARY KEY, email VARCHAR(20) NOT NULL, password VARCHAR(20) NOT NULL)", NULL, 0, &zErrMsg);
  char* email = malloc(100 * sizeof(char*));
  char* password = malloc(100 * sizeof(char*));
  printf("%s\n", "if you want to create new user enter 1.\nIf you want to view users list enter 0");
  int prnt;
  scanf("%d", &prnt);
  bool email_correct = false;
  if (prnt == 1) {
    printf("%s\n", "Create new user \n enter your email");
    while (!email_correct) {
      scanf("%s", email);
      check_email(db, "SELECT * FROM users", call_back_check_email, zErrMsg, &email, &email_correct);
      printf("%s\n", "this email already exists in base. Type another one");
    }
    printf("%s\n",  "enter your password");
    scanf("%s", password);
    add(db, email, password);
  }
  else
    check(db, zErrMsg);
  free(email);
  free(password);
  return 0;
}