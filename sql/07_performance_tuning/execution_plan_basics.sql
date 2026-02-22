/* Performance: Quick checks
   Use Actual Execution Plan in SSMS to compare.
*/

-- Check IO/time for a query (SQL Server)
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT TOP 1000 *
FROM dbo.SourceTable
WHERE LastModifiedDate >= DATEADD(DAY, -7, SYSDATETIME());

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;