SELECT
COALESCE((SELECT SUM(inc) FROM Income_o WHERE inc IS NOT NULL and point is not null), 0) - 
COALESCE((SELECT SUM(out) FROM Outcome_o WHERE out IS NOT NULL and point is not null), 0)  AS SUM
