# pokemon 데이터베이스 만들기
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20),
type VARCHAR(10),
attack INT,
defense INT,
capture_date DATE
);
INSERT INTO mypokemon (number, name, type, attack, defense, capture_date)
VALUES (10, 'caterpie', 'bug', 30, 35, '2019-10-14'),
(25, 'pikachu', 'electric', 55, 40, '2018-11-04'),
(26, 'raichu', 'electric', 90, 55, '2019-05-28'),
(125, 'electabuzz', 'electric', 83, 57, '2020-12-29'),
(133, 'eevee', 'normal', 55, 50, '2021-10-03'),
(137, 'porygon', 'normal', 60, 70, '2021-01-16'),
(152, 'chikoirita', 'grass', 49, 65, '2020-03-05'),
(153, 'bayleef', 'grass', 62, 80, '2022-01-01');

############################################# Lecture #############################################

SELECT number, name FROM mypokemon
ORDER BY number DESC;

# 아래의 두 쿼리는 같은 명령
SELECT number, name, attack, defense FROM mypokemon
ORDER BY attack DESC, defense;

SELECT number, name, attack, defense FROM mypokemon
ORDER BY 3 DESC, 4;

# RANK
SELECT name, attack, RANK() OVER (ORDER BY attack DESC) AS attack_rank
FROM mypokemon;
SELECT name, attack, DENSE_RANK() OVER (ORDER BY attack DESC) AS attack_rank FROM mypokemon;
SELECT name, attack, ROW_NUMBER() OVER (ORDER BY attack DESC) AS attack_rank FROM mypokemon;

SELECT name, attack,
	RANK() OVER (ORDER BY attack DESC) AS rank_rank,
    DENSE_RANK() OVER (ORDER BY attack DESC) AS rank_dense_rank,
    ROW_NUMBER() OVER (ORDER BY attack DESC) AS rank_row_number
FROM mypokemon;

### 문자열
SELECT LENGTH('abc');

SELECT NOW(), CURRENT_DATE(), CURRENT_TIME();
SELECT NOW(), DAYNAME(NOW()), DAYOFMONTH(NOW()), DAYOFWEEK(NOW()), WEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%Y년 %m월 %d일 %H시 %i분 %s초') AS formatted_date;

############################################# Excercise 1 #############################################
SELECT * FROM mypokemon;

# (1)
SELECT name, LENGTH(name) FROM mypokemon ORDER BY LENGTH(name);

# (2)
SELECT name, defense ,RANK() OVER (ORDER BY defense DESC) AS defense_rank FROM mypokemon;

# (3)
SELECT name, DATEDIFF('2022-02-14', capture_date) AS days FROM mypokemon;



############################################# Excercise 2 #############################################
SELECT * FROM mypokemon;

# (1), (2)
SELECT RIGHT(name, 3) AS last_char FROM mypokemon;
SELECT LEFT(name, 2) AS left2 FROM mypokemon;

# (3)
SELECT REPLACE(name, 'o', 'O') AS bigO FROM mypokemon WHERE name like '%o%';

# (4)
SELECT name, UPPER(CONCAT(LEFT(type, 1), RIGHT(type, 1))) AS type_code FROM mypokemon;

# (5)
SELECT * FROM mypokemon WHERE LENGTH(name) > 8;

# (6), (7)
SELECT ROUND(AVG(attack), 0) AS avg_of_attack FROM mypokemon;
SELECT FLOOR(AVG(defense)) AS avg_of_defense FROM mypokemon;

# (8), (9)
SELECT name, POWER(attack, 2) AS attack2 FROM mypokemon WHERE LENGTH(name)<8;
SELECT name, MOD(attack,2) AS div2 FROM mypokemon;

# (10)
SELECT name, ABS(attack - defense) AS diff
FROM mypokemon
WHERE attack <= 50;

# (11)
SELECT CURRENT_DATE() AS now_date, CURRENT_TIME() AS now_time;

# (12)
SELECT MONTH(capture_date) AS month_num, MONTHNAME(capture_date) AS month_eng FROM mypokemon;

# (13)
SELECT DAYOFWEEK(capture_date) AS day_num, DAYNAME(capture_date) AS day_eng FROM mypokemon;

# (14)
SELECT YEAR(capture_date) AS year,
	   MONTH(capture_date) AS month,
       DAY(capture_date) AS day
FROM mypokemon;

