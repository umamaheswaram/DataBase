-- List the names and data types for each table in the database.
 
select column_name, data_type from INFORMATION_SCHEMA.COLUMNS where
table_name='booking'; -- PRAGMA table_info('Table_name')

/* Pull the relevant columns from the ksprojects table that will allow us to assess a project's 
result based on its main category, amount of money set as a goal, number of backers, and amount 
of money pledged. Return just the first 10 rows.
*/
select main_category,goal,backers,pledged from ksprojects 
limit 10;

/* Repeat your query from the previous screen, but this time only keep the records 
where the project state is either 'failed', 'canceled', or 'suspended'.
*/
SELECT *
  FROM ksprojects
 where state in('failed','canceled', 'suspended')-- or state='suspended'
LIMIT 10;

/* Expand your query from the previous screen to find which of these projects had 
at least 100 backers and at least $20,000 pledged.
*/
SELECT main_category,backers,pledged,goal
 FROM ksprojects
WHERE state IN ('failed', 'canceled', 'suspended') and
backers>=100 AND pledged>=20000
LIMIT 10;

/*

1. Continue building on your query from the previous screen. This time, you'll sort the results by two fields:
	i. Main category sorted in ascending order.
	ii. A calculated field called pct_pledged, which divides pledged by goal. 
		Sort this field in descending order. (Add pct_pledged to the SELECT clause, too.)
2. Now, modify your query so that only projects in a failed state are returned.
*/
SELECT main_category, backers, pledged, goal, pledged/goal as pct_pledged
  FROM ksprojects
 WHERE state IN ('failed')
   AND backers >= 100 AND pledged >= 20000
   ORDER by main_category asc, pct_pledged desc
 LIMIT 10;
 
 /*
1. Create a field funding_status that applies the following logic based on the percentage of amount pledged to campaign goal:
	i. If the percentage pledged is greater than or equal to 1, then the project is "Fully funded".
	ii. If the percentage pledged is between 75% and 100%, then the project is "Nearly funded".
	iii. If the percentage pledged is less than 75%, then the project is "Not nearly funded".
2. Write either a line or block comment with your observations about the funding status of the sample output. 
	For example, are these failed projects failing because they don't have any backers or funding?
 */
 
 /*
 Write your own query to explore the data in a way that sounds interesting to you. 
 For example, you could look at projects from a given category you'd be inclined to purchase from.
*/
SELECT main_category, name, state, backers, pledged, goal, 
       pledged / goal AS pct_pledged,
       CASE 
           WHEN pledged / goal >= 1 THEN 'Fully Funded'
           WHEN pledged / goal > 0.75 AND pledged / goal < 1 THEN 'Nearly Funded'
           ELSE 'Not Nearly Funded'
       END AS funding_status
FROM ksprojects
WHERE main_category = 'Technology' and 
state in('filed', 'successful') and 
backers >= 100 AND pledged >= 20000
ORDER BY main_category, pct_pledged DESC
limit 10;

-- Pull all columns and the first five rows from orders to preview what this table looks like.
SELECT * from orders
order by order_date
limit 5;

-- Modify their query to run in SQLite.
SELECT *
  FROM returns
  limit 4;

/*
 Write a query from the orders table that only selects relevant fields:
order_date
order_id
product_name
sales
quantity
Limit the number of records to 5.
*/
SELECT order_date,order_id,product_name,sales,quantity
from orders
limit 5;

/*
1. Create a field called address that combines city, state, and postal_code in the following format:
city, state 99999
2. Calculate a total_cost field cost as sales, shipping, and tax. (Shipping costs 4.99 and tax is calculated at 7%). Round the field to two decimal places.
3. Create a field called tax that finds 7% of sales, rounded to two decimal places.
4. Create a field called shipping_cost with a value of 4.99.
5. For readability, your final query should include the following fields:
	address
	sales
	tax
	shipping_cost
	total_cost
6. Limit your results to 10 rows.
*/
SELECT city ||','|| state ||','|| postal_code as address,
sales, ROUND(sales * 0.07 ,2) as tax,
4.99 as shipping_cost,
ROUND(sales+(sales*0.07)+4.99,2) as total_cost
from orders
LIMIT 10;



/******************************************FIELDS*************************************************
order_id	order_date	ship_date	ship_mode	customer_id 	customer_name	segment		country		city	subcategory		product_name	sales	quantity	discount	profit
*******************************************************************************************/


/*
1. Write a query that includes order_id, product_name, sales, discount, and profit.
2. Filter your results so that your query only shows records that have lost more than $1000.
*/
SELECT order_id, product_name, sales, discount, profit
from orders
WHERE
profit<=-1000;

/*
1. Write a query that includes order_id, subcategory, product_name, and a calculated field aliased price_per_unit.
2. Filter your query so you only see records with a price_per_unit less than $0.50.
*/
SELECT order_id, subcategory,product_name, 
sales/quantity as price_per_unit
from orders
WHERE sales/quantity<=0.50;

/*
Write a query that returns the order_id, product_id, and a field that shows a 10% sales tax on sales, aliased as sales_tax.
Get the records where the resulting sales tax is between 1 and 2 dollars.
*/
SELECT order_id, product_id, (sales/100)*10 as sales_tax
from orders
where (sales/100)*10 BETWEEN 1 and 2;

/*
1. Write a query that includes order_id, product_name, sales, and quantity from the orders table.
2. Include only the following sales amounts:
	3
	14
	15
*/
SELECT order_id,product_name,sales,quantity
from orders
where sales In(3,14,15)

/*
1. Write a query that identifies all missing values from the segment field.
2. Include all fields.
3. After you run your query, write an inline comment with any trends in the missing data.
*/
SELECT * from orders
where segment is null or segment=' ';

/*
1. Write a query to select at least product_name and a calculated field aliased as price_per_unit that divides sales by quantity.
2. Only select records in 'Storage' where the price per unit is more than $300.
*/
SELECT product_name, sales/quantity as price_per_unit 
from orders
WHERE subcategory='Storage' and
sales/quantity>300

/*
1. Write a query that includes at least product_name, profit, and quantity.
2. Apply a filter to select products with profits less than $0 or quantities equal to 1.
*/
SELECT product_name,profit, quantity
from orders
WHERE profit<0 OR quantity=1;



/*
invoice_id	customer_id	invoice_date	billing_country	total
*/
/*
1. Write a query that displays the table above.
	Use the clauses SELECT, FROM, and LIMIT.
*/
SELECT invoice_id, customer_id, invoice_date, billing_country,total from invoice
LIMIT 3;

/*
1. Write a query that uses the SUM aggregate function to calculate the sum of all values in the total column from the invoice table.
2. Rename the result as overall_sale.
*/













