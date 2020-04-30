ALTER TABLE costumer
  ADD loyalty INTEGER;

CREATE FUNCTION costumerLoyalty() RETURNS trigger AS $$
DECLARE
do_backup  INTEGER;
BEGIN
    SELECT sum(purchase.count)  INTO do_backup FROM purchase, costumer WHERE costumer.cssn=NEW.cssn;
    IF(do_backup < 100) THEN
        INSERT INTO costumer(loyalty)
        VALUES (1);
    ELSE IF(do_backup > 100 AND do_backup < 1000) THEN
        INSERT INTO costumer(loyalty)
        VALUES (2);
    ELSE
        INSERT INTO costumer(loyalty)
        VALUES (3);

    end if;
    end if;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER table_styles_backup AFTER UPDATE ON purchase
FOR EACH ROW EXECUTE PROCEDURE costumerLoyalty();

-- GI RANGIRAME SITE MUSHTERII PO LOJALNOST VO ODNOS NA KUPENITE PROIZVODI--