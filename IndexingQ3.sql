SELECT cos.name, c.name,max(p.count)
FROM talk t, purchase p, category c, costumer cos, product
WHERE t.duration < '00:30:00' AND T.c_cssn = cos.cssn AND T.c_cssn = P.cssn
AND P.code = product.code AND product.category_id = c.id
GROUP BY  cos.name, c.name;

CREATE INDEX duration
ON talk(duration)
WHERE duration < '00:30:00';

DROP INDEX duration;

--Go izbrishav indeksot bidekji mi ja usporuvashe operacijata na vnsuvanje na podatoci!!


