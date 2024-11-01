/* Identify consecutive Sucess and failure as data ranges */
Input 
2019-01-01	success
2019-01-02	success
2019-01-03	success
2019-01-04	fail
2019-01-05	fail
2019-01-06	success

Expected Output
2019-01-01	2019-01-03	success
2019-01-04	2019-01-05	fail
2019-01-06	2019-01-06	success

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')

select * from tasks

One of the Solution
--------------------------
with cte as
(
Select date_value,state,lag(state) over(order by date_value) as state_lag from tasks
),
cte2 as
(
select *, sum(case when state<>state_lag then 1 else 0 end) over(order by date_value) as flg from cte
)
select 
min(date_value) as Start_date,
max(date_value) as end_date,
state
from cte2 group by state,flg

--------------------------------------------

