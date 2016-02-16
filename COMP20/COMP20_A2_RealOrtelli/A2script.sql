USE playerstickets;

CREATE OR REPLACE VIEW teamPlayers AS
SELECT t.teamName AS 'Team', CONCAT(p.firstName, ' ', p.lastName) AS 'Player Name'
FROM teams t
INNER JOIN players p
ON t.team_id = p.team_id
ORDER BY t.teamName;

CREATE OR REPLACE VIEW teamCaptains AS
SELECT t.teamName AS 'Team', CONCAT(p.firstName, ' ', p.lastName) AS 'Captain'
FROM teams t
INNER JOIN players p
ON t.team_id = p.team_id
WHERE p.captain = true
ORDER BY t.teamName;

CREATE OR REPLACE VIEW gamesScheduled AS
SELECT t.teamName AS 'Home Team', u.teamName AS 'Away Team', x.gameDate AS 'Game Date', v.stadiumName AS 'Arena', l.city AS 'City', l.state_province AS 'Province'
FROM game h
INNER JOIN teams t
ON h.homeTeam = t.team_id
INNER JOIN teams u
ON h.awayTeam = u.team_id
INNER JOIN stadium v
ON t.team_id = v.stadium_id
INNER JOIN city l
ON t.team_id = l.city_id
INNER JOIN tickets x
ON h.game_id = x.game_game_id
ORDER BY x.gameDate;

CREATE OR REPLACE VIEW scores AS
SELECT CONCAT(p.firstName, ' ',p.lastName) AS 'Name', s.scoreAmount AS 'Score'
FROM players p 
INNER JOIN scorers s
ON p.player_id = s.players_player_id
GROUP BY s.scoreAmount DESC
LIMIT 5;

/*UPDATE players
SET team_id = 2
WHERE player_id = 1*/

/*UPDATE players
SET captain = true
WHERE player_id = 7*/

/*UPDATE sweater
SET sweater_number = 1
WHERE players_player_id = 2*/

