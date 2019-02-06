/* # Homework Assignment

## Installation Instructions

* Refer to the [installation guide](Installation.md) to install the necessary files.

## Instructions - Part 1 */
use sakila;

-- 1a. Display the first and last names of all actors from the table `actor`.
select first_name, last_name from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
select concat(first_name," ",last_name) as "Actor Name" from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, first_name, last_name from actor where first_name like "Joe";

-- 2b. Find all actors whose last name contain the letters `GEN`:
select concat(first_name," ",last_name) as "Actor Name" from actor where last_name like "%gen%";
 
-- 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
select last_name, first_name from actor where last_name like "%LI%" order by last_name, first_name;


-- 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
select country_id, country from country where country in ("Afghanistan", "Bangladesh", "China");

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
alter table actor add description blob;


-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
alter table actor drop description;


-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(last_name) from actor group by last_name;


-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(*) from actor group by last_name having count(*) >1 order by count(*) desc;


-- 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
select first_name, last_name, actor_id from actor where first_name like "groucho" and last_name like "williams";
update actor set first_name = "HARPO" where actor_id = 172;

-- 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
update actor set first_name = "GROUCHO" where first_name = "Harpo";

-- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
show columns from address;
show create table address;
describe address;

  -- Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)

-- 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select * from address a 
inner join staff s
on a.address_id = s.address_id;

-- 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.


select sum(amount), s.staff_id, s.first_name, s.last_name from payment p
join staff s
on s.staff_id = p.staff_id
group by s.staff_id;


-- 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
select f.title, count(*) from film f
inner join film_actor fa
on fa.film_id = f.film_id
group by f.title;

-- 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
select f.title, count(*) from film f
inner join inventory i
on i.film_id = f.film_id
where f.title = "Hunchback Impossible"; 

-- 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
select c.last_name, c.first_name, count(p.amount) from customer c
join payment p
on p.customer_id = c.customer_id
group by c.last_name
order by c.last_name;
--  issue: need to group by last_name

select * from payment;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
select title, language_id from film
where title like "k%" or title like "q%" and language_id in (
select language_id from language
where name = "English");

-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
**** select first_name, last_name, actor_id from actor
where actor_id 
in (select film_id from film_actor
where film_id
in (select title from film
where title = "Alone Trip"));

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select c.last_name, c.first_name, c.email from customer c
join address a
on a.address_id = c.address_id
join city ci
on ci.city_id = a.city_id
join country co
on co.country_id = ci.country_id
where country like "Canada";


-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
select title from film f
join film_category fc
on fc.film_id = f.film_id
join category c
on c.category_id = fc.category_id
where c.name = "Family";

-- 7e. Display the most frequently rented movies in descending order.
select title, count(title) from film f
join inventory i
on i.film_id = f.film_id
join rental r
on r.inventory_id = i.inventory_id
group by f.title 
order by count(f.title) desc; 



-- 7f. Write a query to display how much business, in dollars, each store brought in.
select staff_id, sum(amount) from payment p
join store s
on p.staff_id = s.manager_staff_id
group by staff_id;
-- double check

select * from payment
staff_id
manager_staff_id
select * from address;
category_id

-- 7g. Write a query to display for each store its store ID, city, and country.
select store_id, ci.city, co.country from store s
join address a
on a.address_id = s.address_id
join city ci
on ci.city_id = a.city_id
join country co
on co.country_id = ci.country_id;




-- 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select name, sum(p.amount) from category ca
join film_category fc
on ca.category_id = fc.category_id
join inventory i
on i.film_id = fc.film_id
join rental r
on r.inventory_id = i.inventory_id
join payment p
on p.rental_id = r.rental_id
group by ca.name
order by sum(p.amount) desc
limit 5;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
create view top_five_genres as
select name, sum(p.amount) from category ca
join film_category fc
on ca.category_id = fc.category_id
join inventory i
on i.film_id = fc.film_id
join rental r
on r.inventory_id = i.inventory_id
join payment p
on p.rental_id = r.rental_id
group by ca.name
order by sum(p.amount) desc
limit 5;


-- 8b. How would you display the view that you created in 8a?
select * from top_five_genres;



-- 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
drop view top_five_genres_revenue;


## Appendix: List of Tables in the Sakila DB

-- A schema is also available as `sakila_schema.svg`. Open it with a browser to view.
/*
```sql
'actor'
'actor_info'
'address'
'category'
'city'
'country'
'customer'
'customer_list'
'film'
'film_actor'
'film_category'
'film_list'
'film_text'
'inventory'
'language'
'nicer_but_slower_film_list'
'payment'
'rental'
'sales_by_film_category'
'sales_by_store'
'staff'
'staff_list'
'store'
```
*/

/*
## Instructions - Part 2
Using your `gwsis` database, develop a stored procedure that will drop an individual student's enrollment from a class. 
Be sure to refer to the existing stored procedures, `enroll_student`
and `terminate_all_class_enrollment` in the `gwsis` database for reference.

The procedure should be called `terminate_student_enrollment` 
and should accept the course code, section, student ID, and effective date of the withdrawal as parameters.
*/

use gwsis;

select * from class; ID_Class, ID_Course, Section
select * from classparticipant; ID_Student, ID_Class
select * from course; ID_Course
select * from staff;
select * from staffassignment;
select * from student; ID_Student

-- drop an individual student's enrollment from a class

CREATE DEFINER=`root`@`localhost` PROCEDURE `terminate_student_enrollment`(
  ID_Course_in varchar(45),
  Section_in varchar(45),
  ID_Student_in int,
  EffectiveDate_in date
)

BEGIN

UPDATE classparticipant c
SET EndDate = EffectiveDate_in
WHERE ID_Course = 
(
	SELECT ID_Course
    FROM Course co
    INNER JOIN Class c
    ON C.id_Course = co.ID_Course
    WHERE Section = Section_in
    inner join student s
    on s.ID_Student = c.ID_Student
	WHERE ID_Student = ID_Student_in
);
END;


terminate_student_enrollment (ID_Course_in = "", Section_in = "", ID_Student_in = "", EffectiveDate_in = "02/06/19");
