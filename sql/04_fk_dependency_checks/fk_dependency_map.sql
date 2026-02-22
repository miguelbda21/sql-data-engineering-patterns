/* FK Dependency: Map foreign keys referencing a table
   Shows which tables/columns reference a target table.
*/

DECLARE @target_table SYSNAME = 'DimCustomer';

SELECT
    fk.name AS ForeignKeyName,
    OBJECT_NAME(fk.parent_object_id) AS ReferencingTable,
    cpar.name AS ReferencingColumn,
    OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable,
    cref.name AS ReferencedColumn
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id
JOIN sys.columns cpar
    ON cpar.object_id = fkc.parent_object_id
   AND cpar.column_id = fkc.parent_column_id
JOIN sys.columns cref
    ON cref.object_id = fkc.referenced_object_id
   AND cref.column_id = fkc.referenced_column_id
WHERE OBJECT_NAME(fk.referenced_object_id) = @target_table
ORDER BY ReferencingTable, ForeignKeyName;