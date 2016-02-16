USE COMP20A3;

DROP PROCEDURE IF EXISTS createGame;
DROP PROCEDURE IF EXISTS createTournament;
DROP PROCEDURE IF EXISTS showTournament;
DROP FUNCTION IF EXISTS sellTicket;

DELIMITER //
CREATE PROCEDURE createGame(HomeTeamName VARCHAR(20),  AwayTeamName VARCHAR(20), date DATE) 
BEGIN

DECLARE sqlError TINYINT DEFAULT FALSE; 
DECLARE awayTeamIdR INT;
DECLARE homeTeamIdR INT;
DECLARE gameResult INT;
DECLARE gameResultDuplicate INT;
DECLARE dateResult DATE;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	SET sqlError = TRUE;
    
DECLARE EXIT HANDLER FOR 1062 
	SELECT 'Attempt To Store Duplicate Key Value';

DECLARE EXIT HANDLER FOR 1216
	SELECT 'attempts to add or update a child row but can’t because of a foreign key constraint';

DECLARE EXIT HANDLER FOR 1217
	SELECT 'Attempted to delete or update a parent row but can’t because of a foreign key constraint';

DECLARE EXIT HANDLER FOR 1048
	SELECT 'Attempted to insert null value into a column that doesn’t accept null value';
    
DECLARE EXIT HANDLER FOR 2031
	SELECT 'No data supplied for parameters in prepared statement';
    
DECLARE EXIT HANDLER FOR 2032
	SELECT 'Data truncated';
 
START TRANSACTION;
 
SET homeTeamIdR = (SELECT TeamId FROM team WHERE TeamName = HomeTeamName);
SET awayTeamIdR = (SELECT TeamId FROM team WHERE TeamName = AwayTeamName);
 
SET gameResult = (SELECT GameId FROM game WHERE homeTeamIdR = HomeTeamId AND awayTeamIdR = AwayTeamId AND date = GameDate);
 
SET gameResultDuplicate = (SELECT GameId FROM game WHERE awayTeamIdR = HomeTeamId AND homeTeamIdR = AwayTeamId AND date = GameDate);
 
SET dateResult = (SELECT GameDate FROM game WHERE date = GameDate);
 
IF (dateResult IS NULL) THEN 
	IF (gameResult IS NULL && gameResultDuplicate IS NULL) THEN
		INSERT INTO game VALUES (NULL, date, homeTeamIdR, awayTeamIdR, 0, 0, 0, 0);
	else
		SET sqlError = TRUE;
	END IF;
else
	SET sqlError = TRUE;
END IF;

IF sqlError = FALSE THEN
	COMMIT;
    SELECT "Game Added";
else
	ROLLBACK;
    SELECT "Game Wasn't Added";
END IF;
 
END//

CREATE FUNCTION sellTicket(HowMany INT, TicketType VARCHAR(10), GameId INT)
RETURNS INT
BEGIN

DECLARE sqlError TINYINT DEFAULT FALSE;
DECLARE price INT;
DECLARE discount INT;
DECLARE count INT DEFAULT 0;
DECLARE total INT;
DECLARE generalAmount INT;
DECLARE fanAmount INT;
DECLARE groupAmount INT;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	SET sqlError = TRUE;
 
IF (TicketType = 'General' && HowMany >= 1 && HowMany <= 2) THEN

	SET generalAmount = (SELECT GeneralTicketsSold FROM game WHERE game.GameId = GameId);
	UPDATE game SET GeneralTicketsSold = HowMany + generalAmount WHERE game.GameId = GameId;
	SET price = (SELECT TicketPrice FROM game WHERE game.GameId = GameId);
    
ELSEIF (TicketType = 'Fan' && HowMany >= 1 && HowMany <= 4) THEN

	SET fanAmount = (SELECT FanTicketsSold FROM game WHERE game.GameId = GameId);
	UPDATE game SET FanTicketsSold = HowMany + fanAmount WHERE game.GameId = GameId;
	SET price = (SELECT TicketPrice FROM game WHERE game.GameId = GameId);
	SET discount = price * 0.25;
	SET price = price - discount;
    
ELSEIF (TicketType = 'Group' && HowMany >= 3 && HowMany <= 10) THEN
     
	SET groupAmount = (SELECT GroupTicketsSold FROM game WHERE game.GameId = GameId);
	UPDATE game SET GroupTicketsSold = HowMany + groupAmount WHERE game.GameId = GameId;
	SET price = (SELECT TicketPrice FROM game WHERE game.GameId = GameId);
	SET discount = price * 0.10;
	SET price = price - discount;
            
ELSE 
				
	SET sqlError = TRUE;
            
END IF;


IF sqlError = FALSE THEN 

    WHILE (count < HowMany) DO
		INSERT INTO ticket VALUES (NULL, GameId, TicketType);
		SET count = count + 1;
	END WHILE;
    
    SET total = (price * HowMany);
    
ELSE
	
    SET total = 0;
    
END IF;

RETURN total;

END//

CREATE PROCEDURE createTournament(TournamentName VARCHAR(30), NumberOfTeams INT, StartDate DATE, TicketPrice INT)
BEGIN

DECLARE sqlError TINYINT DEFAULT FALSE;
DECLARE results VARCHAR(20);
DECLARE resultsTwo VARCHAR(20);
DECLARE count INT DEFAULT 0;
DECLARE halfTeams INT DEFAULT NumberOfTeams / 2;
DECLARE gameDate DATE;
DECLARE tournamentResult INT;
DECLARE ticketIdResult INT;
DECLARE counter INT DEFAULT NumberOfTeams;
DECLARE validTeams INT DEFAULT NumberOfTeams mod 2;
DECLARE maxAmountTeams INT DEFAULT (SELECT COUNT(TeamId) FROM team);

DECLARE cursorName CURSOR FOR SELECT TeamName FROM team ORDER BY Points DESC LIMIT halfTeams;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	SET sqlError = TRUE;
    
DECLARE EXIT HANDLER FOR 1062 
	SELECT 'Attempt To Store Duplicate Key Value';
    
DECLARE EXIT HANDLER FOR 1329
	SELECT 'Fetch From Non-Existent';
    
DECLARE EXIT HANDLER FOR 1048
	SELECT 'Attempted to insert null value into a column that doesn’t accept null value';
    
DECLARE EXIT HANDLER FOR 1217
	SELECT 'Attempted to delete or update a parent row but can’t because of a foreign key constraint';
    
DECLARE EXIT HANDLER FOR 1216
	SELECT 'attempts to add or update a child row but can’t because of a foreign key constraint';
    
DECLARE EXIT HANDLER FOR 2031
	SELECT 'No data supplied for parameters in prepared statement';
    
DECLARE EXIT HANDLER FOR 2032
	SELECT 'Data truncated';
    
START TRANSACTION;

IF (NumberOfTeams <= maxAmountTeams) THEN

	IF (validTeams = 0) THEN
    
		SET gameDate = StartDate;

		OPEN cursorName;
    
		WHILE (count < halfTeams) DO

			FETCH cursorName INTO results;

			SET counter = counter - 1;

			IF (count < 1) then
				Call createGame(results, (SELECT TeamName FROM team ORDER BY Points DESC LIMIT counter, 1), StartDate); 
			ELSE
				Call createGame(results, (SELECT TeamName FROM team ORDER BY Points DESC LIMIT counter, 1), gameDate);
			END IF;
    
			SET tournamentResult = (SELECT COUNT(*) FROM tournament) + 1;
    
			INSERT INTO tournament VALUES (TournamentName, tournamentResult); 
    
			UPDATE game SET game.TicketPrice = TicketPrice WHERE game.GameId = LAST_INSERT_ID();
    
			SET gameDate = gameDate + INTERVAL 1 DAY;
			SET count = count + 1;
    
		END WHILE;

		CLOSE cursorName;

	else

		SET sqlError = TRUE;
		SELECT "Not Even Amount Of Teams";
    
	END IF;
else

	SET sqlError = TRUE;
	SELECT "There Is Not Enough Teams To Make A Tournament Of That Amount";
    
END IF;

IF sqlError = FALSE THEN
	COMMIT;
    SELECT "Tournament Created";
else
	ROLLBACK;
    SELECT "Tournament Not Created";
END IF;

END//

CREATE PROCEDURE showTournament(TournamentName VARCHAR(30))
BEGIN

SELECT g.TournamentName AS 'Tournament Name', l.TeamName AS 'Home Team', c.TeamName AS 'Away Team', f.GameDate AS 'Game Date', f.TicketPrice AS 'Ticket Price'
FROM tournament g
INNER JOIN game f
ON g.GameId = f.GameId
INNER JOIN team l
ON f.HomeTeamId = l.TeamId
INNER JOIN team c
ON f.AwayTeamId = c.TeamId
WHERE g.TournamentName = TournamentName
ORDER BY f.GameDate;

END //

DELIMITER ;

/*
SET gameResult = (SELECT GameId FROM game WHERE homeTeamIdR = HomeTeamId AND awayTeamIdR = AwayTeamId);
 
SET dateResult = (SELECT GameDate FROM game WHERE date = GameDate);
 
IF (gameResult IS NULL AND dateResult IS NULL) THEN
	INSERT INTO game VALUES (NULL, date, homeTeamIdR, awayTeamIdR, 0, 0, 0, 0);
else
	SET sqlError = TRUE;
END IF;*/