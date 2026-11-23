
USE ContosoRetailDW

SELECT
pc.ProductCategoryName
,ROUND(SUM(f.SalesAmount),2) AS total_faturamento
,ROUND(SUM(f.ReturnAmount),2) AS total_devolucao
,ROUND(SUM(f.ReturnAmount)/NULLIF(SUM(f.SalesAmount),0)*100,2) AS pct_devolucao
FROM FactSales AS f

INNER JOIN DimProduct AS p
	ON p.ProductKey = f.ProductKey
INNER JOIN DimProductSubcategory AS ps
	ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
INNER JOIN DimProductCategory AS pc
	ON pc.ProductCategoryKey = ps.ProductCategoryKey

GROUP BY pc.ProductCategoryName
ORDER BY pct_devolucao DESC