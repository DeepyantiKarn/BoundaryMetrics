-- Select database
USE boundarymetrics;

-- Total matches
SELECT COUNT(*) AS total_matches
FROM matches;

-- Total deliveries
SELECT COUNT(*) AS total_deliveries
FROM deliveries;

-- Check missing values
SELECT
    COUNT(*) AS total_rows,
    SUM(match_id IS NULL) AS missing_match_id,
    SUM(batter IS NULL) AS missing_batter,
    SUM(bowler IS NULL) AS missing_bowler,
    SUM(runs_total IS NULL) AS missing_runs
FROM deliveries;

-- Validate run totals
SELECT
    SUM(runs_batter) AS batter_runs,
    SUM(runs_total) AS total_runs,
    SUM(bowler_runs) AS bowler_runs
FROM deliveries;

-- Check duplicate deliveries
SELECT
    COUNT(*) - COUNT(DISTINCT
        CONCAT(match_id, '-', innings, '-', over_number, '-', delivery_number)
    ) AS duplicate_deliveries
FROM deliveries;

-- Check unmatched delivery records
SELECT COUNT(*) AS unmatched_deliveries
FROM deliveries d
LEFT JOIN matches m
    ON d.match_id = m.match_id
WHERE m.match_id IS NULL;