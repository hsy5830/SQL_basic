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
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
(25, 'pikachu', 'electric', 55, 40),
(26, 'raichu', 'electric', 90, 55),
(125, 'electabuzz', 'electric', 83, 57),
(133, 'eevee', 'normal', 55, 50),
(137, 'porygon', 'normal', 60, 70),
(152, 'chikoirita', 'grass', 49, 65),
(153, 'bayleef', 'grass', 62, 80),
(172, 'pichu', 'electric', 40, 15),
(470, 'leafeon', 'grass', 110, 130);


############################################# Lecture #############################################
SELECT name, IF(attack>=60, 'strong', 'weak') AS attack_class
FROM mypokemon;

SELECT name,
CASE 
	WHEN attack >= 100 THEN 'very strong'
    WHEN attack >= 60 THEN 'strong'
    ELSE 'weak'
END AS attack_class
FROM mypokemon;
############################################# Excercise 1 #############################################
DROP FUNCTION isStrong;
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //

CREATE FUNCTION isStrong(attack INT, defense INT)
		RETURNS VARCHAR(20)
BEGIN
			DECLARE atk INT;
            DECLARE dfs INT;
            DECLARE sum INT;
            DECLARE rslt VARCHAR(20);
            SET atk = attack;
            SET dfs = defense;
            SELECT atk + dfs INTO sum;
            SELECT CASE
				WHEN sum > 120 THEN 'very strong'
                WHEN sum > 90 THEN 'strong'
                ELSE 'not strong'
			END INTO rslt;
            RETURN rslt;
END 
//
DELIMITER ;

SELECT name, isStrong(attack, defense) AS isStrong FROM mypokemon;

############################################# Excercise 2 #############################################
# (1)
SELECT name, IF(number<150, 'old', 'new') AS age 
FROM mypokemon;

# (2)
SELECT name, IF(attack+defense<100, 'weak', 'strong') AS ability 
FROM mypokemon;

# (3)
SELECT type, IF(AVG(attack)>=60, 1, 0) AS is_strong_type
FROM mypokemon
GROUP BY type;

# (4)
SELECT name, IF(attack>100 AND defense>100, 1, 0) AS ace
FROM mypokemon;

# (5)
SELECT name,
CASE
	WHEN number<100 THEN '<100'
    WHEN number<200 THEN '<200'
    WHEN number<500 THEN '<500'
END AS 'number_bin'
FROM mypokemon;

# (6)
SELECT name,
CASE
	WHEN number>=150 AND attack >= 50 THEN 'new_strong'
    WHEN number>=150 AND attack < 50 THEN 'new_weak'
    WHEN number<150 AND attack >= 50 THEN 'old_strong'
    ELSE 'old_weak'
END AS 'age_attack'
FROM mypokemon;

# (7)
SELECT type,
CASE
	WHEN COUNT(*)=1 THEN 'solo'
    WHEN COUNT(*)>=3 THEN 'major'
    ELSE 'minor'
END AS count_by_type
FROM mypokemon
GROUP BY type;
