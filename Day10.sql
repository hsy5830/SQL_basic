DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20)
);
INSERT INTO mypokemon (number, name)
VALUES (10, 'caterpie'),
(25, 'pikachu'),
(26, 'raichu'),
(133, 'eevee'),
(152, 'chikoirita');
CREATE TABLE ability (
number INT,
type VARCHAR(10),
height FLOAT,
weight FLOAT,
attack INT,
defense INT,
speed int
);
INSERT INTO ability (number, type, height, weight, attack, defense, speed)
VALUES (10, 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'electric', 0.4, 6, 55, 40, 90),
(26, 'electric', 0.8, 30, 90, 55, 110),
(133, 'normal', 0.3, 6.5, 55, 50, 55),
(152, 'grass', 0.9, 6.4, 49, 65, 45);

############################################### Lecture ###############################################
SELECT number, name, (SELECT height FROM ability WHERE number=25) AS height
FROM mypokemon
WHERE name="pikachu";

SELECT number, height_rank
FROM (SELECT number, rank() OVER(ORDER BY height DESC) AS height_rank FROM ability) AS A
WHERE height_rank = 3;

SELECT AVG(height)
FROM ability;

# 공격력이 모든 전기 포켓몬의 공격력보다 작은 포켓몬의 번호
SELECT number
FROM ability
WHERE attack < ALL(SELECT attack FROM ability WHERE type='electric');

SELECT number, name #이름까지 나오게 하기
FROM mypokemon
WHERE number IN (SELECT number
FROM ability
WHERE attack < ALL(SELECT attack FROM ability WHERE type='electric'));

# bug 타입 포켓몬이 모든 번호
SELECT number
FROM ability
WHERE EXISTS(SELECT * FROM ability WHERE type='bug');
############################################# Excercise 1 #############################################
# (1) 내 포켓몬 중 몸무게 가장 많이 나가는 포켓몬의 번호
SELECT number
FROM ability
ORDER BY weight DESC
LIMIT 1;

SELECT number
FROM ability
WHERE weight = (SELECT MAX(weight) FROM ability);

# (2) 속도가 모든 전기 포켓몬의 공격력보다 하나라도 작은 포켓몬의 번호
SELECT number
FROM ability
WHERE speed < ANY(SELECT attack FROM ability WHERE type='electric');

# (3) 공격력이 방어력보다 큰 모든 모켓몬의 이름
SELECT name
FROM mypokemon
WHERE number IN (SELECT number FROM ability
				WHERE attack > defense);
                
SELECT name # 큰 포켓몬들의 이름만 주는 게 아니라 전체 이름을 주면 atk > dfs 존재한다는 의미
FROM mypokemon
WHERE EXISTS (SELECT * FROM ability WHERE attack > defense);

############################################# Excercise 2 #############################################
# (1) 이브이 번호 133 활용해서 이브이의 영문 이름, 키, 몸무게 가져와
SELECT name, (SELECT height FROM ability WHERE number = 133) AS height,
			 (SELECT weight FROM ability WHERE number = 133) AS weight
FROM mypokemon
WHERE number=133;

SELECT (SELECT name FROM mypokemon WHERE number = 133) AS name, height, weight
FROM ability
WHERE number=133;

# (2) 속도 2번째로 빠른 포켓몬 번호, 속도
SELECT number, speed
FROM (SELECT number, speed ,rank() OVER(ORDER BY speed DESC) AS speed_rank FROM ability) AS A
WHERE speed_rank = 2;

# (3) 방어력이 모든 전기 포켓몬의 방어력보다 큰 포켓몬 이름
SELECT name
FROM mypokemon
WHERE number IN (SELECT number FROM ability WHERE defense > ALL(SELECT defense FROM ability WHERE type='electric'));
