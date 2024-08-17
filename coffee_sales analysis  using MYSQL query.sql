use coffee_sales;
select*from `coffee sales`;
describe `coffee sales`;

--- to change the data type on card column from text to varchar

alter table `coffee sales`
MODIFY  column card  VARCHAR(200);

--- rename table name to the on the data base
ALTER TABLE `coffee sales`
rename `coffee_sales`;
describe coffee_sales;

---- to modify date from text data type to date data type
alter table coffee_sales
modify date DATE;

---- TO modify datetime from text data type to datetime data type

alter table coffee_sales
modify datetime DATETIME;

select*from coffee_sales;

--- checking for all the possible kpi of the data
create view total_sales as
-- total sales revenue ( this KPI tracks the total sales)
select sum(money) as  `total_sales`
from coffee_sales;

--- sales by payment method ( this KPI help us undestand the distribution of sales across different payment type (cash and card)
create view `sales by payment method` as
select cash_type, sum(money) as `total sales`
from coffee_sales
group by cash_type;

---- sales by coffee type: this kpi will shows which of the coffee types is more popular
create view `sales by coffee type` as
select coffee_name, sum(money) as `total sales`
from coffee_sales 
group by coffee_name
order by `total sales` desc;

---- sales by date (this KPI track daily sales)
create view `daily sales` as
select `date`, sum(money) as `total sales`
from coffee_sales
group by `date`
order by `date`;

--- sales by time of the day( this kpi shows the trends of sale for the whole day)
create view `sales bt time of the day` as
 select hour(`datetime`) as `hours a day`, sum(money) as `total sales`
 from coffee_sales
 group by `hours a day`
 order by `hours a day`;
 
 --- daily sales (total sales in a day)
 
 select * from coffee_sales;
 --- sales volume by coffee type( this KPI counts the number of sales for each  type coffee)
 create view `sales volume by coffee` as
 select coffee_name,  count(*) as sales_count
 from coffee_sales
 group by coffee_name
 order by sales_count  desc;
 
 ---- average transaction values( this kpi calculate average spent by transaction)
 create view `average transaction values` as
 select avg(money) as average_transaction_values
 from coffee_sales;
 
 ----- sales distribution by payment method
 create view `percentage sales distribution` as
 select cash_type, count(*) *100.0 / (select count(*) from coffee_sales) as percentage
 from coffee_sales
 group by cash_type;
 
 --- top selling coffee (this kpi show the most top selling coffee )
create view `top selling coffee` as 
select coffee_name, sum(money) as `top selling coffee`
from coffee_sales
group by coffee_name
order by `top selling coffee` desc
limit 1;
