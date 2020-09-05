SQLZOO Guest_DataBase. Below is the link to database

https://sqlzoo.net/wiki/Guest_House


#1. Guest 1183. Give the booking_date and the number of nights for guest 1183.

SELECT 
    DATE_FORMAT(b.booking_date, '%Y-%m-%d') AS booking_date,
    b.nights
FROM
    guest g
        JOIN
    booking b ON g.id = b.guest_id
WHERE
    g.id = 1183;



#2. When do they get here? List the arrival time and the first and last names for all guests due to arrive on 2016-11-05, order the output by time of arrival.

SELECT 
    b.arrival_time, g.first_name, g.last_name
FROM
    guest g
        JOIN
    booking b ON g.id = b.guest_id
WHERE
    DATE_FORMAT(b.booking_date, '%Y-%m-%d') = '2016-11-05'
ORDER BY b.arrival_time;


#3. Look up daily rates. Give the daily rate that should be paid for bookings with ids 5152, 5165, 5154 and 5295. Include booking id, room type, number of occupants and the amount.

SELECT 
    b.booking_id, r.room_type, r.occupancy, r.amount
FROM
    rate r
        JOIN
    booking b ON r.room_type = b.room_type_requested
        AND b.occupants = r.occupancy
WHERE
    b.booking_id IN (5152 , 5165, 5154, 5295);


#4. Who’s in 101? Find who is staying in room 101 on 2016-12-03, include first name, last name and address.

SELECT 
    g.first_name, g.last_name, g.address
FROM
    guest g
        JOIN
    booking b ON g.id = b.guest_id
WHERE
    b.room_no = 101
        AND b.booking_date = '2016-12-03';



#5. How many bookings, how many nights? For guests 1185 and 1270 show the number of bookings made and the total number of nights. Your output should include the guest id and the total number of bookings and the total number of nights.


SELECT 
    g.id, COUNT(nights), SUM(nights)
FROM
    guest g
        JOIN
    booking b ON g.id = b.guest_id
WHERE
    g.id IN (1185 , 1270)
GROUP BY g.id;


#6. Ruth Cadbury. Show the total amount payable by guest Ruth Cadbury for her room bookings. You should JOIN to the rate table using room_type_requested and occupants.

SELECT 
    SUM(r.amount * b.nights) AS Total_Amount
FROM
    guest g
        JOIN
    booking b ON g.id = b.guest_id
        JOIN
    rate r ON b.occupants = r.occupancy
        AND b.room_type_requested = r.room_type
WHERE
    g.first_name = 'Ruth'
        AND g.last_name = 'Cadbury';
	
	
#7. Including Extras. Calculate the total bill for booking 5346 including extras.

SELECT 
    SUM(e.amount) + r.amount AS Total_Amount
FROM
    extra e
        JOIN
    booking b ON e.booking_id = b.booking_id
        JOIN
    rate r ON b.occupants = r.occupancy
        AND b.room_type_requested = r.room_type
WHERE
    b.booking_id = 5346
GROUP BY r.amount;


#8. Edinburgh Residents. For every guest who has the word “Edinburgh” in their address show the total number of nights booked. Be sure to include 0 for those guests who have never had a booking. Show last name, first name, address and number of nights. Order by last name then first name.

SELECT 
    g.last_name,
    g.first_name,
    g.address,
    SUM(IFNULL(b.nights, 0)) AS nights
FROM
    (SELECT 
        id, first_name, last_name, address
    FROM
        guest
    WHERE
        address LIKE 'Edinburgh%') AS g
        LEFT JOIN
    booking b ON b.guest_id = g.id
GROUP BY g.first_name , g.last_name
ORDER BY g.last_name;

	       

#9.How busy are we? For each day of the week beginning 2016-11-25 show the number of bookings starting that day. Be sure to show all the days of the week in the correct order.

SELECT 
    DATE_FORMAT(booking_date, '%Y-%m-%d') AS Date,
    COUNT(arrival_time) AS arrivals
FROM
    booking
WHERE
    booking_date BETWEEN '2016-11-25' AND '2016-12-01'
GROUP BY booking_date;

	       

#10.How many guests? Show the number of guests in the hotel on the night of 2016-11-21. Include all occupants who checked in that day but not those who checked out.

SELECT
	sum(occupants)
FROM
	booking
WHERE
	booking_date <= '2016-11-21'
	AND DATE_ADD(booking_date, INTERVAL nights DAY) > '2016-11-21';
	       
	       

#11. Check out per floor. The first digit of the room number indicates the floor – e.g. room 201 is on the 2nd floor. 
#For each day of the week beginning 2016-11-14 show how many rooms are being vacated that day by floor number. Show all days in the correct order.

SELECT 
    booking_date,SUM(1st) AS 1st, SUM(2nd) AS 2nd, SUM(3rd) AS 3rd
FROM
    (
    SELECT 
    DATE_ADD(booking_date, INTERVAL nights DAY) AS booking_date,nights,
    CASE WHEN LEFT(room_no, 1) = 1 THEN COUNT(room_no) ELSE 0 END AS 1st,
    CASE WHEN LEFT(room_no, 1) = 2 THEN COUNT(room_no) ELSE 0 END AS 2nd,
    CASE WHEN LEFT(room_no, 1) = 3 THEN COUNT(room_no)  ELSE 0 END AS 3rd
    FROM booking
    WHERE
    DATE_ADD(booking_date, INTERVAL nights DAY) BETWEEN '2016-11-14' AND '2016-11-20'
    GROUP BY DATE_ADD(booking_date, INTERVAL nights DAY) , nights , room_no
    ) AS f
GROUP BY booking_date

