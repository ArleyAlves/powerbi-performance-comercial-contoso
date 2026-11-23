
USE ContosoRetailDW

SELECT TOP 10 
 p.ProductName
 ,p.BrandName
 ,pc.ProductCategoryName
 ,ROUND(SUM(f.SalesAmount),2) AS faturamento_total
 ,SUM(f.SalesQuantity) AS vendas_total
FROM FactSales AS f

INNER JOIN DimProduct As p
	ON p.ProductKey = f.ProductKey
INNER JOIN DimProductSubcategory AS ps
	ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
INNER JOIN DimProductCategory AS pc
	ON pc.ProductCategoryKey = ps.ProductCategoryKey

GROUP BY p.ProductName, p.BrandName, pc.ProductCategoryName
ORDER BY faturamento_total DESC