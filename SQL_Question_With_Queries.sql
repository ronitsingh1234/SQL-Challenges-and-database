  -- Easy Question 

-- Q1 - who is the senior mosr employee based on job title?

select * from employee
order by levels desc LIMIT 1;

-- Q2-which country have the most invoices?

select billing_country ,count(*) as invoices
from invoice 
group by billing_country 
order by invoices desc 
limit 1;

-- Q3-What are the top 3 values of total invoices?

select total from invoice
order by total desc
limit 3;


-- Q4-Which city have best customers we would like to throw party 
of a promotional music festival in the city  we make the most money 
write the query that returns one city that has the highest sum of invoices total
return both the city name and sum of all invoices===

select  sum(total) as invoice_total , billing_city
from invoice 
group by billing_city
order by invoice_total desc;

-- Q5-Who is the best customer? the customer who has spent the most money will be declared
the best customer. Write a query that returns the person who has spent the most money

select t1.customer_id,t1.first_name,t1.last_name, sum(t2.total) as total
from customer as t1
join invoice as t2
on t1.customer_id = t2.customer_id
group by t1.customer_id
order by total desc
limit 1






-- Moderate Question 

-- Q1-Write Query to reutrn the email,first_name,last_name, and genre of all rock music listners.
-- return tour list ordered alphabetically by email starting with A

select Distinct email , first_name,last_name
from customer 
join invoice
on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id  IN(
    select track_id from track
	join genre on track.genre_id = genre.genre_id
	where genre.name like 'Rock')
order by email;


-- Q2- Lets's invite the artist who have written the most rock music in our data set.
-- write a query that return the artistname the total track count of the top 
-- 10 rock bands.        

SELECT artist.artist_id, artist.name, COUNT(track.track_id) as number_of_songs
FROM artist
JOIN album ON artist.artist_id = album.artist_id
JOIN track ON album.album_id = track.album_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;


-- Q3-Return all the track names that have a song length longer than the average song length 
-- return the name and millisecond for each track. order by the song length with the longest 
-- longest songs listed first.



select name , milliseconds
from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc; 
