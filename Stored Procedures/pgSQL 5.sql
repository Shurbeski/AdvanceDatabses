CREATE OR REPLACE FUNCTION kupuvanje_proizvodi(IN x int,IN y int, IN prozivodi int)
RETURNS VOID
AS $$
    DECLARE
        CNT INTEGER;
BEGIN
    SELECT count INTO CNT
    FROM stock
    WHERE x = store_id and y = product_code;
    IF cnt >= prozivodi THEN
        UPDATE stock
        SET count = count - prozivodi
        where store_id = x and  product_code = y;
    ELSE IF cnt < prozivodi THEN
        RAISE EXCEPTION 'Neuspeshna transakcija %', now();
    end if;
    end if;


END;
$$ LANGUAGE plpgsql;
--proba--
select kupuvanje_proizvodi(1, 1, 1);

select *
from stock
where store_id = 1 and product_code = 1;