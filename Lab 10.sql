--Bryan Chester
--June 17, 2016
--Database Management
--Pablo Rivas, CMPT 308
--Lab 10: Stored Procedures

----------------------------------------------------------------------------------------
-- Courses and Prerequisites
-- by Pablo Rivas and Alan G. Labouseur
-- Tested on Postgres 9.3.2 by Alan
--           Postgres 9.3.12 by Pablo
----------------------------------------------------------------------------------------

--
-- The table of courses.
--
create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;


--
-- An example stored procedure ("function")
--
create or replace function get_courses_by_credits(int, REFCURSOR) returns refcursor as 
$$
declare
   num_credits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  credits >= num_credits;
   return resultset;
end;
$$ 
language plpgsql;

select get_courses_by_credits(0, 'results');
Fetch all from results;

--1.

drop function PreReqsFor (cnum int);
create or replace function PreReqsFor (courseNum int)
returns int as
$$
  declare
    prerec int;
    result refcursor;
  begin
    open result for select p.preReqNum
                    from Prerequisites p
                    where cnum = p.coursenum;
    return result;
  end;
$$ language plpgsql;

select PreReqsFor(499);

--2.

create or replace function IsPreReqFor(courseNum int)
returns int as 
$$
declare
   result refcursor;
   
begin
   open result for 
      select p.courseNum
      from PreRequisites p
      where p.preReqNum = p.courseNum;
   return result;
end;
$$
language PLPGSQL;

select IsPreReqFor(308);
