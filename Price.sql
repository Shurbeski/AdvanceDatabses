do
$do$
declare
     i int;
begin
for  i in 1..500
loop
    insert into price VALUES(i+1000,i,random()*100,'2016-06-22 19:10:25-07','2017-08-22 19:10:25-07');
end loop;
end
$do$;

do
$do$
declare
     i int;
begin
for  i in 501..100000
loop
    insert into price VALUES(i+1000,i,random()*100,'2016-06-22 19:10:25-07','2017-08-22 19:10:25-07');
end loop;
end
$do$;