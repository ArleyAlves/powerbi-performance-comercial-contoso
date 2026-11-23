
SELECT 
	Datekey
	,FullDateLabel
	,CalendarYear
	,CalendarMonth
	,CalendarMonthLabel
	,CalendarQuarterLabel
FROM DimDate

WHERE CalendarYear BETWEEN 2007 AND 2009