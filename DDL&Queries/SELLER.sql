--FIRST INSERT THE ID
do
$do$
declare
     i int;
begin
for  i in 700..3000
loop
    insert into seller VALUES(i,floor(random()*(15-1+1))+1,floor(random()*(601-102+1))+102);
end loop;
end
$do$;

do
$do$
declare
     i int;
begin
for  i in 3001..30000
loop
    insert into seller VALUES(i,floor(random()*(15-1+1))+1,floor(random()*(601-102+1))+102);
end loop;
end
$do$;