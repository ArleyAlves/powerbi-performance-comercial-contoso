
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