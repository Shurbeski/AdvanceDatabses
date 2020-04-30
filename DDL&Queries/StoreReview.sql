do
$do$
declare
     i int;
begin
for  i in 1..500
loop
    insert into store_review(store_id, cssn, grade, comment)
    VALUES(i,501-i,floor(random()*(4-1+1)+1),'comment');
end loop;
end
$do$;

do $$
begin
for i in 501..100000 loop
 insert into store_review(store_id, cssn, grade, comment)
    VALUES(i,100001-i,floor(random()*(4-1+1)+1),'comment');
end loop;
end;
$$;