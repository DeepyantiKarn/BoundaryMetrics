USE boundarymetrics;


-- 1. Total runs by team
SELECT
    batting_team,
    SUM(runs_total) AS total_runs
FROM deliveries
GROUP BY batting_team
ORDER BY total_runs DESC;


-- 2. Top 10 run-scoring batters
SELECT
    batter,
    SUM(runs_batter) AS total_runs
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;


-- 3. Wickets lost by each team
SELECT
    batting_team,
    SUM(total_wickets) AS wickets_lost
FROM deliveries
GROUP BY batting_team
ORDER BY wickets_lost DESC;


-- 4. Top 10 wicket-taking bowlers
SELECT
    bowler,
    SUM(bowler_wickets) AS total_wickets
FROM deliveries
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;


-- 5. Team-wise win percentage
SELECT
    team,
    COUNT(*) AS matches_played,
    SUM(won) AS matches_won,
    ROUND(SUM(won) * 100.0 / COUNT(*), 2) AS win_percentage
FROM (
    SELECT
        team1 AS team,
        winner = team1 AS won
    FROM matches

    UNION ALL

    SELECT
        team2 AS team,
        winner = team2 AS won
    FROM matches
) AS team_results
WHERE team IS NOT NULL
GROUP BY team
ORDER BY win_percentage DESC;


-- 6. Season-wise scoring analysis
SELECT
    m.season,
    SUM(d.runs_total) AS total_runs,
    COUNT(DISTINCT d.match_id) AS total_matches,
    ROUND(
        SUM(d.runs_total) / COUNT(DISTINCT d.match_id),
        2
    ) AS average_runs_per_match
FROM deliveries d
JOIN matches m
    ON d.match_id = m.match_id
GROUP BY m.season
ORDER BY MIN(m.date);


-- 7. Toss impact on match results
SELECT
    toss_decision,
    COUNT(*) AS total_matches,
    SUM(toss_winner = winner) AS matches_won_after_toss,
    ROUND(
        SUM(toss_winner = winner) * 100.0 / COUNT(*),
        2
    ) AS toss_winner_win_percentage
FROM matches
WHERE winner IS NOT NULL
GROUP BY toss_decision;


-- 8. Top 10 venues by total runs
SELECT
    m.venue,
    COUNT(DISTINCT d.match_id) AS matches_played,
    SUM(d.runs_total) AS total_runs,
    ROUND(
        SUM(d.runs_total) / COUNT(DISTINCT d.match_id),
        2
    ) AS average_runs_per_match
FROM deliveries d
JOIN matches m
    ON d.match_id = m.match_id
GROUP BY m.venue
ORDER BY total_runs DESC
LIMIT 10;


-- 9. Top 10 venues by average runs
SELECT
    m.venue,
    ROUND(
        SUM(d.runs_total) / COUNT(DISTINCT d.match_id),
        2
    ) AS avg_runs
FROM deliveries d
JOIN matches m
    ON d.match_id = m.match_id
GROUP BY m.venue
HAVING COUNT(DISTINCT d.match_id) >= 10
ORDER BY avg_runs DESC
LIMIT 10;


-- 10. Highest team scores
SELECT
    batting_team,
    match_id,
    innings,
    SUM(runs_total) AS total_score
FROM deliveries
GROUP BY batting_team, match_id, innings
ORDER BY total_score DESC
LIMIT 10;


-- 11. Monthly match distribution
SELECT
    MONTHNAME(date) AS month,
    COUNT(*) AS total_matches
FROM matches
GROUP BY MONTH(date), MONTHNAME(date)
ORDER BY MONTH(date);


-- 12. Top 10 batters by strike rate
-- Minimum 500 balls faced
SELECT
    batter,
    SUM(runs_batter) AS total_runs,
    SUM(balls_faced) AS balls_faced,
    ROUND(
        SUM(runs_batter) * 100.0 / SUM(balls_faced),
        2
    ) AS strike_rate
FROM deliveries
GROUP BY batter
HAVING SUM(balls_faced) >= 500
ORDER BY strike_rate DESC
LIMIT 10;


-- 13. Top 10 bowlers by economy
-- Minimum 300 legal balls
SELECT
    bowler,
    SUM(bowler_runs) AS runs_conceded,
    SUM(is_legal_delivery) AS legal_balls,
    ROUND(
        SUM(bowler_runs) * 6.0 / SUM(is_legal_delivery),
        2
    ) AS economy
FROM deliveries
GROUP BY bowler
HAVING SUM(is_legal_delivery) >= 300
ORDER BY economy ASC
LIMIT 10;


-- 14. Top 5 run scorers in each IPL season
-- Window function: DENSE_RANK()

WITH player_season_runs AS (
    SELECT
        m.season,
        d.batter,
        SUM(d.runs_batter) AS total_runs
    FROM deliveries d
    JOIN matches m
        ON d.match_id = m.match_id
    GROUP BY m.season, d.batter
),
ranked_players AS (
    SELECT
        season,
        batter,
        total_runs,
        DENSE_RANK() OVER (
            PARTITION BY season
            ORDER BY total_runs DESC
        ) AS player_rank
    FROM player_season_runs
)
SELECT *
FROM ranked_players
WHERE player_rank <= 5
ORDER BY season, player_rank;