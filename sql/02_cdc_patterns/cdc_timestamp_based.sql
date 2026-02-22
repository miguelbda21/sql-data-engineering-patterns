/* CDC Pattern: Timestamp-based delta extraction
   Use when you have LastModifiedDate/UpdatedAt on source tables.
*/

DECLARE @last_watermark DATETIME2 = '2026-02-01 00:00:00';

SELECT
    s.*
FROM dbo.SourceTable s
WHERE s.LastModifiedDate > @last_watermark
ORDER BY s.LastModifiedDate;