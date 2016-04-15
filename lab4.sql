
--1. Get the cities of agents booking an order for a customer whose cid is 'c002'.
select city
from agents
where aid in( select aid
              from orders
              where cid = 'c002');

--2. Get the ids of products ordered through any agent who takes at least one order from a customer in Dallas, sorted by pid from highest to lowest. (This is not the same as asking for ids of products ordered by customers in Dallas).
select pid
from orders
where aid in( select aid
              from orders
              where cid in( select cid
                            from customers
                            where city = 'Dallas'))
order by pid DESC;

--3. Get the ids and names of customers who did not place an order through agent a01.
select cid, name
from customers
where cid not in( select cid
                  from orders
                  where aid = 'a01');

--4. Get the ids of customers who ordered both product p01 and p07.
select distinct cid
from orders
where cid in( select cid
              from orders
              where pid = 'p01'
                intersect
              select cid
              from orders
              where pid = 'p01');

--5. Get the ids of products not ordered by any customers who placed any order through agent a07 in pid order from highest to lowest.
select pid
from orders
where cid not in( select cid
                  from orders
                  where aid = '07')
order by pid DESC;

--6. Get the name, discounts, and city for all customers who place orders through agents in London or New York.
select name, discount, city
from customers
where cid in( select cid
              from orders
              where aid in( select aid
                            from agents
                            where city in( 'London', 'New York')));
                              
--7. Get all customers who have the same discount as that of any cusotmers in Dallas or London.
select *
from customers
where discount in( select discount
                   from customers
                   where city in( 'Dallas', 'London'));

--8. Tell me about check constraints: What are they? What are they good for? What is the advantage of putting that sort of thing inside the database? Make up some examples of good uses of check constraints and some examples of bad uses of check constraints. Explain the differences in your examplea and argue your case.
--Check constraints are essentialy specifications as to which entries can be entered in columns, whether those constraints be within a range or a list of certain entries.
--These constraints are useful for standardizing a list by certain constants (such as only including people of teenage age for astudy done about teens), but are not very useful or effective for instances of attempting to specify certain broad or vague elements (such as only allowing people with blonde hair to be included in a table of with various eye colors).
