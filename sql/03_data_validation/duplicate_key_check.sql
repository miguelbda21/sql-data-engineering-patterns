/* Validation: Duplicate detection on business key
*/

SELECT BusinessKey, COUNT(*) AS Cnt
FROM dbo.TargetTable
GROUP BY BusinessKey
HAVING COUNT(*) > 1
ORDER BY Cnt DESC;