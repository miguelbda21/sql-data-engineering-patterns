/* Validation: CHECKSUM aggregate comparison (SQL Server)
   Useful when comparing full tables quickly (not perfect, but fast).
*/

SELECT CHECKSUM_AGG(BINARY_CHECKSUM(*)) AS SourceChecksum
FROM dbo.SourceTable;

SELECT CHECKSUM_AGG(BINARY_CHECKSUM(*)) AS TargetChecksum
FROM dbo.TargetTable;