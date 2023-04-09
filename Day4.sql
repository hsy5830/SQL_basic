# pokemon 데이터베이스 만들기
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (

number int,
name varchar(20),
type varchar(20),
height float,
weight float,
attack float,
defense float,
speed float
);

INSERT INTO mypokemon (number, name, type, height, weight, attack, defense, speed)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
(26, 'raichu', 'electric', 0.8, 30, 90, 55, 110),
(133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
(152, 'chikoirita', 'grass', 0.9, 6.4, 49, 65, 45);

############################################# Lecture #############################################
SELECT * FROM mypokemon;

SELECT number FROM mypokemon WHERE name="pikachu";
SELECT name FROM mypokemon WHERE speed>50;
SELECT name FROM mypokemon WHERE speed<100 AND type="electric";
SELECT name FROM mypokemon WHERE speed<=100 AND NOT(type="bug");

# 'chu'로 끝나는 포켓몬 이름
SELECT name FROM mypokemon WHERE name LIKE "%chu";
# 이름에 'a'가 포함되는 포켓몬 이름
SELECT name FROM mypokemon WHERE name LIKE "%a%";

### NULL data
INSERT INTO mypokemon (name, type)
VALUES ("kkobugi", '');

SELECT * FROM mypokemon;

# number가 NULL인 포켓몬 이름
SELECT name FROM mypokemon WHERE number IS NULL;

############################################# Excercise #############################################
# (1), (2)
SELECT type FROM mypokemon WHERE name="eevee";
SELECT attack, defense FROM mypokemon WHERE name="caterpie";

# (3) ~ (8)
SELECT * FROM mypokemon WHERE weight > 6;
SELECT name FROM mypokemon WHERE height>0.5 AND weight >= 6;
SELECT name AS 'weak_pokemon' FROM mypokemon WHERE attack<50 OR defense<50;
SELECT * FROM mypokemon WHERE type != 'normal';

SELECT name, type FROM mypokemon WHERE type IN ('normal', 'fire', 'water', 'grass');
SELECT name, attack FROM mypokemon WHERE attack BETWEEN 40 AND 60;

# (9) ~ (14)
SELECT name FROM mypokemon WHERE name LIKE '%e%';
SELECT * FROM mypokemon WHERE speed <= 50 AND name LIKE '%i%';
SELECT name, height, weight FROM mypokemon WHERE name LIKE '%chu';
SELECT name, defense FROM mypokemon WHERE name LIKE '%e' AND defense < 50;
SELECT name, attack, defense FROM mypokemon WHERE attack-defense > 10; 
SELECT name, attack+defense+speed AS total FROM mypokemon WHERE attack+defense+speed >= 150;