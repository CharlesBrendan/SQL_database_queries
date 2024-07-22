-- aircraft that, on average, would use less fuel on the flight routes? 
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

--Aircraft manufacturer using less fuel per km in total
SELECT	aircraft.manufacturer,
        SUM(fuel.fuel_efficiency * route.distance_flown * flights.baggage_weight * 
    flights.total_passengers) / SUM(distance_flown) AS avg_fuel_usage
    
FROM	ba_flights flights
INNER JOIN	ba_aircraft aircraft
ON	flights.flight_id = aircraft.flight_id

LEFT JOIN ba_flight_routes route
ON flights.flight_number = route.flight_number

LEFT JOIN ba_fuel_efficiency fuel
ON aircraft.ac_subtype = fuel.ac_subtype

WHERE flights.status  = 'Completed'

GROUP BY aircraft.manufacturer
;

