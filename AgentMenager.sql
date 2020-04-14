do
$do$
declare
     i int;
begin
for  i in 102..675

loop
    INSERT INTO agent_menager(essn)
    SELECT employee.essn
    from employee
    where employee.essn = i;

end loop;
end
$do$;