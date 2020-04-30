do
$do$
declare
     i int;
begin
for  i in 1..1000000
loop
    insert into employee VALUES(i,concat('employeeName-',i),concat('employeetSurname-',i),concat('epmloyeeEmail-',random()),concat('employeeAddress'),floor(random()*(675-102+1))+102, '2008-01-01 00:00:01','2010-01-01 00:00:01');
end loop;
end
$do$;