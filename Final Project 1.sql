--Bryan Chester
--June 17, 2016
--Database Management
--Pablo Rivas, CMPT 206
--Design Project

drop table if exists music;
drop table if exists composers;
drop table if exists arrangers;
drop table if exists members;
drop table if exists checkout;
drop table if exists muslocale;
drop table if exists stock;

create table music (
  mid int NOT NULL,
  name text NOT NULL,
  composer text,
  arranger text,

  primary key(mid)
);

create table composers (
  cid int NOT NULL,
  name text NOT NULL,
  dob text,
  dod text,

  primary key(cid)
);

create table arrangers (
  aid int NOT NULL,
  name text NOT NULL,
  dob text,
  dod text,

  primary key(aid)
);

create table members (
  mid int NOT NULL,
  name text NOT NULL,
  st text NOT NULL,

  primary key(mid)
);

create table checkout (
  sid int NOT NULL,
  outdate text NOT NULL,
  indate text NOT NULL,

  primary key(sid)
);

create table muslocale (
  mid int NOT NULL
  location text
  date text
  cid int
  aid int

  primary key(mid)
);
create table stock (
  cid int NOT NULL,
  condition text NOT NULL,
  quantity int NOT NULL,

  primary key(cid)
);

--music
insert into music (mid, name, composer, arranger)
  values ('007', 'The Four Seasons', 'Antonio Vivaldi', 'Antonio Vivaldi');

insert into music

insert into music

insert into music

insert into music

--composers
insert into composers (cid, name, dob, dod)

insert into composers

insert into composers

insert into composers

insert into composers

insert into composers