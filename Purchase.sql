do
$do$
declare
     i int;
begin
for  i in 1..10000
loop
    insert into purchase(essn, code, cssn, count)
    values (random()*(30000-1+1)+1, random()*(500-1+1)+1,random()*(500-1+1)+1,random()*(1000-1+10)+1);

end loop;
end
$do$;

do $$
begin
for i in 10001..100000 loop
insert into purchase(essn, code, cssn, count)
    values (random()*(30000-1+1)+1, random()*(500-1+1)+1,random()*(500-1+1)+1,random()*(1000-1+10)+1);
end loop;
end;
$$;