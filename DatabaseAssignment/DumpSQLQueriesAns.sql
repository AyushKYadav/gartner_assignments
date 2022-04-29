---1. Select users whose id is either 3,2 or 4
--- Please return at least: all user fields

select * from users where id in (3,2,4)



---2. Count how many basic and premium listings each active user has
-- Please return at least: first_name, last_name, basic, premium

select u.first_name,u.last_name,t.status,t.countstatus from users u
inner join (
select user_id ,status,COUNT(status) as countstatus
from listings where status = 2 group by user_id,status
UNION
select user_id ,status,COUNT(status) as countstatus
from listings where status = 3 group by user_id,status
) t on u.id = t.user_id and u.status = 2;



---3. Show the same count as before but only if they have at least ONE premium listing
-- Please return at least: first_name, last_name, basic, premium

select u.first_name,u.last_name,t.status,t.countstatus from users u
inner join (
select user_id ,status,COUNT(status) as countstatus
from listings where status = 2 group by user_id,status
UNION
select user_id ,status,COUNT(status) as countstatus
from listings where status = 3 group by user_id,status
) t on u.id = t.user_id and t.countstatus>=1 and u.status = 2;



---4. How much revenue has each active vendor made in 2013
--- Please return at least: first_name, last_name, currency, revenue

select t.first_name,t.last_name,t.currency, sum(t.price) as revenue from
(
select  u.first_name,u.last_name,c.currency,c.price from users u 
inner join listings l
on u.id = l.user_id and u.status = 2
inner join clicks c 
on c.listing_id = l.id and YEAR(c.created) = 2013
) t group by first_name,last_name,currency ;



---5. Insert a new click for listing id 3, at $4.00
--- Find out the id of this new click. Please return at least: id

INSERT INTO clicks VALUES (33,3,4.00,'USD',GETDATE());
select TOP(1) id
from clicks order by created DESC ;



---6. Show listings that have not received a click in 2013
--- Please return at least: listing_name

select name from listings
where id NOT IN (select listing_id from clicks where YEAR(created) = 2013 )



---7. For each year show number of listings clicked and number of vendors who owned these listings
--- Please return at least: date, total_listings_clicked, total_vendors_affected

select t.years, count(t.listingid) as total_listings_clicked, count(t.userid) as total_vendors_affected
from
(
select u.id as userid,l.id as listingid,YEAR(c.created) as years from users u
inner join listings l
on u.id = l.user_id
inner join clicks c
on l.id = c.listing_id
)t group by years;



---8. Return a comma separated string of listing names for all active vendors
--- Please return at least: first_name, last_name, listing_names

select t.first_name ,t.last_name, STRING_AGG(t.name,',') as listing_names
from (
select l.name,u.first_name,u.last_name 
from listings l
inner join users u
on l.user_id = u.id 
and u.status = 2
)t group by t.first_name ,t.last_name;


