do
$do$
declare
     i int;
begin
for  i in 1..1000
loop
    insert into store VALUES(i,concat('NameOfStore-',i),concat('AddressOfStore-',i));
end loop;
end
$do$;

do $$
begin
for i in 1001..100000 loop
    insert into store VALUES(i,concat('NameOfStore-',i),concat('AddressOfStore-',i));
end loop;
end;
$$;