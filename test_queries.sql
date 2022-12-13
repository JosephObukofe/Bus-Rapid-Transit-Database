-- To determine the Top Ten (10) passengers with the highest trips
WITH CTE1 AS 
(
  SELECT 
   DISTINCT passenger_id,
   COUNT(trip_id) as no_of_trips
  FROM brt.passenger_trips
  GROUP BY distinct passenger_id
)

SELECT 
 first_name,
 last_name,
 gender,
 email_address,
 no_of_trips
FROM brt.passengers p
JOIN CTE1
 ON CTE1.passenger_id = p.id
ORDER BY no_of_trips DESC
LIMIT 10;

-- To determine the available vehicles ready for driver pairing
SELECT *
FROM brt.vehicles
WHERE status = 'Available';