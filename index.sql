-- INDEX DEFINITION
DROP INDEX IF EXISTS brt_vehicles_id_idx;
CREATE INDEX brt_vehicles_id_idx
ON brt.vehicles(id);

CLUSTER brt.vehicles USING brt_vehicles_id_idx;

DROP INDEX IF EXISTS brt_driver_vehicle_logs_driver_id_vehicle_id_idx;
CREATE INDEX brt_driver_vehicle_logs_driver_id_vehicle_id_idx
ON brt.driver_vehicle_logs (driver_id, vehicle_id);

DROP INDEX IF EXISTS brt_drivers_first_name_last_name_idx;
CREATE INDEX brt_drivers_first_name_last_name_idx
ON brt.drivers (first_name, last_name);

DROP INDEX IF EXISTS brt_driver_identification_cards_driver_id;
CREATE INDEX brt_driver_identification_cards_driver_id
ON brt.driver_identification_cards (driver_id);

DROP INDEX IF EXISTS brt_driver_additional_details_driver_id_idx;
CREATE INDEX brt_driver_additional_details_driver_id_idx
ON brt.driver_additional_details (driver_id);

DROP INDEX IF EXISTS brt_license_driver_id;
CREATE INDEX brt_license_driver_id
ON brt.license (driver_id);

DROP INDEX IF EXISTS brt_trips_id;
CREATE INDEX brt_trips_id
ON brt.trips (id);

CLUSTER brt.trips USING brt_trips_id;

DROP INDEX IF EXISTS brt_trips_driver_id;
CREATE INDEX brt_trips_driver_id
ON brt.trips (driver_id);

DROP INDEX IF EXISTS brt_passenger_trips_passenger_id_trip_id_idx;
CREATE INDEX brt_passenger_trips_passenger_id_trip_id_idx
ON brt.passenger_trips (passenger_id, trip_id);

DROP INDEX IF EXISTS brt_passenger_cards_passenger_id_idx;
CREATE INDEX brt_passenger_cards_passenger_id_idx
ON brt.passenger_cards (passenger_id);