do
$do$
declare
     i int;
begin
for  i in 1..10
loop
    insert into televizija VALUES(i+12,concat('tv ',i));
end loop;
end
$do$;