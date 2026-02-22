/* Validation: Row count reconciliation
   Quick check that source vs target volumes match expectations.
*/

SELECT 'SourceTable' AS Dataset, COUNT(*) AS RowCount
FROM dbo.SourceTable
UNION ALL
SELECT 'TargetTable' AS Dataset, COUNT(*) AS RowCount
FROM dbo.TargetTable;