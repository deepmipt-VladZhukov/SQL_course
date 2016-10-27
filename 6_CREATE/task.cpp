#include <iostream>
#include <sqlite3.h>
#include <fstream>
#include <vector>
#include <unistd.h>

using namespace std;

const string getSomeIdFromBaseTable(sqlite3* db, sqlite3_stmt* stmt, string req) {
	const char* req_c = req.c_str();
	sqlite3_prepare(db, req_c, req.size(), &stmt, &(req_c));
	sqlite3_step(stmt);
	const char* pilot_id_c = reinterpret_cast<const char*>(sqlite3_column_text(stmt, 0)); //о ужас
	const string pilot_id = pilot_id_c;
	return pilot_id;
}

int main () {
	std::ifstream inpt("create.sql");
	char c;
	std::vector<char> file_req;
	while (inpt.read(&c, 1)) {
		file_req.push_back(c);
	}
	const char* cur = &*file_req.begin();
	const char* end = &*file_req.end();
	sqlite3* db;
	sqlite3_stmt* stmt;
	char *zErrMsg = 0;
	int rc;
  	rc = sqlite3_open("myDB",  &db);
  	if (rc) {
    	fprintf(stderr, "failed to open %s\n", sqlite3_errmsg(db));
    	sqlite3_close(db);
   		exit(1);
  	}
	while (cur < end) {
		// std::cout << end - cur << std::endl;
		// sleep(1);
		int rc_prep = sqlite3_prepare(db, cur, end - cur , &stmt, &cur);
		if (rc_prep != SQLITE_OK) {
			std::cout << sqlite3_errmsg(db) << std::endl;
			std::cout <<  cur << std::endl;
		}
		int dsk;
		while ((dsk = sqlite3_step(stmt)) == SQLITE_ROW) {
			printf("%s\n", "-----------------");
  			for (int i = 0; i < sqlite3_column_count(stmt); i++) {
    			const unsigned char* s = sqlite3_column_text(stmt, i);
    			// printf("%s\n", s);
    			std::cout << s << std::endl;
 			}	
		}
		sqlite3_finalize(stmt);
	}
	//some request
	string from, to, good;
	cout << "prin task in format: system from, system to, goods name, weight, price for delivery" << endl;
	cin >> from >> to >> good;
	int weight, price;
	cin >> weight >> price;
	string req = "INSERT INTO Goods (name, weight) VALUES (?, ?)";
	const char* req_c = req.c_str();
	sqlite3_prepare(db, req_c, req.size(), &stmt, &(req_c));
	sqlite3_bind_text(stmt, 1, good.c_str(), -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(stmt, 2, weight);
	sqlite3_step(stmt);
	req = "SELECT COALESCE(MAX(good_id), 0) FROM Goods WHERE name = \"" + good + "\"";
	const string good_id = getSomeIdFromBaseTable(db, stmt, req);
	// cout << "good_id:" << good_id << endl;
	req = "SELECT COALESCE(MAX(id), 0) FROM Pilots WHERE busy != 1";
	const string pilot_id = getSomeIdFromBaseTable(db, stmt, req);
	// cout << "pilot_id: " << pilot_id << endl;
	req = "SELECT COALESCE(MAX(name), \"0\") FROM Ships WHERE busy != 1";
	const string ship_name = getSomeIdFromBaseTable(db, stmt, req);
	cout << "ship_name: " << ship_name << endl;
	req = "INSERT INTO Tasks (ship_name, trip_from, trip_to, price, good) VALUES (?, ?, ?, ?, ?)";
	req_c = req.c_str();
	sqlite3_prepare(db, req_c, req.size(), &stmt, &(req_c));
	sqlite3_bind_text(stmt, 1, ship_name.c_str(), -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(stmt, 2, from.c_str(), -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(stmt, 3, to.c_str(), -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(stmt, 4, price);
	sqlite3_bind_int(stmt, 5, stoi(good_id));
	sqlite3_step(stmt);
	// cout << sqlite3_errmsg(db) << endl;
	sqlite3_finalize(stmt);
	req = "UPDATE Pilots SET busy = 1 WHERE id = " + pilot_id;
	req_c = req.c_str();
	sqlite3_exec(db, req_c, NULL , 0, &zErrMsg);
	req = "UPDATE Ships SET busy = 1 WHERE name = \"" + ship_name + "\"";
	req_c = req.c_str();
	sqlite3_exec(db, req_c, NULL , 0, &zErrMsg);

	// req = "INSERT INTO Tasks (pilot_id, ship_name, trip_from, trip_to, price, good) 
					// VALUES (?, ?, ?, ?, SE);";
//Alpha_centauar Sirius vegatabels 12 100

	//Alpha_centauar Sirius vegatabels 12 100

	//если писать по-нормальному то можно было бы класс сделать с методами препэр и степ,
	//сделать шаблонный экзэк с байндами и прочее и прочее,
	//но видимо вообще проще писать все-таки на C для такой маленькой программы...
	return 0;
}