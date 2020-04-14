(select c.cssn, r.tv_id, pr.code
from product_review pr, reklama r, costumer c
where pr.grade < 4 and pr.code = r.code and c.cssn = pr.cssn)
EXCEPT
(select c.cssn, r.tv_id, pr.code
from product_review pr, reklama r, costumer c
where pr.grade = 4 and pr.code = r.code and c.cssn = pr.cssn);

CREATE INDEX product_grade
on product_review(grade);
create index reklama_sporev_tv
on reklama(tv_id);













