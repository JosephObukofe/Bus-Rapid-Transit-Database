-- Inheritance to Table Definition
CREATE TABLE "passengers" (
  "id" SERIAL PRIMARY KEY,
  "first_name" varchar(20) NOT NULL,
  "last_name" varchar(20) NOT NULL,
  "gender" char(1) NOT NULL CHECK(gender IN ('M', 'F', 'O')),
  "email_address" varchar(50) UNIQUE NOT NULL,
  "address" varchar(100) NOT NULL 
); 

CREATE TABLE "passenger_cards" (
  "id" SERIAL PRIMARY KEY,
  "card_number" varchar(10) UNIQUE NOT NULL,
  "issue_date" date DEFAULT NOW(),
  "phone_number" varchar(12) UNIQUE NOT NULL,
  "passenger_id" integer NOT NULL,
  FOREIGN KEY ("passenger_id") REFERENCES "passengers" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "corridor_locations" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(20) UNIQUE NOT NULL
);

CREATE TABLE "drivers" (
  "id" SERIAL PRIMARY KEY,
  "first_name" varchar(20) NOT NULL,
  "last_name" varchar(20) NOT NULL,
  "gender" char(1) NOT NULL CHECK(gender IN ('M', 'F', '0')),
  "email_address" varchar(50) UNIQUE NOT NULL,
  "address" varchar(100) NOT NULL,
  "date_of_birth" date CHECK((date_part('year', NOW()) - date_part('year', date_of_birth)) > 25), -- This validates that any driver recorded should be above 25 years of age
  "national_identity_number" char(11) UNIQUE NOT NULL
);

CREATE TABLE "trips" (
  "id" SERIAL PRIMARY KEY,
  "departure_location" varchar(20) NOT NULL,
  "arrival_location" varchar(20) NOT NULL CHECK(arrival_location <> departure_location), -- This validates that arrival location is not equal to departure location
  "departure_time" timestamp NOT NULL,
  "arrival_time" timestamp NOT NULL CHECK(arrival_time > departure_time), -- This ensures that arrival time is greater than departure time
  "driver_id" integer NOT NULL,
  "trip_capacity" integer NOT NULL CHECK(trip_capacity > 0), -- This ensures that no driver conveys zero passengers
  FOREIGN KEY ("driver_id") REFERENCES "drivers" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE "passenger_trips" (
  "id" SERIAL,
  "passenger_id" integer NOT NULL,
  "trip_id" integer NOT NULL,
  "price" decimal NOT NULL,
  PRIMARY KEY ("passenger_id", "trip_id"), -- Composite keys bearing the not null and unique attributes due the primary key characteristics
  FOREIGN KEY ("passenger_id") REFERENCES "passengers" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("trip_id") REFERENCES "trips" ("id") ON DELETE RESTRICT -- Deleting from the trips table would lead to a violation of this foreign key constraint
);

CREATE TABLE "vehicles" (
  "id" SERIAL PRIMARY KEY,
  "vin" varchar(20) UNIQUE NOT NULL,
  "plate_number" varchar(10) UNIQUE NOT NULL,
  "model" varchar(50) NOT NULL,
  "capacity" integer NOT NULL,
  "status" varchar(20) NOT NULL CHECK(status IN ('Available', 'In use', 'Under maintenance', 'Out of use'))
);

CREATE TABLE "driver_vehicle_logs" (
  "id" SERIAL PRIMARY KEY,
  "driver_id" integer NOT NULL,
  "vehicle_id" integer NOT NULL,
  "pair_date" date DEFAULT NOW(), -- Left untouched for future records. 
  FOREIGN KEY ("driver_id") REFERENCES "drivers" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("vehicle_id") REFERENCES "vehicles" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE "driver_additional_details" (
  "id" SERIAL PRIMARY KEY,
  "phone_number" varchar(12) UNIQUE NOT NULL,
  "driver_id" integer NOT NULL,
  FOREIGN KEY ("driver_id") REFERENCES "drivers" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE "license" (
  "id" SERIAL PRIMARY KEY,
  "license_number" varchar(12) UNIQUE NOT NULL,
  "issue_date" date NOT NULL CHECK((date_part('year', NOW()) - date_part('year', issue_date)) > 1),
  "expiry_date" date NOT NULL CHECK(expiry_date > issue_date),
  "license_status" varchar(7) DEFAULT('TBD'), -- Left untouched
  "driver_id" integer UNIQUE, -- Enforcing a 1-1 relationship
  FOREIGN KEY ("driver_id") REFERENCES "drivers" ("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE brt.license
ADD CHECK((date_part('year', expiry_date) - date_part('year', issue_date)) = 5); -- To ensure that the difference between issue and expiry dates is equal to 5

UPDATE brt.license
SET license_status = (CASE WHEN date_part('year', NOW() > date_part('year', expiry_date) THEN 'Expired' ELSE 'Valid' END) 
WHERE license_status = 'TBD';

CREATE TABLE "driver_identification_cards" (
  "id" SERIAL,
  "card_no" char(5) PRIMARY KEY,
  "issue_date" date DEFAULT NOW(),
  "driver_id" integer UNIQUE NOT NULL, -- Enforcing a 1-1 relationship 
  FOREIGN KEY ("driver_id") REFERENCES "drivers" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE brt.driver_identification_cards
ADD UNIQUE (id);

ALTER TABLE brt.driver_identification_cards
ALTER COLUMN id SET NOT NULL;