do $$
begin
for i in 1..1000 loop
    for j in 1 .. 100 loop
    insert into stock VALUES(i,j,random()*100);
end loop;
    end loop ;
end;
$$;

DELETE FROM stock;