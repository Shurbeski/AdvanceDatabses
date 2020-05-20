CREATE OR REPLACE FUNCTION count_n_product3(IN x int,IN y int, IN count int)
RETURNS VOID
AS $$
BEGIN
    IF count < 5 THEN
    RAISE exception 'Imame mala kolichina vo prodavnica  % na produktot % %',x, y, now();
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION check_count_on_stock() RETURNS trigger AS $$
DECLARE
BEGIN

    PERFORM count_n_product3(old.store_id, old.product_code, old.count );
    RETURN new;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION check_count_on_stock();

CREATE TRIGGER check_count_on_stock
BEFORE update ON stock
FOR EACH ROW EXECUTE
PROCEDURE check_count_on_stock();


DROP TRIGGER check_count_on_stock ON stock;

select count_n_product3(1,1,0);
--proba--
CREATE TRIGGER check_update
    BEFORE UPDATE ON stock
    FOR EACH ROW
    WHEN (OLD.count IS DISTINCT FROM NEW.count)
    EXECUTE PROCEDURE count_n_product3();
