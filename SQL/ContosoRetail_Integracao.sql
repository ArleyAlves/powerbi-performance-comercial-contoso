
-- Importando fatSales
SELECT
	SalesKey
	,DateKey
	,channelKey
	,ProductKey
	,SalesQuantity
	,SalesAmount
	,ReturnQuantity
	,ReturnAmount
	,TotalCost
FROM FactSales


-- Importando dimProduct
SELECT
	p.ProductKey
	,p.ProductName
	,COALESCE(p.BrandName, 'Sem Marca') AS BrandName
	,COALESCE(ps.ProductSubcategoryName, 'Sem Subcategoria') AS ProductSubCategoryName
	,COALESCE(pc.ProductCategoryName,'Sem Categoria') AS ProductCategoryName
FROM DimProduct AS p

LEFT JOIN DimProductSubcategory AS ps
	ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN DimProductCategory AS pc
	ON pc.ProductCategoryKey = ps.ProductCategoryKey


-- Importando dimDate
SELECT 
	Datekey
	,FullDateLabel
	,CalendarYear
	,CalendarMonth
	,CalendarMonthLabel
	,CalendarQuarterLabel
FROM DimDate

WHERE CalendarYear BETWEEN 2007 AND 2009


-- Importando dimChannel
SELECT 
	ChannelKey
	,ChannelName
FROM DimChannel
