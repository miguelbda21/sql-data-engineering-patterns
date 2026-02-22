/* Performance: SARGability examples
   SARGable predicates allow index seeks.
*/

-- NON-SARGable (function on column prevents index seek)
SELECT *
FROM dbo.SourceTable
WHERE CONVERT(DATE, LastModifiedDate) = '2026-02-01';

-- SARGable (range predicate)
SELECT *
FROM dbo.SourceTable
WHERE LastModifiedDate >= '2026-02-01'
  AND LastModifiedDate <  '2026-02-02';