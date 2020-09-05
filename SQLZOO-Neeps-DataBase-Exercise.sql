
#1. Give the room id in which the event co42010.L01 takes place.

SELECT 
    room
FROM
    event
WHERE
    id = 'co42010.L01';


#2.  For each event in module co72010 show the day, the time and the place.

SELECT 
    dow, tod, room
FROM
    event
WHERE
    modle = 'co72010';



#3. List the names of the staff who teach on module co72010.

SELECT DISTINCT
    s.name
FROM
    staff s
        JOIN
    teaches t ON s.id = t.staff
        JOIN
    event e ON t.event = e.id
WHERE
    e.modle = 'co72010';
    

#4.  Give a list of the staff and module number associated with events using room cr.132 on Wednesday, include the time each event starts.

  SELECT 
    s.name, e.modle, e.tod
FROM
    staff s
        JOIN
    teaches t ON s.id = t.staff
        JOIN
    event e ON t.event = e.id
WHERE
    e.room = 'cr.132'
        AND e.dow = 'Wednesday';



#5.  Give a list of the student groups and name of the moules which take modules with the word 'Database' in the name.

    SELECT DISTINCT
    s.id, m.name
FROM
    modle m
        JOIN
    event e ON m.id = e.modle
        JOIN
    attends a ON e.id = a.event
        JOIN
    student s ON a.student = s.id
WHERE
    m.name LIKE '%database%';


#6. Show the 'size' of each of the co72010 events. Size is the total number of students attending each event.

SELECT 
    SUM(sze) AS size, event, modle
FROM
    (SELECT 
        id, modle
    FROM
        event
    WHERE
        modle = 'co72010') AS e
        JOIN
    attends a ON a.event = e.id
        JOIN
    student s ON a.student = s.id
GROUP BY event
ORDER BY event;

#7. For each post-graduate module, show the size of the teaching team. (post graduate modules start with the code co7).
SELECT 
    COUNT(DISTINCT t.staff) AS staff, e.modle
FROM
    (SELECT 
        modle, id
    FROM
        event
    WHERE
        modle LIKE 'co7%') AS e
        LEFT JOIN
    teaches t ON e.id = t.event
GROUP BY modle;

#8. Give the full name of those modules which include events taught for fewer than 10 weeks.
SELECT DISTINCT
    name
FROM
    (SELECT 
        event
    FROM
        occurs
    GROUP BY event
    HAVING COUNT(week) < 10) AS o
        LEFT JOIN
    event e ON e.id = o.event
        LEFT JOIN
    modle m ON m.id = e.modle;

#9. Identify those events which start at the same time as one of the co72010 lectures.

SELECT 
    id
FROM
    event
WHERE
    CONCAT(dow, ' ', tod) IN (SELECT 
            CONCAT(dow, ' ', tod)
        FROM
            event
        WHERE
            modle = 'co72010');
            
#10. How many members of staff have contact time which is greater than the average?

SELECT 
    COUNT(staff) AS total_staff
FROM
    (  SELECT 
        SUM(duration), staff
       FROM
        teaches t
       JOIN event e ON t.event = e.id
       GROUP BY staff
       HAVING SUM(duration) > 
       (   SELECT 
            SUM(time) / COUNT(time)
        FROM
            ( SELECT 
                 SUM(duration) AS time, staff
              FROM
                 teaches t
              JOIN event e ON t.event = e.id
              GROUP BY staff
          ) AS avg_value
	  )
) AS final_table;

