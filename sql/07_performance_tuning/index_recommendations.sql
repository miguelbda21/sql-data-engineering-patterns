/* Performance: Basic index suggestions (example)
   Create indexes on join keys and filter columns used in WHERE.
*/

-- Example index on BusinessKey for faster merges/joins
CREATE INDEX IX_TargetTable_BusinessKey
ON dbo.TargetTable (BusinessKey);

-- Example composite index on (LastModifiedDate, BusinessKey) for incremental loads
CREATE INDEX IX_SourceTable_LastModified_BusinessKey
ON dbo.SourceTable (LastModifiedDate, BusinessKey);