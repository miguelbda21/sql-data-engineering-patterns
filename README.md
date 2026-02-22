# SQL Data Engineering Patterns

This repository contains practical SQL patterns used in data engineering and data warehousing, including incremental loads, CDC-style logic, validation queries, foreign key dependency checks, SCD Type 2, MERGE/UPSERT patterns, and performance tuning examples.

## Why this repo exists
Hiring teams frequently ask for:
- Complex SQL for validation and data mining
- Foreign key dependency evaluation
- Incremental loads / CDC patterns
- Data quality checks and reconciliation

This repo provides reusable examples that can be adapted to SQL Server, Postgres, and other relational systems.

## Contents
- **01_incremental_load**: watermark loads, dedup, late-arriving data
- **02_cdc_patterns**: timestamp-based CDC, change tracking patterns
- **03_data_validation**: row counts, null checks, duplicates, reconciliation
- **04_fk_dependency_checks**: orphan detection, dependency mapping
- **05_scd_type2**: dimension history tracking
- **06_merge_upsert**: upserts with MERGE patterns
- **07_performance_tuning**: indexes, sargability, execution plan tips

## Notes
Examples are written to be easy to read and reuse. Replace table names and keys as needed.
