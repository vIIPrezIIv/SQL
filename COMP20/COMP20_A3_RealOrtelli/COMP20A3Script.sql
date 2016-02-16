DROP DATABASE IF EXISTS COMP20A3;
CREATE DATABASE COMP20A3;
USE COMP20A3;

DROP TABLE IF EXISTS tournament;
DROP TABLE IF EXISTS fantickets;
DROP TABLE IF EXISTS fan;
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS team;
     
CREATE TABLE team 
(
     TeamId      INT AUTO_INCREMENT PRIMARY KEY ,
     TeamName    varchar(20) NOT NULL, 
     Points      INT DEFAULT 0
 );
 

 CREATE TABLE  game
 (
     GameId        INT PRIMARY KEY AUTO_INCREMENT,
     GameDate    DATE,
     HomeTeamId  INT     NOT NULL,
     AwayTeamId INT      NOT NULL,
     FanTicketsSold INT,      
     GroupTicketsSold INT,
     GeneralTicketsSold INT,
     TicketPrice INT,
     FOREIGN KEY(HomeTeamId) references team(TeamId),
     FOREIGN KEY(AwayTeamId) references team(TeamId)
 );
 

 CREATE TABLE ticket
 (
     TicketId   INT PRIMARY KEY AUTO_INCREMENT,
     GameId  INT,
     TicketType Enum("General", "Fan", "Group"),
     FOREIGN KEY(GameId) references game(GameId)
 );

 

 CREATE TABLE fan
 (
     FanId INT PRIMARY KEY AUTO_INCREMENT,
     FanName VARCHAR(40),
     TeamId INT,
     FOREIGN KEY (TeamId) references team(TeamId)
 );
 


 CREATE TABLE fanTickets
 (
     FanId INT,
     GameId INT,
     TicketsBought INT,
      PRIMARY KEY (FanId,GameId),
      FOREIGN KEY (FanId )references fan(FanId),
      FOREIGN KEY (GameId) references game(GameId)
 );


CREATE TABLE Tournament
(
    TournamentName VARCHAR(30), 
    GameId INT,
    PRIMARY KEY (TournamentName,GameId),
    FOREIGN KEY (GameId) REFERENCES Game(GameId)
);


# Insert data into team table.
# Change the final entry (points) for testing purposes

INSERT INTO TEAM VALUES (NULL,'Team 1',24); 
INSERT INTO TEAM VALUES (NULL,'Team 2',46); 
INSERT INTO TEAM VALUES (NULL,'Team 3',16); 
INSERT INTO TEAM VALUES (NULL,'Team 4',45); 
INSERT INTO TEAM VALUES (NULL,'Team 5',40); 
INSERT INTO TEAM VALUES (NULL,'Team 6',35); 
INSERT INTO TEAM VALUES (NULL,'Team 7',20); 
INSERT INTO TEAM VALUES (NULL,'Team 8',10);
