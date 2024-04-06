DROP PROCEDURE IF EXISTS CreateChampionship;

DELIMITER $$

CREATE PROCEDURE CreateChampionship(
	IN `year` YEAR
) 
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE team_id INT(10) UNSIGNED;
    DECLARE comp_id INT(10) UNSIGNED;
    
    -- get all comps in year
    DECLARE cur CURSOR FOR 
		SELECT DISTINCT distinct t.id
        FROM Teams t
        INNER JOIN Awards_in_Competitions aic ON t.id = aic.teams_id
        INNER JOIN Competitions c ON aic.competitions_id = c.id
        WHERE YEAR(c.start_date) = `year`
        AND aic.Awards_id < 4 
        AND t.id = aic.Teams_id;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    INSERT INTO `robotics`.`Competitions`
	(`Cities_id`,
	`code`,
	`start_date`,
	`end_date`,
	`name`,
	`website`,
	`address`)
	VALUES
	(353747,
	"2024champs",
	NOW(),
	NOW(),
	"The absolute winners",
	NULL,
	"ORT hermlin");
     
    SET comp_id = LAST_INSERT_ID();
    
    OPEN cur;
    
	loopi: LOOP
		FETCH cur INTO team_id;
			
		IF done THEN
			LEAVE loopi;
		END IF;
		
		INSERT INTO Teams_in_Competitions
		(`Competitions_id`,
		`Teams_id`,
		`ranking`)
		VALUES
		(comp_id,
		team_id,
		NULL);
 		
    END LOOP;
    
    CLOSE cur;
END $$

DELIMITER ;

call CreateChampionship(2022);

SELECT * FROM Teams_in_Competitions tic where tic.Competitions_id>6666


