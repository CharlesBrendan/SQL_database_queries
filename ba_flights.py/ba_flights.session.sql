SELECT *
FROM company_revenue
;

--BA_flights with ID where manufacturer and ac_subtype is Null
SELECT	flights.flight_id,
        aircraft.manufacturer,
        aircraft.ac_subtype
FROM ba_flights flights
LEFT JOIN ba_aircraft aircraft
ON flights.flight_id = aircraft.flight_id
WHERE aircraft.flight_id IS NULL
;

-- Total flights average fuel efficiency
SELECT	COUNT(DISTINCT flights.flight_id) AS total_flights,
COUNT(DISTINCT aircraft.ac_subtype) AS total_types,
AVG(fuel.fuel_efficiency) AS avg_fuel_efficiency
              
FROM ba_flights flights
LEFT JOIN ba_aircraft aircraft
ON flights.flight_id = aircraft.flight_id
LEFT JOIN ba_fuel_efficiency fuel
ON aircraft.ac_subtype = fuel.ac_subtype
;


--SQL query for BA-flights with less fuel usage
SELECT	aircraft.manufacturer,
				aircraft.ac_subtype,
        AVG(fuel.fuel_efficiency * route.distance_flown * flights.baggage_weight * 
            flights.total_passengers) AS avg_fuel_usage
            
FROM	ba_flights flights
JOIN ba_aircraft aircraft
ON flights.flight_id = aircraft.flight_id

JOIN ba_flight_routes route
ON flights.flight_number = route.flight_number

JOIN ba_fuel_efficiency fuel
ON aircraft.ac_subtype = fuel.ac_subtype

WHERE route.departure_city = 'London'
AND route.arrival_city IN ('Basel', 'Trondheim', 'Glasgow')

GROUP BY	aircraft.manufacturer,
                aircraft.ac_subtype
        
ORDER BY avg_fuel_usage
;

