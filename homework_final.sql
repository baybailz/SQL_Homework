/*************************
Author: Bailey Thompson
Due Date: 11/01/2018
Assignment: SQL Homework
Documentation: Problems are seperated by "----"(4) with problem number. Sub-problems are seperated by "--"(2) with problem number and sub-problem id.
               Operational comments needed for calculations are identified by "--"(comment)"--".
*************************/
/*************************
First step is to set up our server
Using terminal (mac):
    cd Desktop/
    cd mysql-vagrant-master/
    vagrant status 
(our server is already running, if it wasnt)
    vagrant up
*************************/
---- Declare Schema:
use sakila;
-- Problem 1:
-- 1a:
select first_name, last_name
from actor;
-- 1b: 
select concat(first_name, " ", last_name) as 'Actor Name'
from actor;
-- Problem 2:
-- 2a: 
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';
-- 2b: 
select actor_id, first_name, last_name
from actor 
where last_name like '%GEN%';
-- 2c: 
select actor_id, first_name, last_name
from actor 
where last_name like '%LI%'
order by last_name, first_name;
-- 2d: 
select country_id, country 
from country 
where country in ('Afghanistan', 'Bangladesh', 'China');
-- Problem 3:
-- 3a: 
alter table actor
add column description blob after last_update;
-- 3b:
alter table actor
drop column description;
-- Problem 4: 
-- 4a: 
select last_name, count(*) as 'last_name_count'
from actor 
group by last_name;
-- 4b: 
select last_name, count(*) as 'last_name_two'
from actor
group by last_name
having last_name_two  >  2;
-- 4c: 
set first_name = 'HARPO'
where first_name = 'GROUCHO' 
    and last_name = 'WILLIAMS';
-- 4d: 
update actor 
set first_name = 'GROUCHO' 
where first_name = 'HARPO' 
    and last_name = 'WILLIAMS';
-- Problem 5: 
-- 5a: 
describe sakila.address;
-- Problem 6: 
-- 6a: 
select s.first_name, s.last_name, a.address
from staff s left join address a 
    on (s.address_id = a.address_id);
-- 6b: 
select s.first_name, s.last_name, sum(p.amount) as 'total'
from staff s left join payment p 
	on (s.staff_id = p.staff_id)
group by s.first_name, s.last_name;
-- 6c: 
select f.title, count(a.actor_id) as 'total'
from film f left join film_actor a 
    on f.film_id = a.film_id
group by f.title;
-- 6d: 
select film_id, title from film 
where title = 'Hunchback Impossible'; 
-- Hunchback Impossible film id is 439 --
select count(film_id) from inventory 
where film_id = 439;
-- 6e: 
select c.first_name, c.last_name, sum(p.amount) as 'total'
from customer c inner join payment p 
	on (c.customer_id = p.customer_id)
group by c.first_name, c.last_name
    order by c.last_name; 
-- Problem 7: 
-- 7a: 
select title from film 
where (title like 'K%' or title like 'Q%')
	and language_id = (select language_id from language where name = 'English');
-- 7b: 
select first_name, last_name 
from actor 
where actor_id 
		in (select actor_id from film_actor 
			where film_id in (select film_id from film where title = 'ALONE TRIP')
            )
;
-- 7c: 
select first_name, last_name, email 
from customer cu 
join address a 
    on (cu.address_id = a.address_id)
join city c 
    on (a.city_id = c.city_id)
join country co 
    on (c.country_id = co.country_id)
	    where co.country_id = 20;
-- 7d: 
select title from film 
where film_id 
	in (select film_id from film_category 
    where category_id in (select category_id from category where category_id = 8)
    )
;
-- 7e: 
select title, count(f.film_id) as 'count_of_rented'
from film f 
join inventory i 
    on (f.film_id = i.film_id)
join rental r 
    on (i.inventory_id = r.inventory_id)
group by title
    order by count_of_rented desc;
-- 7f: 
select s.store_id, sum(p.amount) as 'total'
from payment p 
join staff s 
    on (p.staff_id = s.staff_id)
group by store_id;
-- 7g: 
select store_id, city, country 
from store s
join address a 
    on (s.address_id = a.address_id)
join city c 
    on (a.city_id = c.city_id) 
join country co 
    on (c.country_id = co.country_id);
-- 7h: 
select c.name as 'top_five', sum(p.amount) as 'total' 
from category c
join film_category fc 
    on (c.category_id = fc.category_id)
join inventory i 
    on (fc.film_id = i.film_id)
join rental r 
    on (i.inventory_id = r.inventory_id)
join payment p 
    on (r.rental_id = p.rental_id)
group by c.name 
    order by total desc 
        limit 5; 
-- Problem 8:
-- 8a: 
create view top_five_genres as 
select c.name as 'top_five', sum(p.amount) as 'total' 
from category c
join film_category fc 
    on (c.category_id = fc.category_id)
join inventory i 
    on (fc.film_id = i.film_id)
join rental r 
    on (i.inventory_id = r.inventory_id)
join payment p 
    on (r.rental_id = p.rental_id)
group by c.name 
    order by total desc 
        limit 5; 
-- 8b: 
select * from top_five_genres;
-- 8c: 
drop view top_five_genres;




