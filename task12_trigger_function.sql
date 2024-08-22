select * from sales

create table report_table(
	product_id varchar,
	sumofsales float,
	sumofprofit float
)    

create or replace function update_report()
RETURNS trigger as $$
declare 
	sum_of_sales float;
	sum_of_profit float;
	count_report int;
BEGIN
	select sum(sales) , sum(profit) into sum_of_sales, sum_of_profit from sales 
	where product_id = NEW.product_id;

	select count(*) into count_report from report_table where product_id=NEW.product_id;

	if count_report = 0 THEN
	insert into report_table values (NEW.product_id, sum_of_sales,sum_of_profit);
	else
		update report_table set sumofsales = sum_of_sales, sumofprofit = sum_of_profit 
		where product_id = New.product_id;     
		
	end if;
	Return New;
END
$$ Language plpgsql

create trigger update_report_trigger
After insert on sales
for each row
execute function update_report()

select * from sales

select sum(sales),sum(profit) from sales where product_id='OFF-LA-10000240'
--153.51,64.4011

insert into sales values(9997,'CA-2016-138689','2024-08-20','2024-08-22','Standard Class','DS-14505','OFF-LA-10000240',200,20,3,50)

select * from sales order by order_line DESC

select * from report_table
--OFF-LA-10000240,353.51,114.4011

insert into sales values(9997,'CA-2016-138689','2024-08-20','2024-08-22','Standard Class','DS-14505','OFF-LA-10000240',200,20,3,50)

select * from report_table
--OFF-LA-10000240,553.51,164.40109999999999