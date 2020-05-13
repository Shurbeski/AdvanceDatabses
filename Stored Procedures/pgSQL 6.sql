CREATE OR REPLACE FUNCTION procent_na_prodazba_po_tv()
RETURNS TABLE
        (
            code               integer,
            channel            integer,
            frequency          numeric

        )
        AS $$
        BEGIN
        RETURN QUERY
        WITH pom4 as ( select p.code, r.tv_id, sum(count) as vkupno_na_tvo_po_proizvod
                    from purchase p, reklama r
                    where p.code = r.code
                    group by p.code, r.tv_id),
             pom5 as(
                 select tv_id,sum(vkupno_na_tvo_po_proizvod) as total_sales
                 from pom4
                 group by tv_id
        ),
             c as(
                 select pom4.code,pom4.tv_id, round(pom4.vkupno_na_tvo_po_proizvod/pom5.total_sales,3) as procent
                 from pom4, pom5
                 where pom4.tv_id = pom5.tv_id
                 group by pom4.code, pom4.tv_id, procent

             )
            select c.code :: integer,
                   c.tv_id :: integer,
                   c.procent :: numeric
            from c;
        END;
$$  LANGUAGE 'plpgsql';

select *
from procent_na_prodazba_po_tv()
order by channel