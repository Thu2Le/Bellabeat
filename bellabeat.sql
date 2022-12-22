-- Creating a database "bellabeat" 
CREATE DATABASE IF NOT EXISTS bellabeat;

USE bellabeat; 

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT *
FROM daily_activity;

-- How many users are there?
SELECT COUNT(DISTINCT Id) AS num_of_user
FROM daily_activity;

SELECT COUNT(DISTINCT Id) AS num_of_user
FROM daily_calories; 

SELECT COUNT(DISTINCT Id) AS num_of_user
FROM daily_steps; 

SELECT COUNT(DISTINCT Id) AS num_of_user
FROM sleep_day; 

SELECT COUNT(DISTINCT Id) AS num_of_user
FROM weight_log; 

-- What is the minimum, maximum, and average steps and calories of unique users?
SELECT 
	DISTINCT Id,
    MIN(TotalSteps) AS min_total_steps,
    MAX(TotalSteps) AS max_total_steps,
    AVG(TotalSteps) AS avg_total_steps,
    MIN(Calories) as min_calories,
    MAX(Calories) AS max_calories,
    AVG(Calories) AS avg_calories
FROM daily_activity
GROUP BY Id
ORDER BY Id;

-- The results was exported as a CSV file named "activity_level_calories.csv". 
 
-- Does taking more steps correlates to higher calories consume? 
SELECT 
	DISTINCT da.Id,
    AVG(TotalSteps) AS avg_total_steps,
    AVG(TotalDistance) AS avg_total_distance,
    AVG(dc.Calories) AS avg_calories
FROM
	daily_activity da
		LEFT JOIN 
	daily_calories dc ON da.Id = dc.Id
GROUP BY da.Id
ORDER BY da.Id;

-- The results was exported as CSV file, "Avg_Steps vs Avg_Calories.csv"
-- I realized I don't really need to export it because daily_activity contains the needed information. 

-- Does taking more steps correlates to longer sleep? 
-- How many users logged their sleep? And which members didn't logged their sleep?
SELECT COUNT(DISTINCT Id) AS num_of_user
FROM sleep_day;

SELECT *
FROM sleep_day;
    
SELECT 
	DISTINCT ds.Id,
    AVG(ds.StepTotal) AS avg_steps,
    AVG(sd.TotalMinutesAsleep) AS avg_minutes_asleep 
FROM 
	daily_steps ds
		LEFT JOIN
	sleep_day sd ON ds.Id = sd.Id
GROUP BY ds.Id
ORDER BY ds.Id;

-- The results of the above query was exported as a CSV file, "sleep_logged.csv".

SELECT 
	DISTINCT ds.Id,
    AVG(ds.StepTotal) AS avg_steps,
    AVG(sd.TotalMinutesAsleep) AS avg_minutes_asleep 
FROM 
	daily_steps ds
		LEFT JOIN
	sleep_day sd ON ds.Id = sd.Id
GROUP BY ds.Id
HAVING avg_minutes_asleep IS NULL
ORDER BY ds.Id;

-- The result of the query above was exported as a CSV file, "null_sleep_logged.csv". 

-- Weekday daily activity?
SELECT 
	DISTINCT DAYNAME(ActivityDate) AS day_of_week,
    AVG(TotalSteps) AS avg_total_steps,
    AVG(Calories) AS avg_calories
FROM daily_activity
GROUP BY day_of_week
ORDER BY day_of_week;

SELECT 
    DISTINCT DATE_FORMAT(ActivityDate, '%W') AS day_of_week,
    AVG(TotalSteps) AS avg_total_steps,
    AVG(Calories) AS avg_calories
FROM daily_activity
GROUP BY day_of_week
ORDER BY day_of_week;

SELECT 
	DISTINCT WEEKDAY(ActivityDate) AS day_of_week,
    AVG(TotalSteps) AS avg_total_steps,
    AVG(Calories) AS avg_calories
FROM daily_activity
GROUP BY day_of_week
ORDER BY day_of_week;

-- The queries in the section above about weekday was not helpful. Couldn't figure out the null results.
-- Aggregation and manipulation was performed in RStudio. 



