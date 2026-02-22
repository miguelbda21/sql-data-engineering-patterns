/* MERGE/UPSERT basic pattern */

MERGE dbo.TargetTable AS t
USING dbo.StageTable AS s
ON t.BusinessKey = s.BusinessKey
WHEN MATCHED THEN
    UPDATE SET
        t.Col1 = s.Col1,
        t.Col2 = s.Col2,
        t.LastModifiedDate = s.LastModifiedDate
WHEN NOT MATCHED THEN
    INSERT (BusinessKey, Col1, Col2, LastModifiedDate)
    VALUES (s.BusinessKey, s.Col1, s.Col2, s.LastModifiedDate);