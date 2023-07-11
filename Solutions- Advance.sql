--Q1: Find how much amount spent by each customer on artists? 
-- Write a query to return customer name, artist name and total spent

WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, 
	SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, 
SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;

--Q2: We want to find out the most popular music Genre for each country. We determine the most popular 
--genre as the genre with the highest amount of purchases. Write a query that returns each country along 
--with the top Genre. For countries where the maximum number of purchases is shared return all Genres.

WITH popular_genre AS 
(
SELECT COUNT(il.quantity) AS purchases, c.country, genre.name, genre.genre_id,
	ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY  COUNT(il.quantity) DESC ) AS row_num
	FROM invoice_line il
	JOIN invoice ON il.invoice_id = invoice.invoice_id
	JOIN customer c ON invoice.customer_id = c.customer_id
	JOIN track ON il.track_id = track.track_id
	JOIN genre ON track.genre_id = genre.genre_id
	GROUP BY 2, 3, 4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * from popular_genre WHERE row_num = 1



--Write a query that determines the customer that has spent the most on music for each country. 
--Write a query that returns the country along with the top customer and how much they spent. 
--For countries where the top amount spent is shared, provide all customers who spent this amount.

WITH customer_with_country AS
(
  SELECT c.customer_id,  c.first_name, c.last_name , ROUND (SUM(total)) AS Total , billing_country,
	ROW_NUMBER() OVER(PARTITION BY billing_country  ORDER BY SUM(total) DESC ) AS row_num
	FROM customer c
	JOIN invoice ON c.customer_id =  invoice.customer_id
	GROUP BY 1,2,5
	ORDER BY 5 ASC , 4 DESC
)
SELECT * FROM customer_with_country WHERE row_num <= 1




























