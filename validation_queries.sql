-- Determining the sizes of the relations in the schema
SELECT pg_size_pretty(pg_total_relation_size('brt.passengers'));
SELECT pg_size_pretty(pg_total_relation_size('brt.passenger_cards'));
SELECT pg_size_pretty(pg_total_relation_size('brt.passenger_trips'));
SELECT pg_size_pretty(pg_total_relation_size('brt.trips'));
SELECT pg_size_pretty(pg_total_relation_size('brt.corridor_locations'));
SELECT pg_size_pretty(pg_total_relation_size('brt.vehicles'));
SELECT pg_size_pretty(pg_total_relation_size('brt.driver_vehicle_logs'));
SELECT pg_size_pretty(pg_total_relation_size('brt.drivers'));
SELECT pg_size_pretty(pg_total_relation_size('brt.driver_identification_cards'));
SELECT pg_size_pretty(pg_total_relation_size('brt.driver_additional_details'));
SELECT pg_size_pretty(pg_total_relation_size('brt.license'));

-- Validating the existence of a constraint (PK or FK Constraints)
SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.passengers';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.passenger_cards';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.passenger_trips';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.trips';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.corridor_locations';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.vehicles';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.driver_vehicle_logs';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.drivers';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.driver_identification_cards';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.driver_additional_details';

SELECT 
  table_name, column_name, constraint_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'brt.license';

-- Validating the existence of Indexes
SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.passengers';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.passenger_cards';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.passenger_trips';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.trips';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.corridor_locations';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.vehicles';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.driver_vehicle_logs';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.drivers';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.driver_identification_cards';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.driver_additional_details';

SELECT *
FROM pg_Indexes
WHERE tablename = 'brt.license';

