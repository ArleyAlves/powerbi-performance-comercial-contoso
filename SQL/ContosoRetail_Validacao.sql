
USE ContosoRetailDW


-- Análise de Desempenho por Canal de Vendas
SELECT
	c.ChannelName AS canal_vendas
	,YEAR(MIN(f.DateKey)) AS data_inicio
	,YEAR(MAX(f.DateKey)) AS data_fim
	,COUNT(*) AS total_transacaoes
	,ROUND(SUM(f.SalesAmount),2) AS total_faturamento
	,ROUND(SUM(f.ReturnAmount),2) AS total_devolucao
	,ROUND(SUM(f.TotalCost),2) AS custo_total
	,ROUND(SUM(f.ReturnAmount)/NULLIF(SUM(f.SalesAmount),0)*100,2) AS pct_devolucao
FROM FactSales AS f
INNER JOIN DimChannel AS c
	ON c.ChannelKey = f.channelKey
GROUP BY c.ChannelName
ORDER BY SUM(f.SalesAmount) DESC


-- Taxa de Devolução por Categoria de Produto
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


-- Evolução Temporal de Vendas (Tendência Anual)
SELECT
	d.CalendarYear
	,d.CalendarMonth
	,d.CalendarMonthLabel
	,c.ChannelName
	,ROUND(SUM(f.SalesAmount),2) AS faturamento_total
	,ROUND(SUM(f.ReturnAmount),2)AS devolucao_total
FROM FactSales AS f

JOIN DimChannel AS c
	ON c.ChannelKey = f.channelKey
JOIN DimDate AS d
	ON d.Datekey = f.DateKey

GROUP BY d.CalendarYear, d.CalendarMonth, d.CalendarMonthLabel,  c.channelName
ORDER BY d.CalendarYear, d.CalendarMonth, c.ChannelName


-- Top 10 Produtos Mais Vendidos
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