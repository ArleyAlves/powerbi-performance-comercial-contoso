
USE ContosoRetailDW

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