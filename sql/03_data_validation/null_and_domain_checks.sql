/* Validation: Null checks + domain checks (allowed values)
   Replace columns/allowed values as needed.
*/

-- Required fields should not be null
SELECT COUNT(*) AS NullBusinessKey
FROM dbo.TargetTable
WHERE BusinessKey IS NULL;

SELECT COUNT(*) AS NullLastModified
FROM dbo.TargetTable
WHERE LastModifiedDate IS NULL;

-- Domain check example (Status must be one of known values)
SELECT Status, COUNT(*) AS Cnt
FROM dbo.TargetTable
GROUP BY Status
HAVING Status NOT IN ('Active', 'Inactive', 'Retired');