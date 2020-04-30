CREATE OR REPLACE FUNCTION get_freq_table()
RETURNS TABLE
        (
            cssn               integer,
            category_id        integer,
            frequency          numeric

        )
        AS $$
        BEGIN
        RETURN QUERY
        WITH a as (      SELECT costumer.cssn as mushterija, product.category_id as kategorija, count(category_id) as kupuvanja_od_kategorijata
                         FROM purchase, costumer, product
                         WHERE costumer.cssn = purchase.cssn AND product.code = purchase.code
                         group by costumer.cssn, purchase.code, category_id),
             b as(
                 select mushterija, sum(kupuvanja_od_kategorijata) as vkupno
                 from a
                 group by mushterija
        ),
             c as(
                 select a.mushterija,a.kategorija, round(a.kupuvanja_od_kategorijata/b.vkupno,2) as procent
                 from a, b
                 where a.mushterija = b.mushterija
                 group by  a.mushterija, a.kategorija, a.kupuvanja_od_kategorijata/b.vkupno

             )
            select c.mushterija :: integer,
                   c.kategorija :: integer,
                   c.procent :: numeric
            from c;
        END;
$$  LANGUAGE 'plpgsql'

-- TEKOVNI IZVESHTAI ZA SEKOJ OD KUPUVACHITE PROCENTUALNO KOJA KATEOGORIJA JA PREFERIRAAT--