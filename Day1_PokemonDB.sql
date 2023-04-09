##### [실습 1] #####

# 데이터베이스 만들기
CREATE DATABASE pokemon;
USE pokemon;

# 테이블 만들기1
CREATE TABLE mypokemon (  # CREATE TABLE pokemon.mypokemon; 으로 USE 사용하지 않고 한번에 가능
	number INT,
    name VARCHAR(20),
    type VARCHAR(10)
);


# 데이터 삽입1
INSERT INTO mypokemon (number, name, type)
VALUES (10, "caterpie", "bug"),
	   (25, "pikachu", "electric"),
       (133, "eevee", "normal");
              

# 테이블 만들기2
CREATE TABLE mynewpokemon (
	number INT,
    name VARCHAR(20),
    type VARCHAR(10)
);

# 데이터 삽입2
INSERT INTO mynewpokemon (number, name, type)
VALUES (77, "포니타", "불꽃"),
	   (132, "메타몽", "노말"),
       (151, "뮤", "에스퍼");

## 테이블 조회
SELECT * FROM mypokemon;
SELECT * FROM mynewpokemon;




##### [실습 2] #####
ALTER TABLE mypokemon RENAME myoldpokemon;
ALTER TABLE myoldpokemon CHANGE COLUMN name eng_name VARCHAR(20);
ALTER TABLE mynewpokemon CHANGE COLUMN name kor_name VARCHAR(20);

SELECT * FROM myoldpokemon;
SELECT * FROM mynewpokemon;

# 테이블 삭제
TRUNCATE TABLE myoldpokemon;
DROP TABLE mynewpokemon;

SELECT * FROM myoldpokemon;
SELECT * FROM mynewpokemon; # error


### 실습 종료 - DB 지우기
DROP DATABASE pokemon;