USE fastcampus;
select * from tbl_purchase limit 10;
# (1) 7월 총 revenue
select sum(price)
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01";

# (2) 7월 MAU(Monthly Active Users)
select count(distinct customer_id)
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01";

# (3) 7월 active users 의 구매율
# 활성유저(purchase) / 전체유저(visit)
select * from tbl_visit limit 5;

select count(distinct customer_id)
from tbl_visit
where visited_at between "2020-07-01" and "2020-08-01";

select count(distinct customer_id) / (select count(distinct customer_id) from tbl_visit where visited_at between "2020-07-01" and "2020-07-31")
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01";

# (4) 7월 구매 유저의 평균 구매금액
# 고객 당 얼마를 썼는지 알아야 함
# 뭐야 이거 그냥 (1)/(2) 하면 됨
select customer_id, sum(price) as paying
from tbl_purchase
group by customer_id;

# (5) 고과금 유저 / top3 & top10-15
select customer_id, paying, rank() over(order by paying desc) as vip_rank
from (select customer_id, sum(price) as paying
from tbl_purchase
where purchased_at between "2020-07-01" and "2020-08-01"
group by customer_id) as A
limit 6 offset 9;


