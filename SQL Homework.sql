USE sakila;
-- 1a. Display the first and last names of all actors from the table `actor`. 
SELECT first_name,last_name FROM  actor; 

--  1b Display the first and last name of each actor in a single column in upper case letters. 

SELECT UPPER (concat (first_name, ' ', last_name) ) AS 'Actor Name' FROM actor;
-- 2a Find first name, "Joe."
SELECT actor_id,first_name,last_name FROM  actor WHERE first_name LIKE 'Joe%'; 

-- 2b Find last name with 'GEN'
SELECT first_name,last_name FROM  actor WHERE last_name LIKE '%GEN%'; 

-- 2c last names contain the letters `LI` order by last name
SELECT last_name, first_name FROM  actor WHERE last_name LIKE '%LI%' ORDER BY last_name; 

-- 2d Using `IN`, display following countries: Afghanistan, Bangladesh, and China:
SELECT country_id,country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

  
-- 3a Add a `middle_name` column to the table
ALTER TABLE actor
  ADD middle_name VARCHAR(50) AFTER first_name;

-- 3b Change the data type of the `middle_name` column to `blobs`.
ALTER TABLE actor
MODIFY middle_name  BLOB ;

-- 3c Delet middle_name column
ALTER TABLE actor
 DROP middle_name;
 
 -- 4a count last names and list them
SELECT last_name, COUNT(last_name) AS 'Number of Actors'
  FROM actor GROUP BY last_name;
  
 -- 4b names that are shared by at least two actors
SELECT last_name, COUNT(last_name) AS 'Number of Actors'
  FROM actor GROUP BY last_name 
  HAVING COUNT(*)>1;
  
-- 4c Write a query to fix the actor nameHARPO

SELECT * from actor WHERE last_name='WILLIAMS ' AND first_name ='GROUCHO';
UPDATE  actor SET first_name='HARPO' WHERE first_name ='GROUCHO' AND last_name='WILLIAMS' ;

-- 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`

UPDATE actor set first_name='GROUCHO' WHERE first_name='HARPO' AND actor_id=172;

-- 5a SCHEMA ADDRESS
SHOW CREATE TABLE address;
select * from address;

-- 6a JOIN TABLES Use the tables `staff` and `address`:

SELECT staff.first_name, staff.last_name,address.address
FROM staff
JOIN address 
ON staff.address_id = address.address_id;
  

-- 6b. List each film and the number of actors in August of 2005
SELECT staff.first_name, staff.last_name,payment.amount
 FROM payment
 JOIN staff 
 USING (staff_id)
 WHERE payment_date LIKE '2005-08%';

 -- 6c. List each film and the number of actors who are listed for that film. 
SELECT * FROM film;
SELECT * from film_actor;
SELECT film.title, COUNT(*) AS 'Number of Actors' 
  FROM film
  JOIN film_actor
  USING (film_id)
  GROUP BY title;
  
-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT * FROM film;
SELECT * from inventory;
SELECT film.title, COUNT(*) AS 'Number of copies'
  FROM film
  JOIN inventory
  USING (film_id)
  WHERE film.title="Hunchback Impossible";
  
  -- 6e. Using the tables `payment` and `customer` and the `JOIN` command, 
  -- list the total paid by each customer.  List the customers alphabetically by last name:
  SELECT * FROM payment;
  SELECT * FROM customer;
  SELECT customer.last_name, customer.first_name, sum(payment.amount) as Revenue
  FROM PAYMENT
  JOIN customer
  USING (customer_id)
  GROUP BY customer_id
  ORDER BY last_name;
  
  
    -- 7a Use subqueries to display the titles with letters K and Q whose language is English.
  SELECT title
  FROM film
  WHERE (title LIKE 'K%') OR (title LIKE 'Q%')
    IN (SELECT language_id FROM film WHERE language_id IN 
     (SELECT language_id FROM language WHERE name='English')
	);
  
  --  7b. Use subqueries to display all actors who appear in the film Alone Trip.
  SELECT first_name, last_name
  FROM actor
  JOIN film_actor
  USING (actor_id)
  WHERE film_actor.film_id 
  IN (SELECT film_id FROM film WHERE film.title="Alone Trip");
  
  -- 7c names and email addresses of all Canadian customers. Use joins to retrieve this information.
  SELECT first_name, last_name,email
  FROM customer
  JOIN address
  USING (address_id)
  WHERE city_id = ANY (SELECT city_id FROM city WHERE country_id = 20);
  
  -- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
  -- Identify all movies categorized as famiy films.
  SELECT title
  FROM film
  JOIN film_category
  USING(film_id)
  WHERE film_id IN (SELECT film_id FROM category WHERE category_id = 8);
  
  -- 7e. Display the most frequently rented movies in descending order.
  
  