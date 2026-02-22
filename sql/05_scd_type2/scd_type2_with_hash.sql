/* SCD Type 2 with hash-diff to detect changes efficiently */
DECLARE @as_of DATETIME2 = SYSDATETIME();

SELECT
    CustomerBK,
    CustomerName,
    Segment,
    HASHBYTES('SHA2_256', CONCAT_WS('|',
        ISNULL(CustomerName,''), ISNULL(Segment,'')
    )) AS AttrHash
INTO #stage
FROM dbo.CustomerSnapshot;

-- Close changed
UPDATE d
SET d.EffectiveEndDate = @as_of,
    d.IsCurrent = 0
FROM dbo.DimCustomer d
JOIN #stage s
    ON d.CustomerBK = s.CustomerBK
WHERE d.IsCurrent = 1
  AND d.AttrHash <> s.AttrHash;

-- Insert new current
INSERT INTO dbo.DimCustomer
(CustomerBK, CustomerName, Segment, AttrHash, EffectiveStartDate, EffectiveEndDate, IsCurrent)
SELECT
    s.CustomerBK, s.CustomerName, s.Segment, s.AttrHash,
    @as_of, CONVERT(DATE,'9999-12-31'), 1
FROM #stage s
LEFT JOIN dbo.DimCustomer d
    ON d.CustomerBK = s.CustomerBK
   AND d.IsCurrent = 1
WHERE d.CustomerBK IS NULL
   OR d.AttrHash <> s.AttrHash;