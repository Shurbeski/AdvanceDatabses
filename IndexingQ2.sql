SELECT c.name, e.name, sr.grade, (SUM(pp.price)*0.9)BONUS
FROM purchase p, costumer c, employee e, store_review sr, product pp, seller s
WHERE P.count > 900 AND P.essn = E.essn AND P.cssn = c.cssn AND P.cssn = sr.cssn
and pp.code = p.code and s.essn = e.essn
GROUP BY e.name, c.name, sr.grade;

CREATE INDEX count_index
ON purchase(count)
