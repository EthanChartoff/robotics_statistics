-- -------------------------
-- Ethen Raphael Chartoff
-- SQL FINAL PROJECT
-- 
-- Constraints 
-- -------------------------

-- -------------------------	
-- Constraints
-- -------------------------	

-- Checks if rookie_year is more then 1991, because the first team was created in 1992.
ALTER TABLE Teams
ADD CONSTRAINT check_rookie_year 
CHECK (rookie_year > 1991);

-- Check if each team in match is different. Can't have one team in one match twice.
ALTER TABLE Matches_has_Teams
ADD CONSTRAINT unique_team_in_same_match
UNIQUE (matches_id, teams_id, groups_id);

-- Check if each team in same comp is different.
ALTER TABLE Teams_in_Competitions
ADD CONSTRAINT unique_team_in_same_competition 
UNIQUE (competitions_id, teams_id);






