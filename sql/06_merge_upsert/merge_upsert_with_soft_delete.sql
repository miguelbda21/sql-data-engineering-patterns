/* MERGE with soft delete
   Marks rows missing from stage as IsActive=0.
*/

MERGE dbo.TargetTable AS t
USING dbo.StageTable AS s
ON t.BusinessKey = s.BusinessKey
WHEN MATCHED THEN
    UPDATE SET
        t.Col1 = s.Col1,
        t.Col2 = s.Col2,
        t.IsActive = 1,
        t.LastModifiedDate = s.LastModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT (BusinessKey, Col1, Col2, IsActive, LastModifiedDate)
    VALUES (s.BusinessKey, s.Col1, s.Col2, 1, s.LastModifiedDate)
WHEN NOT MATCHED BY SOURCE THEN
    UPDATE SET
        t.IsActive = 0,
        t.LastModifiedDate = SYSDATETIME();