
USE ContosoRetailDW

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