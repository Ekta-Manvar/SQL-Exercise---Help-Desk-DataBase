SQLZOO HelpDesk_DataBase. Below is the link to database

https://sqlzoo.net/wiki/Help_Desk 

![enter image description here](https://sqlzoo.net/w/images/3/38/Helpdesk.png)

#### 1. There are three issues that include the words "index" and "Oracle". Find the call_date for each of them

```SQL
SELECT 
    call_date, call_ref
FROM
    Issue
WHERE
    detail LIKE '%index%'
        AND detail LIKE '%oracle%';
        
```

#### 2. Samantha Hall made three calls on 2017-08-14. Show the date and time for each

``` SQL
SELECT 
     call_date, first_name, last_name
FROM
    Issue i
        JOIN
    Caller c ON i.caller_id = c.caller_id
WHERE
    first_name = 'Samantha'
        AND last_name = 'Hall'
        AND DATE(call_date) = '2017-08-14';
```

#### 3.There are 500 calls in the system (roughly). Write a query that shows the number that have each status
``` SQL
SELECT 
    status, COUNT(caller_id) AS Volume
FROM
    Issue 
GROUP BY status;
 
```

#### 4. Calls are not normally assigned to a manager but it does happen. How many calls have been assigned to staff who are at Manager Level?
``` SQL
 SELECT 
    COUNT(i.caller_id) AS mlcc
FROM
    Level l
        JOIN
    Staff s ON l.level_code = s.level_code
        JOIN
    Issue i ON s.staff_code = i.assigned_to
WHERE
    l.manager = 'Y'
GROUP BY l.manager;
```
#### 5.Show the manager for each shift. Your output should include the shift date and type; also the first and last name of the manager.

``` SQL
 SELECT 
    sf.shift_date,
    sf.shift_type,
    st.first_name,
    st.last_name
FROM
    Shift sf
        JOIN
    Staff st ON sf.manager = st.staff_code
ORDER BY sf.shift_date;
```

#### 6.List the Company name and the number of calls for those companies with more than 18 calls.
``` SQL
SELECT 
    c.company_name, COUNT(i.caller_id) AS cc
FROM
    Customer c
        JOIN
    Caller cl ON c.company_ref = cl.company_ref
        JOIN
    Issue i ON cl.caller_id = i.caller_id
GROUP BY c.company_name
HAVING COUNT(i.caller_id) > 18
```
#### 7.Find the callers who have never made a call. Show first name and last name
``` SQL
SELECT 
    c.first_name, c.last_name
FROM
    Caller c
        LEFT JOIN
    Issue i ON c.caller_id = i.caller_id
WHERE
    i.caller_id IS NULL;
```

#### 8.For each shift show the number of staff assigned. Beware that some roles may be NULL and that the same person might have been assigned to multiple roles (The roles are 'Manager', 'Operator', 'Engineer1', 'Engineer2').

``` SQL
SELECT 
    f.shift_date, f.shift_type, COUNT(DISTINCT role) AS cw
FROM
    (SELECT 
        shift_date, shift_type, manager AS role
    FROM
        Shift UNION SELECT 
        shift_date, shift_type, operator AS role
    FROM
        Shift UNION SELECT 
        shift_date, shift_type, engineer1 AS role
    FROM
        Shift UNION SELECT 
        shift_date, shift_type, engineer2 AS role
    FROM
        Shift) AS f
GROUP BY f.shift_date , f.shift_type;
```
#### 9.Caller 'Harry' claims that the operator who took his most recent call was abusive and insulting. Find out who took the call (full name) and when.
##### 1st way
``` SQL
SELECT 
    i.call_date, s.first_name, s.last_name
FROM
    Issue i
        JOIN
    Caller AS c ON i.caller_id = c.caller_id
        JOIN
    Staff s ON i.taken_by = s.staff_code
WHERE
    c.first_name = 'Harry'
ORDER BY i.call_date DESC
LIMIT 1;
```
##### 2nd way 
```SQL
SELECT 
    i.call_date, s.first_name, s.last_name
FROM
    Staff s
        JOIN
    (SELECT 
        i.call_date, i.taken_by
    FROM
        Issue i
    WHERE
        i.caller_id IN (SELECT 
                caller_id
            FROM
                Caller
            WHERE
                first_name = 'Harry')) AS i ON i.taken_by = s.staff_code
ORDER BY i.call_date DESC
LIMIT 1;
```

#### 10. Annoying customers. Customers who call in the last five minutes of a shift are annoying. Find the most active customer who has never been annoying.


``` SQL
SELECT 
    c.company_name, COUNT(*) AS abna
FROM
    Customer c
        JOIN
    Caller cl ON c.company_ref = cl.company_ref
        JOIN
    Issue i ON cl.caller_id = i.caller_id
WHERE
    c.company_name NOT IN (SELECT 
            c.company_name
        FROM
            Customer c
                JOIN
            Caller cl ON c.company_ref = cl.company_ref
                JOIN
            Issue i ON cl.caller_id = i.caller_id
        WHERE
            DATE_FORMAT(i.call_date, '%H:%i') BETWEEN '13:55' AND '14:00'
                OR DATE_FORMAT(i.call_date, '%H:%i') BETWEEN '19:55' AND '20:00')
GROUP BY company_name
ORDER BY COUNT(*) DESC
LIMIT 1
;
```





