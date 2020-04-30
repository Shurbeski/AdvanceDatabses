

ALTER TABLE reklama DROP CONSTRAINT pk_r;

ALTER TABLE reklama
ADD CONSTRAINT PK_Person PRIMARY KEY (tv_id,code);



do
$do$
declare
     i int;
begin
for  i in 1..100000
loop
    insert into reklama (tv_id, code, date)
    VALUES (random()*(21-13+1)+13,i,timestamp '2019-01-10 20:00:00' +
       random() * (interval ' 2 hours'));

end loop;
end
$do$;

