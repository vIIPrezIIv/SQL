USE playerstickets;

INSERT INTO city VALUES
	(NULL, 'Toronto', 'ON'),
    (NULL, 'Vancouver', 'BC'),
    (NULL, 'Quebec City', 'QC'),
    (NULL, 'Winnipeg', 'MB');
	
INSERT INTO league VALUES
	(1, 'NBA'),
	(2, 'MLB'),
	(3, 'NHL'),
	(4, 'MLA'),
	(5, 'OHL');
    
INSERT INTO teams VALUES
	(NULL, 'Pats', 1),
    (NULL, 'Downloads', 2),
    (NULL, 'Chretien', 3),
    (NULL, 'Jets', 4);
    
INSERT INTO fans VALUES
	(NULL, 'Ray Ortelli', '123 SuperVille', '8888672423', 1),
    (NULL, 'Graham Berry', '6323 Toronto Ave.', '5672358544', 1), 
    (NULL, 'Andrew Maple', '76 Nope St.', '3218562345', 1),
    (NULL, 'Quin Stark', '8945 Sollicitudin Road', '4041718668', 2),
    (NULL, 'Kibo Marquez', 'Ap #651-801 Egestas Road', '7896778064', 2),
    (NULL, 'Beck Hicks', '177-2513 Luctus Rd.', '5093480237', 2),
    (NULL, 'Alan Valentine', 'Ap #909-2691 Eget', '3123378160', 3),
    (NULL, 'Blaze Glass', 'P.O. Box 794, 4586 St.', '5805279806', 3),
    (NULL, 'Kelly Snider', 'Ap #867-2592 Aliquam', '7147602093', 3),
    (NULL, 'Jonas Wilkerson', '531 Natoque Rd.', '3522449691', 4),
    (NULL, 'Tanek Wright', 'Ap #492-5494 Erat', '9098083743', 4),
    (NULL, 'Hu Farley', '6104 Id, Rd.', '3224208717', 4);
    
INSERT INTO game VALUES
	(NULL, 1, 2),
    (NULL, 1, 3),
    (NULL, 1, 4),
    (NULL, 2, 1),
    (NULL, 2, 3),
    (NULL, 2, 4),
    (NULL, 3, 1),
    (NULL, 3, 2),
    (NULL, 3, 4),
    (NULL, 4, 1),
    (NULL, 4, 2),
    (NULL, 4, 3);

INSERT INTO players VALUES
	(NULL, 'Ray', 'Ben', true, 1),
    (NULL, 'Odysseus', 'Yates', NULL, 1),
    (NULL, 'Addison', 'Aguilar', NULL, 1),
    (NULL, 'Hiram', 'Lynch', NULL, 1),
    (NULL, 'Herman', 'Jefferson', NULL, 1),
    (NULL, 'Fletcher', 'Young', true, 2),
    (NULL, 'Eric', 'Merrill', NULL, 2),
    (NULL, 'Dante', 'Cline', NULL, 2),
    (NULL, 'Nathaniel', 'Pratt', NULL, 2),
    (NULL, 'Cooper', 'Fowler', NULL, 2),
    (NULL, 'Clayton', 'Crane', true, 3),
    (NULL, 'Cain', 'King', NULL, 3),
    (NULL, 'Emerson', 'Russo', NULL, 3),
    (NULL, 'Rigel', 'Hull', NULL, 3),
    (NULL, 'Christopher', 'Head', NULL, 3),
    (NULL, 'Levi', 'Nicholson', true, 4),
    (NULL, 'Bevis', 'Kent', NULL, 4),
    (NULL, 'Vladimir', 'Fuller', NULL, 4),
    (NULL, 'Neil', 'Weber', NULL, 4),
    (NULL, 'Keefe', 'Barnes', NULL, 4);
    
INSERT INTO sweater VALUES
	(NULL, 1, 1, 1),
	(NULL, 2, 2, 1),
	(NULL, 3, 3, 1),
	(NULL, 4, 4, 1),
	(NULL, 5, 5, 1),
	(NULL, 1, 6, 2),
	(NULL, 2, 7, 2),
	(NULL, 3, 8, 2),
	(NULL, 4, 9, 2),
	(NULL, 5, 10, 2),
	(NULL, 1, 11, 3),
	(NULL, 2, 12, 3),
	(NULL, 3, 13, 3),
	(NULL, 4, 14, 3),
	(NULL, 5, 15, 3),
	(NULL, 1, 16, 4),
	(NULL, 2, 17, 4),
	(NULL, 3, 18, 4),
	(NULL, 4, 19, 4),
	(NULL, 5, 20, 4);
	
INSERT INTO scorers VALUES
	(23, 1, 1),
	(24, 2, 5),
	(12, 3, 4),
	(31, 4, 14),
	(40, 5, 16),
	(32, 6, 9),
	(2, 7, 10),
	(56, 8, 11),
	(15, 9, 13),
	(8, 10, 18),
	(9, 11, 20),
	(23, 12, 19);
	
INSERT INTO tickets VALUES
	(NULL, '2001-09-01 12:12:00', 1),
	(NULL, '2001-09-02 12:12:00', 2),
	(NULL, '2001-09-03 12:12:00', 3),
    (NULL, '2001-09-04 12:12:00', 4),
    (NULL, '2001-09-05 12:12:00', 5),
    (NULL, '2001-09-08 12:12:00', 6),
    (NULL, '2001-10-12 12:12:00', 7),
    (NULL, '2001-10-14 12:12:00', 8),
    (NULL, '2001-10-15 12:12:00', 9),
    (NULL, '2001-10-16 12:12:00', 10),
    (NULL, '2001-10-17 12:12:00', 11),
    (NULL, '2001-10-20 12:12:00', 12);
	
INSERT INTO stadium VALUES
	(1, 'New Market Stadium', 300, 1, 1),
    (2, 'Rogers Stadium', 350, 2, 2),
    (3, 'Pootang Stadium', 620, 3, 3),
    (4, 'MTS Centre', 280, 4, 4);

	