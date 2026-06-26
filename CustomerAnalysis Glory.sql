-- Query 1: Identifying High Rollers
-- This query identifies VIP customers by filtering for single orders that exceed $5,000.
SELECT 
    c.FirstName, 
    c.LastName, 
    c.CompanyName,
    soh.OrderDate, 
    soh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS soh 
    ON c.CustomerID = soh.CustomerID
WHERE soh.TotalDue > 5000.00
ORDER BY soh.TotalDue DESC;

-- Query 2: The Product Affinity Pattern
-- This query targets customers who purchased items related to "Touring" to build a specific marketing segment.
SELECT DISTINCT 
    c.FirstName, 
    c.LastName, 
    c.EmailAddress,
    p.Name AS ProductName
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS soh 
    ON c.CustomerID = soh.CustomerID
JOIN SalesLT.SalesOrderDetail AS sod 
    ON soh.SalesOrderID = sod.SalesOrderID
JOIN SalesLT.Product AS p 
    ON sod.ProductID = p.ProductID
WHERE p.Name LIKE '%Touring%'
ORDER BY c.LastName;

-- Query 3: The Brand Loyalty Pattern
-- This query groups order data to find repeat customers (those with more than 1 order) and calculates their total lifetime value.
SELECT 
    c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    COUNT(soh.SalesOrderID) AS [TotalOrders Placed],
    SUM(soh.TotalDue) AS LifetimeValue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS soh 
    ON c.CustomerID = soh.CustomerID
GROUP BY 
    c.CustomerID, 
    c.FirstName, 
    c.LastName
HAVING COUNT(soh.SalesOrderID) > 1
ORDER BY [TotalOrders Placed] DESC;