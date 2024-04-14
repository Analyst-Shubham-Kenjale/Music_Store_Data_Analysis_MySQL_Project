-- SQL PROJECT- MUSIC STORE DATA ANALYSIS....

CREATE DATABASE project;
use project;

select * from album;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from media_type;
select * from playlist;
select * from playlist_track;
select * from track;


# Q1). Write a query to display employee_id, full name of employee, title, city and country and show only 5 rows from the top..

select employee_id, concat(first_name, ' ', last_name) as full_name, title, city, country
 from employee limit 5;

# Q2). Write a query to count the customers in the country of Brazil?

Select count(*) as Customers_Count from customer
where country = 'Brazil';

# Q3). Who is the senior most employee based on job title?

select employee_id, first_name, last_name, title, levels from employee
order by levels desc limit 1 ;

# Q4). Which city has the most Invoices?

select billing_city, count(*) as Invoice_Count from invoice
group by 1
order by Invoice_Count desc
limit 1;

# Q5). Write a query to fetch the details of the tracks whose unit price should  be equal to $0.99 and also the genre ID should  be equal to 17.

select * from track where unit_price = 0.99 and genre_id =17;

# Q6). Write a query to fetch the invoices whose billing city is Berlin or Paris and the invoice year should be 2017 or 2020.

select * from invoice where billing_city in ('Berlin', 'Paris') and year(invoice_date) in (2020, 2017);

# Q7). Write a query to fetch the details of the tracks whose name starts with 'd' and whose price is 1.99

select * from track where name like 'd%' and unit_price = 1.99;

# Q8). Write a query to count the number of customers in the countries of India, USA and Germany and also Customer_id of customers from this countries.

select * from customer;
select country , count(*) as Count, group_concat(customer_id) as Customer_id from customer 
where country in ('India', 'USA', 'Germany')
group by country;

# Q9). Which are the Top 3 cities has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns Top 3 cities that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

select billing_city, round(sum(total), 2) as total_invoices from invoice
group by billing_city
order by total_invoices desc
limit 3;

# Q10). Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the customer_id, full_name and invoice of customer who has spent the most money

select c.customer_id, concat(c.first_name, ' ', last_name) as full_name, round(sum(total), 2) as Total_invoice 
from customer as c join invoice as i
on c.customer_id = i.customer_id
group by c.customer_id, full_name 
order by Total_invoice desc
limit 1;


# Q11). Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A

select distinct(c.email), c.first_name, c.last_name 
from customer as c 
join invoice as i on c.customer_id = i.customer_id
join invoice_line as il on i.invoice_id = il.invoice_id
join track as t on il.track_id = t.track_id
join genre as g on t.genre_id = g.genre_id
where g.name = 'Rock'
order by email;
 
# Q12). Return Top 5  track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

select name, milliseconds from track 
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc
limit 5 ;


 