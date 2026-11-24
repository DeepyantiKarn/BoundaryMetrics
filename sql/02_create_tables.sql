-- Select database
USE boundarymetrics;

-- Store IPL match information
CREATE TABLE IF NOT EXISTS matches (
    match_id INT PRIMARY KEY,
    date DATE,
    season VARCHAR(20),
    venue VARCHAR(150),
    city VARCHAR(100),
    team1 VARCHAR(100),
    team2 VARCHAR(100),
    toss_winner VARCHAR(100),
    toss_decision VARCHAR(20),
    winner VARCHAR(100)
);

-- Store ball-by-ball delivery information
CREATE TABLE IF NOT EXISTS deliveries (
    delivery_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    match_id INT NOT NULL,
    innings INT,
    over_number INT,
    delivery_number INT,
    batting_team VARCHAR(100),
    batter VARCHAR(100),
    bowler VARCHAR(100),
    runs_batter INT,
    runs_total INT,
    wides INT,
    noballs INT,
    byes INT,
    legbyes INT,
    penalty INT,
    is_legal_delivery BOOLEAN,
    bowler_runs INT,
    balls_faced INT,
    total_wickets INT,
    bowler_wickets INT,

    FOREIGN KEY (match_id) REFERENCES matches(match_id)
);