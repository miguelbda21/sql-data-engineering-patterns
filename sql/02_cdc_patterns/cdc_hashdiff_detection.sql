/* CDC Pattern: Hash-diff change detection
   Use when you want to detect changes across multiple columns.
   Store RowHash in the target to compare.
*/

-- Stage with computed hash
SELECT
    s.BusinessKey,
    s.Col1,
    s.Col2,
    s.Col3,
    HASHBYTES('SHA2_256', CONCAT_WS('|',
        COALESCE(CONVERT(NVARCHAR(4000), s.Col1), ''),
        COALESCE(CONVERT(NVARCHAR(4000), s.Col2), ''),
        COALESCE(CONVERT(NVARCHAR(4000), s.Col3), '')
    )) AS RowHash
INTO #stage
FROM dbo.SourceTable s;

-- Classify changes
SELECT
    st.BusinessKey,
    CASE
        WHEN t.BusinessKey IS NULL THEN 'INSERT'
        WHEN t.RowHash <> st.RowHash THEN 'UPDATE'
        ELSE 'NO_CHANGE'
    END AS ChangeType
FROM #stage st
LEFT JOIN dbo.TargetTable t
    ON t.BusinessKey = st.BusinessKey;