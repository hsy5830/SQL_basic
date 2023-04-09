USE fastcampus;
select * from tbl_customer limit 10;
############################################### Lecture ###############################################
select distinct gender from tbl_customer;
select distinct age from tbl_customer
order by 1;

############################################### 문제풀이 ##############################################
## (12) 전체 유저의 Demographic. 성별, 연령별 유저 숫자
#      어떤 segment의 숫자가 가장 많은지. 기타 성별은 하나로, 연령은 5세 단위로 묶고 유저 수 높은 순서로
# gender null -> "" 로 돼있는 걸 확인함

-- select case when length(gender)<1 then 'Others'
-- 			else gender
--             end as gender,
-- 	   floor(age/5) as age_itv,
--        count(*)
-- from tbl_customer
-- group by 1,2; 


select case when length(gender)<1 then 'Others'
			else gender
            end as gender,
	   case when age <= 15 then '0_15세 이하'
			when age <= 20 then '1_16~20세'
            when age <= 25 then '2_21~25세'
            when age <= 30 then '3_26~30세'
            when age <= 35 then '4_31~35세'
            when age <= 40 then '5_36~40세'
            when age <= 45 then '6_41~45세'
            when age >= 46 then '7_46세 이상' end as age,
	   count(*)
from tbl_customer
group by 1,2
order by 3 desc;

## (13) (12)의 성,연령을 "남성(26~30세)"로 통합, 각각의 분포(%) 계산하여 높은 순서대로.

select concat(case when length(gender)<1 then '기타'
			when gender = 'Others' then "기타"
            when gender = 'M' then "남성"
            when gender = 'F' then "여성"
            end, "(",
	   case when age <= 15 then '15세 이하'
			when age <= 20 then '16~20세'
            when age <= 25 then '21~25세'
            when age <= 30 then '26~30세'
            when age <= 35 then '31~35세'
            when age <= 40 then '36~40세'
            when age <= 45 then '41~45세'
            when age >= 46 then '46세 이상' end, ")") as segment,
	   round(count(*)/14225*100, 1) as "percentage"
       -- round(count(*)/(select count(*) from tbl_customer)*100, 1) as "percentage" ----> 얘도 정답
from tbl_customer
group by 1
order by 2 desc;
select count(1) from tbl_customer; # 14225


## (14) 20년 7월, 성별에 따라 총 구 구매 건수, 총 revenue.
select * from tbl_purchase;
select gender from tbl_customer;

select case when length(B.gender)<1 then 'Others'
			else B.gender
            end as gender,
	   count(*),
       sum(price) as revenue
from tbl_purchase as A
left join tbl_customer as B
on A.customer_id = B.customer_id
where A.purchased_at between "2020-07-01" and "2020-08-01"
group by 1;

## (15) 2020년 7월 성,연령별 구매 건수와 총 revenue
select concat(case when length(gender)<1 then '기타'
			when gender = 'Others' then "기타"
            when gender = 'M' then "남성"
            when gender = 'F' then "여성"
            end, "(",
	   case when age <= 15 then '15세 이하'
			when age <= 20 then '16~20세'
            when age <= 25 then '21~25세'
            when age <= 30 then '26~30세'
            when age <= 35 then '31~35세'
            when age <= 40 then '36~40세'
            when age <= 45 then '41~45세'
            when age >= 46 then '46세 이상' end, ")") as segment,
	   count(*) as count,
       sum(price) as 
from tbl_customer
group by 1,2
order by 3 desc;


select concat(case when length(B.gender)<1 then '기타'
			when B.gender = 'Others' then "기타"
            when B.gender = 'M' then "남성"
            when B.gender = 'F' then "여성"
            end, "(",
	   case when B.age <= 15 then '15세 이하'
			when B.age <= 20 then '16~20세'
            when B.age <= 25 then '21~25세'
            when B.age <= 30 then '26~30세'
            when B.age <= 35 then '31~35세'
            when B.age <= 40 then '36~40세'
            when B.age <= 45 then '41~45세'
            when B.age >= 46 then '46세 이상' end, ")") as segment,
	   count(*) as count,
       sum(price) as revenue
from tbl_purchase as A
left join tbl_customer as B
on A.customer_id = B.customer_id
where A.purchased_at between "2020-07-01" and "2020-08-01"
group by 1
order by 3 desc;

## (18) 2020년 7월 일별 매출의 전일 대비 증감폭, 증감률
with tbl_revenue as (
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as pur_date,
	sum(price) as revenue
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01"
group by 1
)

# 새로운 함수 사용
-- select *, lag(revenue) over(order by pur_date asc) as revenue_yesterday,
-- 		revenue - revenue_yesterday as increase,
--         revenue / revenue_yesterday as increase_ratio
-- from tbl_revenue;

select *,
	   revenue - lag(revenue) over(order by pur_date asc) as increase,
       round((revenue - lag(revenue) over(order by pur_date asc)) / lag(revenue) over(order by pur_date asc)*100, 2) as increase_ratio
		
from tbl_revenue;


## (19) 2020년 7월 일별 고과금 유저
select *
from (select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as pur_date,
	   customer_id,
       sum(price),
       dense_rank() over (partition by date_format(purchased_at - interval 9 hour, '%Y-%m-%d') order by sum(price) desc) as rev_rank # 동점자도 포함하기 위함
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01"
group by 1,2) as A
where rev_rank < 4;