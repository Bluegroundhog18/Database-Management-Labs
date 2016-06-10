--Bryan Chester
--June 10, 2016
--Database Management
--Pablo Rivas, CMPT 308
--Lab 5: SQL Queries Using Joins

--1. Show the cities of agents booking an order for a customer whose id is 'c002'. Use joins; no subqueries.

select a.city
from agents a
  natural full outer join orders o
where o.cid = 'c002';

--2.Show the ids of products ordered through any agent who makes at least one order for a customer in Dallas, sorted by pid from highest to lowest. Use joins; no subqueries.

--I literally spent over 3 hours attempting to do this query with only joins and no subquerries, but I'm convinced it's not possible, unless I'm missing something.

select distinct o.pid
from orders o
where o.aid in( select o.aid
		from orders o
		  inner join customers c on o.cid = c.cid
		where c.city = 'Dallas')
order by pid desc;

--3. Show the names of customers who havbe never placed an order. Use a subquery.

select c.name
from customers c
where cid not in( select cid
		  from orders);

--4. Show the names of customers who have never placed an order. Use an outer join.

select c.name
from customers c
  natural full outer join orders o
where ordno is null;

--5. Show the names of customers who placed at least one order through an agent in their own city, along with those agent(s') names.

select distinct c.name, a.name
from customers c
  inner join orders o on c.cid = o.cid
  inner join agents a on o.aid = a.aid
where c.city = a.city;

--6. Show the names of customers and agents living in the same city, along with the name of the shared city, regardless of whether or not the customer has ever placed an order with that agent.

select c.name, a.name, c.city
from customers c, agents a
where c.city = a.city;

--7. Show the name and city of customers who live in the city that makes the fewest different kinds of products. (Hint: Use count and group by on the Products table.)

select c.name, c.city
from customers c
where c.city in( select city
		 from products
		 group by city
		 order by count(pid) asc
		 limit 1);