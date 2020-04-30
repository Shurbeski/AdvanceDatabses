do
$do$
declare
     i int;
begin
for  i in 1..10000
loop
    insert into costumer (cssn, payment_type, name, surname, delivery_address, agent_seller_cssn)
    values (i,floor(random()*(5-1+1))+1,concat('name-',i),concat('surname-',i),concat('deliberyAddress-',i),floor(random()*(4500-4200+1))+4200);
end loop;
end
$do$;

do $$
begin
for i in 10001..100000 loop
insert into costumer (cssn, payment_type, name, surname, delivery_address, agent_seller_cssn)
    values (i,floor(random()*(5-1+1))+1,concat('name-',i),concat('surname-',i),concat('deliberyAddress-',i),floor(random()*(4500-4200+1))+4200);
end loop;
end;
$$;



