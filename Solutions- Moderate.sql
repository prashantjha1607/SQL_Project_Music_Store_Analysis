Q1. --Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by email starting with A

select email, first_name, last_name, g.name from customer c
INNER JOIN invoice ON c.customer_id = invoice.customer_id
INNER JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
INNER  JOIN track ON invoice_line.track_id = track.track_id
INNER JOIN genre g ON track.genre_id = g.genre_id
WHERE  g.name = 'Rock' AND c.email LIKE 'a%' 
ORDER BY c.email


Q2.--Let's invite the artists who have written the most rock music in our dataset.
--Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT a.name, a.artist_id, COUNT(track_id) AS total_track from artist a
INNER JOIN album ON a.artist_id = album.artist_id
INNER JOIN track ON album.album_id = track.album_id
INNER JOIN genre g ON track.genre_id = g.genre_id
WHERE g.name LIKE 'Rock%'
GROUP BY a.artist_id
ORDER BY  COUNT(track_id)  DESC
LIMIT 10 ;


Q3.--Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. 
--Order by the song length with the longest songs listed first


SELECT name, milliseconds from track
WHERE milliseconds >
(SELECT AVG(milliseconds)from track)
ORDER BY milliseconds DESC









