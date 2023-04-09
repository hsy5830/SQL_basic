DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20),
type varchar(10),
attack int,
defense int
);
CREATE TABLE friendpokemon (
number int,
name varchar(20),
type varchar(10),
attack int,
defense int
);
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
(25, 'pikachu', 'electric', 55, 40),
(26, 'raichu', 'electric', 90, 55),
(133, 'eevee', 'normal', 55, 50),
(152, 'chikoirita', 'grass', 49, 65);
INSERT INTO friendpokemon (number, name, type, attack, defense)
VALUES (26, 'raichu', 'electric', 80, 60),
(125, 'electabuzz', 'electric', 83, 57),
(137, 'porygon', 'normal', 60, 70),
(153, 'bayleef', 'grass', 62, 80),
(172, 'pichu', 'electric', 40, 15),
(470, 'leafeon', 'grass', 110, 130);

############################################# Excercise 1 #############################################
# (1)
SELECT type
FROM mypokemon
UNION
SELECT type
FROM friendpokemon;

# (2)
SELECT number, name, "my" AS whose
FROM mypokemon
WHERE type="grass"
UNION ALL
SELECT number, name, "friend"
FROM friendpokemon
WHERE type="grass";


############################################# Excercise 2 #############################################
# (1)
SELECT A.name
FROM mypokemon AS A
INNER JOIN friendpokemon AS B
ON A.name = B.name;

# (2)
SELECT mypokemon.name
FROM mypokemon
LEFT JOIN friendpokemon
ON mypokemon.name = friendpokemon.name
WHERE friendpokemon.name IS NULL;

-- SELECT *
-- FROM mypokemon
-- LEFT JOIN friendpokemon
-- ON mypokemon.name = friendpokemon.name