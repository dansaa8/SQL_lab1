USE laboration1;

-- Uppgift 1
CREATE TABLE successful_mission AS
SELECT *
FROM moon_mission
WHERE outcome = 'Successful';

-- Uppgift 2
ALTER TABLE successful_mission
    MODIFY mission_id INT AUTO_INCREMENT PRIMARY KEY;

-- Uppgift 3
UPDATE successful_mission
SET operator = REPLACE(operator, ' ', '');

UPDATE moon_mission
SET operator = REPLACE(operator, ' ', '');

-- Uppgift 4
DELETE
FROM successful_mission
WHERE YEAR(launch_date) >= 2010;

-- Uppgift 5
SELECT user_id,
       name,
       password,
       CONCAT(first_name, ' ', last_name) AS name,
       ssn,
       CASE
           WHEN SUBSTRING(ssn, -2, 1) % 2 = 0 THEN 'female'
           ELSE 'male'
           END
           AS gender
FROM account;

-- Uppgift 6
DELETE
FROM account
WHERE LENGTH(ssn) = 11
  AND SUBSTRING(ssn, 1, 2) < 70
  AND SUBSTRING(ssn, -2, 1) % 2 = 0;

-- Uppgift 7
SELECT CASE
           WHEN SUBSTRING(ssn, -2, 1) % 2 = 0 THEN 'female'
           ELSE 'male'
           END AS gender,
       AVG(
               CASE
                   WHEN SUBSTRING(ssn, 1, 2) > DATE_FORMAT(NOW(), '%y') THEN
                       DATE_FORMAT(NOW(), '%Y') - (SUBSTRING(ssn, 1, 2) + 1900)
                   ELSE
                       DATE_FORMAT(NOW(), '%Y') - (SUBSTRING(ssn, 1, 2) + 2000)
                   END
       )       AS average_age
FROM account
GROUP BY gender;