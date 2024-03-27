select * from actor;

select * from payment ORDER BY payment_id DESC;
select * from payment ORDER BY payment_id ASC;

--Challange -- ORDER BY
-- List Down customers last_name in assending order [Z - A] ,
-- also for same last_name , list first_name in descending order [Z - A]

select first_name,last_name,email from customer ORDER BY last_name,first_name DESC;
-- OR
select first_name,last_name,email from customer ORDER BY last_name DESC,first_name DESC;

-- In case we want last_name in DESC and first_name in ASC then
select first_name,last_name,email from customer ORDER BY last_name DESC,first_name ASC;



-- DISTINCT
select distinct first_name from actor;
select distinct first_name,last_name from actor;
select distinct first_name,last_name from actor where first_name ='ADAM';
select distinct first_name from actor where first_name ='ADAM';

select distinct rating,rental_duration from film;

-- challange on distinct -- 
-- A marketing team member askes you about the different price that have been paid. 
-- TO make it easier for them order the prices from high to low
-- Write SQL query to get different prices

select distinct amount from payment ORDER BY amount DESC;



-- limiting the output till first few row
select distinct amount from payment ORDER BY amount DESC LIMIT 4; -- show only last 4 rows
select distinct amount from payment ORDER BY amount ASC LIMIT 4; -- show only first 4 rows


-- find out latest 10 rentals 
select rental_id,rental_date,customer_id from rental ORDER BY rental_date DESC LIMIT 10;



-- count 
select count(rental_id) as rentalIDperDate,rental_date from rental GROUP BY rental_date ORDER BY rentalIDperDate DESC;

select * from payment;
select payment_date,payment_id,count(amount) from payment GROUP BY payment_date,payment_id;

select * from customer;
select count(DISTINCT first_name) from customer;
select count(first_name) as firstNameCountPerID,customer_id from customer GROUP BY customer_id ORDER BY customer_id ASC LIMIT 100;

-- challange on COUNT--
-- Create a list of distinct districts customers are from
select DISTINCT district from address;
-- What is latest rental date?
select rental_date from rental ORDER BY rental_date DESC LIMIT 1;
-- How many films does the company have ?
select count(DISTINCT film_id) from film;
--OR
select count(*) from film;
-- How many discinct last_names of customer have?
select count(DISTINCT last_name) from customer;


-- Day 2  - Filtering

-- list of all amount which are 0
select payment_id,amount from payment where amount=0;
select count(amount) from payment where amount=0;

-- where clause clallange

-- How many payment were made by the customer with custoemr_id =100
select customer_id,payment_id,amount from payment where customer_id =100;
select count(payment_id) from payment where customer_id=100;
-- What iss the last name of our customer with first name 'ERICA'?
select first_name,last_name from customer where first_name='ERICA';
select count(last_name) from customer where first_name ='ERICA';

-- How many payment were made by the customer which are > 10 $
select payment_id,amount from payment where amount>10 ORDER BY amount ASC;

-- other operation with operator
select * from payment where amount <10;
select * from payment where amount <>10;
--OR
select * from payment where amount !=10;
select * from payment where amount >=10;
select * from payment where amount <=10;
select * from payment where amount >10;
select * from payment where amount=10.99;


-- challange on Where and operator

-- How many rentals have not been returned yet
select * from rental where return_date is null;
select count(rental_date) as NotReturnedRentalYet from rental where return_date is null;

-- list of all payment ids with an amount less than or equal to 2$. Include payment id and the amount.
select payment_id,amount from payment where amount <= 2;


-- multiple condition AND OR

select * from payment where (amount = 10.99 OR amount = 09.99) AND customer_id=426 ORDER BY amount ASC;
select * from payment where amount = 10.99 OR amount = 09.99 AND customer_id=426 ORDER BY amount ASC;
-- NOTE : AND will be executed first if no parenthesis is defined , else parenthesis will be priority

ALTER DATABASE greencycles SET timezone TO 'Europe/Berlin';  

-- More complex AND OR--
select * from payment;
select payment_id,customer_id,amount from payment where customer_id in(322,346,354) AND (amount <2 OR amount >10) ORDER BY customer_id ASC,amount DESC;
select * from payment where customer_id in(322,346,354) AND (amount <2 OR amount >10) ORDER BY customer_id ASC,amount DESC;

 
-- BETWEEN keyword --

select * from payment where payment_id BETWEEN 17000 AND 17007;

select * from payment where payment_id NOT BETWEEN 16052 AND 16055;

select * from payment where payment_date BETWEEN  '2020-01-25 03:10:19.996577+05:30' AND '2020-01-30 06:43:42.996577+05:30';
select * from payment where payment_Date = '2020-01-30 06:43:42.996577+05:30';

-- more complex BETWEEN

-- There have been some faulty payments and you need to help to found out how many payment have been afftected.
-- How many payments have been made on january 26th and 27th 2020 with an amount between 1.99 and 3.99
select * from payment where (amount BETWEEN 1.99 AND 3.99) AND (payment_date BETWEEN '2020-01-26' AND '2020-01-28') ORDER BY payment_date ASC;
select count(*) from payment where (amount BETWEEN 1.99 AND 3.99) AND (payment_date BETWEEN '2020-01-26' AND '2020-01-28');



-- IN
select * from customer;
select * from customer where first_name IN(select first_name from customer where first_name LIKE 'B%' AND customer_id BETWEEN 50 AND 100);


select DISTINCT customer_id from payment where customer_id IN('12','25','67','93','124','234') AND amount IN('4.99','7.99','9.99') ORDER BY customer_id ASC;

select * from payment where customer_id IN(12,25,67,93,124,234) AND amount IN(4.99,7.99,9.99) 
AND payment_date BETWEEN '2020-01-01' AND '2020-02-01';


-- LIKE -- 2 wildcards _ and % | Like is case sensetive || ILIKE is case insensitive || NOT LIKE || NOT ILIKE
select * from film;
select * from film where description LIKE '%Drama%';
select * from film where description ILIKE '%drama%'; -- CASE sensitive
select * from film where description NOT LIKE '%Drama%';
select * from film where description NOT ILIKE '%drama%';
select * from film where description ILIKE '%india'; -- IGNORE CASE

select * from customer where first_name LIKE '_AT%';
select * from customer where first_name LIKE '_A__H';
select * from customer where first_name ILIKE '_A%IA';


-- How many movies are there that contain the "Documentory" in the dexcription
select count(*) from film where description ILIKE '%Documentary%';

/*
How many customers are in the database with a first_name that is 3 letters long and
either an 'X' OR a 'Y' as the last letter in the last_name
*/
 
select first_name,last_name from customer where first_name LIKE '___' AND (last_name LIKE '%X' OR last_name LIKE '%Y');
-- now applying count on above query
select count(*) AS customerFirstNameCount from customer where first_name LIKE '___' AND (last_name LIKE '%X' OR last_name LIKE '%Y');


-- challange 

/*
1. How many movies are there that contain 'Saga' in the description and 
where the title starts either with 'A' or ends with 'R'?
Use the alias 'no_of_movies'.
*/
select count(*) AS no_of_movies from film where description LIKE '%Saga%' AND (title LIKE 'A%' OR title LIKE '%R');


-- 2. Create a list of all customers where the first name contains ER and has an A as the second letter.
--Order the results by the last name descendingly.
select * from customer where first_name LIKE '_A%ER%' ORDER BY last_name DESC;
-- OR
select * from customer where first_name LIKE '%ER%' AND first_name LIKE '_A%' ORDER BY last_name DESC;


/*
3. How many payments are there where the amount is either 0 or is between 3.99 and 7.99 and in the same time has
happened on 2020-05-01.
*/	
select count(*) from payment where (amount = 0 OR (amount BETWEEN 3.99 AND 7.99)) AND payment_date BETWEEN '2020-05-01' AND '2020-05-01 23:59:59';




--/////////////////// GOUP BY =========================

select * from payment;
select sum(amount) AS totalSum from payment;
select count(amount) AS countOfPayment from payment;
select AVG(amount) from payment;
select MAX(amount) from payment;
select MIN(amount) from payment where amount != 0.00;

select
ROUND(sum(amount)) AS sumOfamount
,ROUND(AVG(amount)) AS avgOfAmount
,ROUND(count(*)) as countOfAmount
,ROUND(MAX(amount)) AS maxAmount
,ROUND(min(amount)) AS minAmount
from payment;


/*
Aggregate functions
Your challenge is to write a single SQL query to find the total number of orders and the average order amount from the Orders table. The solution should include only orders made in August 2023.

Use the aliases TotalOrders and AverageOrderAmount in your query.
Column names:
OrderID , 
Amount ,
OrderDate


select 
count(OrderID) AS TotalOrders
,AVG(Amount) AS AverageOrderAmount
from Orders
where
OrderDate BETWEEN '2023-08-01' AND '2023-08-31 23:59:59';
*/


-- CHALLANGE on Agreegate function
/*

Your manager wants to get a better understanding of the films.
That's why you are asked to write a query to see the
Minimum
Maximum
Average (rounded)
Sum
of the replacement cost of the films.
Write a SQL query to get the answers!
*/

SELECT
MIN(replacement_cost) AS MinReplacementCost
,MAX(replacement_cost) AS MaxReplacementCost
,ROUND(AVG(replacement_cost),2) AS AVGReplacementCost -- ROUNDED to 2 decimal places
,SUM(replacement_cost) AS SumOfReplacementCost
FROM
film;


-- GROUP BY ------------

SELECT
customer_id AS C_ID
,ROUND(sum(amount),2) AS SUM_Amount
FROM
payment
GROUP BY
C_ID
HAVING
customer_id=4
ORDER BY
C_ID ASC;



SELECT
customer_id AS C_ID
,ROUND(sum(amount),2) AS SUM_Amount
FROM
payment
WHERE customer_id>3
--OR
AND
customer_id BETWEEN 4 AND 100
GROUP BY
C_ID
--HAVING
--customer_id=4
ORDER BY
C_ID ASC;

select * from payment;


SELECT
customer_id
,ROUND(AVG(amount),3) AS AVG_AMOUNT
,ROUND(SUM(amount),3) AS SUM_AMOUNT
FROM
payment
GROUP BY customer_id
ORDER BY
customer_id ASC
LIMIT 50;



SELECT
ROUND(SUM(amount),2) AS SUM_Amount
,MAX(amount) AS MAX_amount
,payment_id
FROM payment
GROUP BY payment_id
HAVING payment_id BETWEEN 22344 AND 22360
ORDER BY SUM_Amount ASC;


-- Udemy challange
/*
SELECT
category
,SUM(quantity) AS total_quantity
,SUM(sale_amount) AS total_sales_amount
FROM sales_data
GROUP BY category
ORDER BY total_sales_amount DESC;
*/

/*
1> Your manager wants to which of the two employees (staff_id) is responsible for more payments?
2> Which of the two is responsible for a higher overall payment amount?
3> How do these amounts change if we don't consider amounts equal to 0?
Write two SQL queries to get the answers!
*/

SELECT
staff_id
,SUM(amount) AS sum_amount
FROM payment
GROUP BY staff_id
ORDER BY sum_amount ASC LIMIT 2;


SELECT
staff_id
,SUM(amount) AS sum_amount
,COUNT(amount) AS Number_of_payments
FROM payment
WHERE amount <> 0
GROUP BY staff_id
ORDER BY Number_of_payments ASC LIMIT 2;


-- GROUP BY multiple column

select * from payment;

-- Which staff have highest amount of payment with one specific customer

SELECT customer_id,staff_id
,MAX(amount) AS max_amount_each_customer
,AVG(amount) AS avg_amount_each_customer
,SUM(amount) AS total_amount_each_customer
,COUNT(*) AS no_of_payment_per_customer_by_staff
FROM payment
GROUP BY customer_id,staff_id
ORDER BY COUNT(*) DESC;


--- multiple CGOUPING challange 

/*

GROUP BY multiple columns
Create a query showing the total sales amount (AS total_sales_amount) and total number of items sold  (AS total_items_sold), grouped by category and sale_date. Order the results by category in ascending order and then by sale_date in ascending order.

Use the sales table with columns: category, sale_date, amount.

Note: You can assume one row in the table represents one item sold.


SELECT
category,sale_date
,COUNT(amount) AS total_items_sold
,SUM(amount) AS total_sales_amount
FROM
sales 
GROUP BY category, sale_date
ORDER BY category ASC, sale_date ASC;
*/

 -- Multiple Grouping challange --
 
 -- fetching DATA from date time data
 
 SELECT * FROM payment;
 
 SELECT *,
 DATE(payment_date) AS DATE
 FROM payment;
 
 SELECT DATE(payment_date)
 FROM payment;
 
-- Now challange 

/*
There are 2 compitition between 2 employees

1. Which employee had the highest sale amount in single day ?

2. Which employee had the most sales in a single day(not counting payments with amount =0)? 

*/

SELECT * from payment;

SELECT staff_id
,DATE(payment_date) AS payment_date
,SUM(amount) AS Total_amount
FROM
payment
GROUP BY staff_id, payment_date
ORDER BY Total_amount DESC;


SELECT staff_id
,DATE(payment_date) AS payment_date
,SUM(amount) AS total_amount
,COUNT(*)
FROM
payment
GROUP BY staff_id, payment_date
--ORDER BY payment_date;
ORDER BY Total_amount DESC;

/*
HAVING challange udemy
Find the cities with more than two transactions where the average transaction amount exceeds $150.00. List the city and the average transaction amount (AS AverageAmount), sorted by the average transaction amount in descending order.

Necessary Information

Table name: Sales

Columns to consider: City, Amount, TransactionID

==================

SELECT City,
       AVG(Amount) AS AverageAmount
FROM Sales
GROUP BY City
HAVING COUNT(TransactionID) > 2 AND AVG(Amount) > 150.00
ORDER BY AverageAmount DESC;


SELECT City,COUNT(TransactionID),
       AVG(Amount) AS AverageAmount
FROM Sales
GROUP BY City
HAVING AVG(Amount) > 150.00
ORDER BY AverageAmount DESC;

*/

-- HAVING challange






-- =========== SQL JOINS ================
/*
create table sales
(
	employee varchar(200),
	city varchar(200),
	sales int
);



INSERT INTO sales (employee, city, sales)
VALUES
    ('Sandra', 'Frankfurt', 500),
    ('Sabine', 'Munich', 300),
    ('Peter', 'Hamburg', 200),
    ('Manuel', 'Hamburg', 400),
    ('Michael', 'Munich', 100),
    ('Frank', 'Frankfurt', 100);
*/
/*
create table bonus
(
	employee varchar (200),
	bonus int
);
*/

ALTER TABLE bonus ADD COLUMN FLAG VARCHAR(200); -- Change 255 to the desired length of the VARCHAR

ALTER TABLE bonus
ALTER COLUMN bonus TYPE VARCHAR(255);

ALTER TABLE bonus DROP COLUMN flag;


/*
INSERT INTO bonus
(employee, bonus)
VALUES
('Sandra','YES'),
('Sabine','YES'),
('Peter','NO'),
('Manuel','YES'),
('Simon','NO');
*/



select * from bonus;


select * from sales;


SELECT sales.employee
FROM sales
INNER JOIN bonus
ON sales.employee=bonus.employee;


SELECT bonus.employee
FROM sales
INNER JOIN bonus
ON sales.employee=bonus.employee;


-- INNER JOIN Customer and payment table ON customer_id
SELECT customer.customer_id,customer.first_name,
customer.last_name,payment.customer_id AS payment_customer_id,payment.amount
FROM customer
INNER JOIN payment
ON
customer.customer_id=payment.customer_id
ORDER BY customer.customer_id ASC;


SELECT * 
FROM payment
INNER JOIN customer
ON
payment.customer_id=payment.customer_id;


SELECT payment.* -- select all the column from payment table
,customer.first_name,customer.last_name
FROM payment
INNER JOIN
customer
ON
payment.customer_id=payment.customer_id
ORDER BY customer.customer_id ASC
LIMIT 1000;


SELECT COUNT(payment.rental_id) AS payment_rental_id_Count,
	payment.staff_id,
	customer.first_name
FROM payment
INNER JOIN customer ON payment.customer_id=customer.customer_id
	WHERE 
	customer.first_name LIKE 'A%' 
	OR customer.first_name LIKE '%B%'
	AND payment.staff_id BETWEEN 1 AND 3
GROUP BY payment.staff_id,customer.first_name
	HAVING payment.staff_id IN(1,2)
ORDER BY payment_rental_id_Count ASC
LIMIT 100;


SELECT *
FROM payment LIMIT 10;



-- ================ SQL FUNCTIONS ===============

SELECT 
UPPER(email) AS email_upper,
LOWER(email) AS email_lower,
LENGTH(email) AS email_length
FROM customer
WHERE LENGTH(email) BETWEEN 1 AND 29;


-- LIST first_name and last_name where first or last name is more than 10 character long. 
-- Display these customer lists in lower case
SELECT
LOWER(first_name),
LOWER(last_name),
LOWER(email),
LENGTH(first_name) AS l_firstName,
LENGTH(last_name) AS l_lastName
FROM
customer
WHERE LENGTH(first_name) >10 
OR LENGTH(last_name) >10;


-- LEFT function AND RIGHT function -- extract left or rigt chatacters from selected col
SELECT
LEFT(first_name,2) AS left_firstName,
first_name,
RIGHT(first_name,1)
FROM customer;


-- USING LEFT or RIGHT fuction extract 3rd letter from first_name
SELECT
first_name,
LEFT(first_name,3) AS left_3chra,
RIGHT(LEFT(first_name,3),1) AS third_char,
first_name
FROM customer;





-- ============= SQL UNION ==============

select * from payment;

select * from sales;

select sales from sales
UNION -- discards duplicate value
select amount from payment;


select sales from sales
UNION ALL -- keep duplicate values
select amount from payment;


SELECT first_name ,'actor' AS ORIGIN FROM actor
UNION ALL
SELECT first_name , 'customer' FROM customer
UNION
SELECT UPPER(first_name), 'staff' FROM staff  
ORDER BY ORIGIN ASC;


select 'actor' AS table_name, count(*) from actor
UNION ALL
select 'payment' AS table_name, count(*) from payment
UNION ALL
select 'sales' AS table_name, count(*) from sales
UNION ALL
select 'staff' AS table_name, count(*) from staff
UNION ALL
select 'store' AS table_name, count(*) from store;





