/* SCD Type 2: Maintain history in a dimension table
   Dim has: BusinessKey, attributes..., EffectiveStartDate, EffectiveEndDate, IsCurrent
*/

DECLARE @as_of DATETIME2 = SYSDATETIME();

-- Stage snapshot
SELECT
    CustomerBK,
    CustomerName,
    Segment
INTO #stage
FROM dbo.CustomerSnapshot;

-- Close current records where attributes changed
UPDATE d
SET
    d.EffectiveEndDate = @as_of,
    d.IsCurrent = 0
FROM dbo.DimCustomer d
JOIN #stage s
    ON d.CustomerBK = s.CustomerBK
WHERE d.IsCurrent = 1
  AND (ISNULL(d.CustomerName,'') <> ISNULL(s.CustomerName,'')
       OR ISNULL(d.Segment,'') <> ISNULL(s.Segment,''));

-- Insert new current records (new customers or changed customers)
INSERT INTO dbo.DimCustomer
(CustomerBK, CustomerName, Segment, EffectiveStartDate, EffectiveEndDate, IsCurrent)
SELECT
    s.CustomerBK,
    s.CustomerName,
    s.Segment,
    @as_of,
    CONVERT(DATE, '9999-12-31'),
    1
FROM #stage s
LEFT JOIN dbo.DimCustomer d
    ON d.CustomerBK = s.CustomerBK
   AND d.IsCurrent = 1
WHERE d.CustomerBK IS NULL
   OR (ISNULL(d.CustomerName,'') <> ISNULL(s.CustomerName,'')
       OR ISNULL(d.Segment,'') <> ISNULL(s.Segment,''));