DROP TABLE Systems;
DROP TABLE Ships;
DROP TABLE  Pilots;
DROP TABLE Tasks;
DROP TABLE Fuel_prices;
DROP TABLE Goods;
PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS Fuel_prices
(
	fuel_type VARCHAR(20) NOT NULL PRIMARY KEY,
	price_one INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS Systems 
(
	name VARCHAR(20) NOT NULL PRIMARY KEY, 
	x DOUBLE NOT NULL, 
	y DOUBLE NOT NULL
);
CREATE TABLE IF NOT EXISTS Pilots
(
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(20) NOT NULL
);
CREATE TABLE IF NOT EXISTS Goods
(
	good_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(10) NOT NULL,
	weight INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Ships
(
	name VARCHAR(20) NOT NULL PRIMARY KEY, 
	fuel DOUBLE NOT NULL,
	fuel_per_km DOUBLE NOT NULL,
	fuel_type VARCHAR(20) NOT NULL,
	tank_vol DOUBLE NOT NULL,
	FOREIGN KEY (fuel_type) REFERENCES Fuel_prices(fuel_type)
);

CREATE TABLE IF NOT EXISTS Tasks
(
	pilot_id INTEGER NOT NULL,
	ship_name VARCHAR(20) NOT NULL,
	trip_from VARCHAR(20) NOT NULL,
	trip_to VARCHAR(20) NOT NULL,
	price INTEGER NOT NULL,
	good INTEGER NOT NULL
	,
	FOREIGN KEY (pilot_id) REFERENCES Pilots(id),
	FOREIGN KEY (ship_name) REFERENCES Ships(name),
	FOREIGN KEY (trip_from) REFERENCES Systems(name),
	FOREIGN KEY (trip_to) REFERENCES Systems(name), 
	FOREIGN KEY (good) REFERENCES Goods(good_id)
);

INSERT INTO Fuel_prices (fuel_type, price_one)
VALUES ("UltraPetrol", 100);
INSERT INTO Fuel_prices (fuel_type, price_one)
VALUES ("uran", 500);

INSERT INTO Systems (name, x, y)
VALUES ("Solar", 0, 0);
INSERT INTO Systems (name, x, y)
VALUES ("Sirius", 10000, 200);
INSERT INTO Systems (name, x, y)
VALUES ("Alpha_centauar", 100000, 43234);

INSERT INTO Pilots (name)
VALUES ("Vasiliy");
INSERT INTO Pilots (name)
VALUES ("Piter");
INSERT INTO Pilots (name)
VALUES ("Jack");

INSERT INTO Goods (name, weight)
VALUES ("Oil", 20);
INSERT INTO Goods (name, weight)
VALUES ("pizza", 1);

INSERT INTO Ships (name, fuel, fuel_per_km, fuel_type, tank_vol)
VALUES ("Korito", 1000.0, 10.0, "UltraPetrol", 2000.0);

INSERT INTO Ships (name, fuel, fuel_per_km, fuel_type, tank_vol)
VALUES ("Arrow4000", 10000.0, 40.0, "uran", 15000.0);

INSERT INTO Tasks (pilot_id, ship_name, trip_from, trip_to, price, good)
VALUES (1, "Korito", "Solar", "Alpha_centauar", 100, 1);

SELECT "_______________Fuel_prices TABLE_______________";
SELECT *
FROM
	Fuel_prices;
SELECT "_______________Systems TABLE_______________";
SELECT *
FROM
	Systems;

SELECT "_______________Pilots TABLE_______________";
SELECT *
FROM
	Pilots;
SELECT "_______________Ships_______________";
SELECT *
FROM
	Ships;
SELECT "_______________Tasks_______________";
SELECT *
FROM
	Tasks;
SELECT "__________________________________";