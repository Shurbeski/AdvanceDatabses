
do
$do$
declare
     i int;
begin
for  i in 4200..4500
loop
    insert into agent_seller VALUES(i,random()*(601-102+1)+102);
end loop;
end
$do$;