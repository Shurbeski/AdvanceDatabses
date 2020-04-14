do
$do$
declare
     i int;
begin
for  i in 1..25
loop
    insert into category VALUES(i,concat('CategoryName-',i),null );
end loop;
end
$do$;

do
$do$
declare
     i int;
begin
for  i in 1..25
loop
   UPDATE category
SET sub_category = floor(random()*(25-1+1)+1)
WHERE category.id = i;
end loop;
end
$do$;