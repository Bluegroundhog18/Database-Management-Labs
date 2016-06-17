--Bryan Chester
--June 17 2016
--Database Management
--Pablo Rivas, CMPT 308
--Lab 6: Very Interesting SQL Queries

--1. Display the name and city of customers who live in any city that makes the most different
--kinds of products. (There are two cities that make the most products. Return the name and
--city of custoers from either one of those.)

select c.name, c.city
from customers c
where city in (select city
	       from products
	         group by city
	         order by count(pid) desc
	       limit 1);

--2. Display the names of products whose priceUSD is strictly above the average priceUSD, in
--reverse alphabetical order.

select name
from products
  group by name, priceUSD
  having (select avg(priceUSD)
	  from products) < priceUSD;

--3. Display the customer name, pid ordered, and the total for all orders, sorted by total from
--high to low.

select c.name, o.pid, sum(o.dollars) as dollarsum
from orders o
  inner join customers c on c.cid = o.cid
  group by c.name, o.pid
  order by dollarsum desc;

--4. Display all customer names (in alphabetical order) and their total ordered, and nothing more.
--Use coalesce to avoid showing NULLs.

select c.name, coalesce(sum(o.dollars), 0.00)
from orders o
  full outer join customers c on c.cid = o.cid
  group by c.name
  order by c.name asc;

--5. Display the name sof all customers who bought products form agents based in Tokyo along with
--the names of the products they ordered, and the names of the agents who sold it to them.

select c.name, p.name, a.aid, a.name
from customers c
  inner join orders o on c.cid = o.cid
  inner join agents a on a.aid = o.aid
  inner join products p on p.pid = o.pid
where o.cid in (select o.cid
		from orders
		  inner join customers on o.cid = c.cid
		where o.aid = (select aid
			       from agents
			       where city = 'Tokyo'));

--6. Write a query to check the accuracy of the dollars column in the Orders table. This means 
--calculating Orders.totalUSD from data in other tables and comparing those values to the values in
--Orders,totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any.

select o.*, o.qty*p.priceUSD*(1-(discount/100)) as truetotal
from orders o
  inner join products p on o.pid = p.pid
  inner join customers c on o.cid = c.cid
where dollars not in (select o.qty*p.priceUSD*(1-(discount/100)) as truetotal
			from orders o
			  inner join products p on o.pid = p.pid
			  inner join customers c on o.cid = c.cid);

--7. What is the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries
--in SQL to demonstrate. (Feel free to use the CAP2 database to make your points here.)

--In a Left Outer Join, two tables within a database are compared, with the "left" database
--being the one used for the basis of comparison, and the "right" database being compared
--to it. All fields in the "left" table are included in the displayed results, but only 
--those fields in the "right" table that overlap with those in the left will be displayed.
--Any fields in the "right" table not found in the "left" will be marked as null. The exact
--opposite of these rules apply to a Right Outer Join, with the "right" table being used
--as the basis for comparison and the "left" table being compared to it. As an example
--of a Left Outer Join, if the Customers and Agents tables from the CAP2 database are
--compared to each other, with Customers being the "left" table and Agents being the
--"right", then all the fields within Customers (under the cid, name, city, and discount columns) will be included.
--All others will be excluded from the results. All the Customers columns that are not applicable to any
--Agents results (cid, name, and discount) will be marked as null for all Agents. Essentially, only items
--from Agents that match up with items in Customers in some way will be included in the table
--of results.

select *
from customers
  left outer join agents on customers.city = agents.city;