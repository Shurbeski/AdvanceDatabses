CREATE OR REPLACE FUNCTION narachka(IN x int,IN y int, IN novi int)
RETURNS VOID
AS $$

BEGIN
    UPDATE stock
    SET count= novi + count
    where store_id = x and  product_code = y;
END;
$$ LANGUAGE plpgsql;

select narachka(1,1,1)

