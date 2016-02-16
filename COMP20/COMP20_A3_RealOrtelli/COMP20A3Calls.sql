USE COMP20A3;

Call createTournament('Kingston Cup', 8, '2001-01-01', 30);
SELECT sellTicket(5, 'Group', 1);

SELECT * FROM game;
SELECT * FROM tournament;
SELECT * FROM ticket;

Call showTournament('Kingston Cup');


