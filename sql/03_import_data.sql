-- Select database
USE boundarymetrics;

-- Import match data
LOAD DATA LOCAL INFILE '../data/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(match_id, date, season, venue, city, team1, team2,
 toss_winner, toss_decision, winner);

-- Import ball-by-ball data
LOAD DATA LOCAL INFILE '../data/deliveries_mysql.csv'
INTO TABLE deliveries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(match_id, innings, over_number, delivery_number,
 batting_team, batter, bowler,
 runs_batter, runs_total, wides, noballs,
 byes, legbyes, penalty, is_legal_delivery,
 bowler_runs, balls_faced, total_wickets, bowler_wickets);
