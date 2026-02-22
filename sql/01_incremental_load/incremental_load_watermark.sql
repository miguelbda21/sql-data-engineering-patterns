-- Incremental Load Using Watermark Pattern
-- Loads only records modified since the last successful load

DECLARE @last_successful_load DATETIME2 = '2026-02-01 00:00:00';

-- Stage delta records
SELECT *
INTO #stage_delta
FROM dbo.SourceTable s
WHERE s.LastModifiedDate > @last_successful_load;

-- Deduplicate (keep most recent per BusinessKey)
;WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY BusinessKey
               ORDER BY LastModifiedDate DESC
           ) AS rn
    FROM #stage_delta
)
SELECT *
INTO #stage_dedup
FROM ranked
WHERE rn = 1;

-- Merge into target
MERGE dbo.TargetTable AS t
USING #stage_dedup AS s
ON t.BusinessKey = s.BusinessKey
WHEN MATCHED THEN
    UPDATE SET
        t.Col1 = s.Col1,
        t.Col2 = s.Col2,
        t.LastModifiedDate = s.LastModifiedDate
WHEN NOT MATCHED THEN
    INSERT (BusinessKey, Col1, Col2, LastModifiedDate)
    VALUES (s.BusinessKey, s.Col1, s.Col2, s.LastModifiedDate);

-- Return new watermark
SELECT MAX(LastModifiedDate) AS NewWatermark
FROM #stage_dedup;