USE fastcampus;
select * from tbl_purchase limit 10;
############################################### Lecture ###############################################
SELECT NOW();
SELECT CURRENT_DATE();
SELECT EXTRACT(MONTH FROM '2021-01-01');
SELECT DAY('2021-01-01');
SELECT DATE_ADD('2021-01-01', INTERVAL 7 DAY);
SELECT DATE_SUB('2017-06-15', INTERVAL 7 DAY);
SELECT DATEDIFF("2017-06-25", "2017-06-15");
SELECT TIMEDIFF("2021-01-25 12:10:00", "2021-01-25 10:10:00");
SELECT DATE_FORMAT(NOW(), "%Y-%m-%d");
############################################### 문제풀이 ##############################################
# (6) 2020년 7월 평균 DAU. Active user수가 증가하는 추세?
select avg(act_user)
from (select date_format(visited_at - interval 9 hour, '%Y-%m-%d') as date_at, count(distinct customer_id) as act_user
from tbl_visit
where visited_at between "2020-07-01" and "2020-08-01"
group by 1
order by 1) as A;

select *, date_format(visited_at, '%Y-%m-%d %T'), date_format(visited_at - interval 9 hour, '%Y-%m-%d %T')
from tbl_visit
where visited_at between "2020-07-01" and "2020-08-01";

# (7) 2020년 7월 평균 WAU. Active user수가 증가하는 추세?
select avg(act_user)
from (select date_format(visited_at - interval 9 hour, '%Y-%m-%U') as week_at, count(distinct customer_id) as act_user
from tbl_visit
where visited_at between "2020-07-05" and "2020-07-26"
group by 1
order by 1) as A;

# (8) 2020년 7월 daily avenue 증가? 평균?
#     2020년 7월 weekly avenue 평균
select *
from tbl_purchase;

select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at, sum(price)
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01"
group by 1;

select avg(total_ave)
from (select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at, sum(price) as total_ave
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01"
group by 1) as A;

select avg(total_ave)
from (select date_format(purchased_at - interval 9 hour, '%Y-%m-%U') as week_at, sum(price) as total_ave
from tbl_purchase
where purchased_at between "2020-07-05" and "2020-07-26"
group by 1
order by 1) as A;

# (9) 요일 별 avenue
select date_format(purchased_at - interval 9 hour, '%W') as wkday, sum(price)
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01"
group by wkday;
