
create table user (
id int auto_increment primary key,
name varchar(100),
amount double);

insert into user(name, amount)
select 
  concat(
    char(floor(rand()*26+65))
    ,char(floor(rand()*26+65))
    ,char(floor(rand()*26+65))
  ) as name
  ,round(rand()*100, 2) as amount
FROM information_schema.columns limit 100;
/*
SELECT * FROM user;
*/


create table spending(
id int auto_increment primary key,
user_id varchar(100),
item varchar(100),
price int,
unit int
);

insert into spending(user_id, item, price, unit)
select 
  ( select id from user order by rand() limit 1) as user_id
  ,(case floor(rand()*3) 
    when 0 then 'pen'
    when 1 then 'book'
    else 'ink' 
    end
  ) as item
  ,round(rand()*10,2) as price
  ,floor(1 + rand()*10) as unit
from information_schema.columns limit 100;

/*
select * from spending;


select * from user where id not in (select user_id from spending);
*/
select
  u.*
  ,count(s.id) as spend_count
from user u
left join spending s on u.id = s.user_id
group by u.id, u.name, u.amount
;
