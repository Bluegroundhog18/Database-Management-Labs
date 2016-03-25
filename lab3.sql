-- Bryan Chester
-- February 10, 2016
-- Database Management
-- Pablo Rivas
-- Lab 3: CAP Database

-- 1. 
select ordno, dollars
from orders;
-- 2.
select name, city
from agents where name = 'Smith';
-- 3.
select pid, name, priceUSD
from products where quantity > 208000;
-- 4.
select name, city
from customers where city = 'Dallas';
-- 5. 
select name
from agents where city != 'New York' and city != 'Tokyo';
-- 6.
select *
from products where city != 'Dallas' and city != 'Duluth' and priceUSD >= 1.00;
-- 7.
select *
from orders where mon = 'jan' or mon = 'mar';
-- 8.
select *
from orders where mon = 'feb' and dollars >= 500.00;
-- 9.
select *
from orders where cid = 'c005';
