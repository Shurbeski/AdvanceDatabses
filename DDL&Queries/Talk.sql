do
$do$
declare
     i int;
begin
for  i in 1..500
loop
    insert into talk(id, as_essn, c_cssn, goal, date, duration)
    VALUES(i,random()*(4499-4200+1)+4200,i,'Sell product', timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00'), random() * (interval ' 2 hours'));
end loop;
end
$do$;

do $$
begin
for i in 501..100000 loop
insert into talk(id, as_essn, c_cssn, goal, date, duration)
    VALUES(i,random()*(4499-4200+1)+4200,i,'Sell product', timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00'), random() * (interval ' 2 hours'));
end loop;
end;
$$;