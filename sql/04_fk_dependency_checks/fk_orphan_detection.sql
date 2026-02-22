/* FK Dependency: Orphan detection
   Find fact records without a matching dimension record.
*/

SELECT f.*
FROM dbo.FactSales f
LEFT JOIN dbo.DimCustomer d
    ON f.CustomerKey = d.CustomerKey
WHERE d.CustomerKey IS NULL;