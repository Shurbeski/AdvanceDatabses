do
$do$
declare
     i int;
begin
for  i in 1..10000
loop
    insert into product VALUES(i,concat('productName-',i),random()*100,concat('countryOfProduction-',i),floor(random()*(25-1+1))+1);
end loop;
end
$do$;

do $$
begin
for i in 10001..100000 loop
    insert into product VALUES(i,concat('productName-',i),random()*100,concat('countryOfProduction-',i),floor(random()*(25-1+1))+1);
end loop;
end;
$$;


