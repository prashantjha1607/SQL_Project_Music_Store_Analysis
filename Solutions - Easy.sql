Q1. --Who is the senior most employee based on job title?-

SELECT first_name, last_name from employee 
ORDER BY levels desc
limit 1

--Which countries have the most Invoices ?

SELECT billing_country, total as total_invoice FROM invoice 
group by billing_country, total
order by total_invoice desc

--What are top 3 values of total invoice?

SELECT total as total_invoice FROM invoice
order by total_invoice desc
limit 3


Q2.--Which city has the best customers? We would like to throw a promotional Music Festival 
--in the city we made the most money. Write a query that returns one city that has the 
--highest sum of invoice totals. Return both the city name & sum of all invoice totals

select c.city as Best_city, sum(a.total) from customer c
JOIN invoice a 
ON c.customer_id = a.customer_id
GROUP BY c.city
ORDER BY sum(a.total) desc
limit 1


Q3.--Who is the best customer? The customer who has spent the most money will be declared 
--the best customer. Write a query that returns the person who has spent the most money

select c.customer_id, first_name, last_name, sum(total) as best_pay from customer c
JOIN invoice a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id 
order by best_pay  desc
limit 1;

