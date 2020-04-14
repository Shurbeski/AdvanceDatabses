
SELECT sr.store_id, c.name, e.name
FROM store_review sr, costumer c, talk t, employee e
where sr.grade > 3 and c.cssn = sr.cssn and sr.cssn = t.c_cssn and t.as_essn = e.essn ;

CREATE INDEX store_index
ON store_review(grade);
-- STAVIV INDEX NA GRADE BUDEKJI TOA NI E GLAVNIOT USLOV VRZ KOJ SE IZVRSHUVA
--SELEKCIJA, SO INDEKSIRANJE VEDNASH ODIME NA REDICITE KOI IMAAT OCENKA POVISOKA
-- OD 3