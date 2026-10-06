CREATE DATABASE sql_island;
USE sql_island;

CREATE TABLE villages (
    villageid INT PRIMARY KEY,
    name VARCHAR(100),
    chief INT
);

INSERT INTO villages (villageid, name, chief) VALUES
(1, 'Monkeycity', 1),
(2, 'Cucumbertown', 6),
(3, 'Onionville', 13);

CREATE TABLE persons (
    personid INT PRIMARY KEY,
    name VARCHAR(100),
    villageid INT,
    gender CHAR(1),
    job VARCHAR(50),
    gold INT,
    state VARCHAR(50),
    FOREIGN KEY (villageid) REFERENCES villages(villageid)
);
INSERT INTO persons (personid, name, villageid, gender, job, gold, state) VALUES
(1, 'Paul Bakerman', 1, 'm', 'baker', 850, 'friendly'),
(2, 'Ernest Perry', 3, 'm', 'weaponsmith', 280, 'friendly'),
(3, 'Rita Ox', 1, 'f', 'baker', 350, 'friendly'),
(4, 'Carl Ox', 1, 'm', 'merchant', 250, 'friendly'),
(5, 'Dirty Dieter', 3, 'm', 'smith', 650, 'evil'),
(6, 'Gerry Slaughterer', 2, 'm', 'butcher', 4850, 'evil'),
(7, 'Peter Slaughterer', 3, 'm', 'butcher', 3250, 'evil'),
(8, 'Arthur Tailor', 2, 'm', 'pilot', 490, 'kidnapped'),
(9, 'Tiffany Drummer', 1, 'f', 'baker', 550, 'evil'),
(10, 'Peter Drummer', 1, 'm', 'smith', 600, 'friendly'),
(11, 'Dirty Diane', 3, 'f', 'farmer', 10, 'evil'),
(12, 'Otto Alexander', 2, 'm', 'dealer', 680, 'friendly'),
(13, 'Fred Dix', 3, 'm', 'author', 420, 'friendly'),
(14, 'Enrico Carpenter', 3, 'm', 'weaponsmith', 510, 'evil'),
(15, 'Helen Grasshead', 2, 'f', 'dealer', 680, 'friendly'),
(16, 'Ivy Hatter', 1, 'f', 'dealer', 770, 'evil'),
(17, 'Edward Grasshead', 3, 'm', 'butcher', 990, 'friendly'),
(18, 'Ryan Horse', 3, 'm', 'blacksmith', 390, 'friendly'),
(19, 'Ann Meaty', 2, 'f', 'butcher', 2280, 'friendly');


CREATE TABLE items (
    itemid INT AUTO_INCREMENT PRIMARY KEY,
    item VARCHAR(100),
    owner INT NULL,
    FOREIGN KEY (owner) REFERENCES persons(personid)
);


INSERT INTO items (item, owner) VALUES
('teapot', NULL),
('cane', 5),
('hammer', 2),
('ring', NULL),
('coffee cup', NULL),
('bucket', NULL),
('rope', 17),
('carton', NULL),
('lightbulb', NULL);

-- 1. Wealthy Friends
SELECT name, gold
FROM persons
WHERE state = 'friendly' AND gold > 500
ORDER BY gold DESC;

-- 2. The Great Village Join
SELECT persons.name AS person_name, villages.name AS village_name
FROM persons
JOIN villages ON persons.villageid = villages.villageid;

-- 3. Job Popularity Contest
SELECT job, COUNT(*) AS employee_count
FROM persons
GROUP BY job
ORDER BY employee_count DESC;

-- 4. Merchant's Inventory
SELECT items.*
FROM items
JOIN persons ON items.owner = persons.personid
WHERE persons.job IN ('dealer', 'merchant');

-- 5. Gender Wealth Gap Analysis
SELECT gender, AVG(gold) AS average_gold
FROM persons
GROUP BY gender;

-- 6. The "Smith" Search
SELECT name, job, gold
FROM persons
WHERE job LIKE '%smith' AND state = 'friendly';

-- 7. Finding the Boss
SELECT persons.name, persons.gold
FROM villages
JOIN persons ON villages.chief = persons.personid
WHERE villages.name = 'Onionville';

-- 8. Village Gold Reserves
SELECT villages.name AS village_name, SUM(persons.gold) AS total_gold
FROM villages
JOIN persons ON villages.villageid = persons.villageid
GROUP BY villages.villageid, villages.name
ORDER BY total_gold DESC;

-- 9. Restricted Job List
SELECT job, AVG(gold) AS average_gold
FROM persons
GROUP BY job
HAVING AVG(gold) > 400;