
--- Using select and subqueries
select * from HollywoodStories order by Genre ASC;

select Film, Year, LeadStudio, Genre from HollywoodStories order by LeadStudio asc ;

SELECT Genre, Audiencescore , total (Audiencescore)  AS total_AUDIO FROM HollywoodStories ;


SELECT Genre, Profitability, WorldwideGross, (Profitability/CAST(WorldwideGross as INT) )*100 as Interesting from HollywoodStories order by Genre, Interesting DESC;

----- Looking at highest Profitability 

SELECT Genre,  LeadStudio, max (Profitability) as maxi FROM HollywoodStories GROUP BY Genre, LeadStudio order by 1,2 ;

-- Looking at the best movie
SELECT film, Genre, max(Audiencescore/RottenTomatoes)as the_best from HollywoodStories GROUP BY Genre, Film ORDER BY the_best desc ;


--- highest score provided by audience 
SELECT Genre, max (Audiencescore) as High_score FROM HollywoodStories GROUP BY 	Genre ORDER BY High_score ASC;
-------


SELECT * FROM HollywoodStories  WHERE Audiencescore IS NOT NULL ORDER BY 2;

----- LETS BREAK DOWN BY LeadStudio

SELECT LeadStudio, min (RottenTomatoes) AS checking FROM HollywoodStories GROUP BY LeadStudio ORDER BY checking DESC;

-- The most pofitable genre 

SELECT Genre, sum (Profitability) as sumup FROM HollywoodStories GROUP by Genre ORDER by sumup DESC;

----------
SELECT year, sum (Profitability)  as total_prof, sum(cast(WorldwideGross as INT)) as total_gross from HollywoodStories
GROUP BY year ORDER BY 1,2 ;

--- JOIN 
SELECT * from HollywoodStories as part JOIN Hollywood as other ON part.genre = other.genre  ;

SELECT part.genre, part.film, other.leadstudio from HollywoodStories as part JOIN Hollywood as other ON part.genre = other.genre  order by 1,2,3 ;

--- PARTITION by
SELECT part.genre, part.film, other.leadstudio, count(part.genre) over (PARTITION BY part.genre) as total_genre from HollywoodStories as part 
JOIN Hollywood as other ON part.genre = other.genre  order by 1,2,3 ;

---- USINFG VIEW

DROP VIEW MAYBE ;

CREATE TEMPORARY VIEW MAYBE AS 
SELECT 
	genre, film, Profitability, leadstudio, audiencescore, count (leadstudio) 
	over (PARTITION BY leadstudio)  as overall_lead,	
	avg (audiencescore) over (PARTITION BY audiencescore)  as AVG_audienscore 
FROM HollywoodStories 
---JOIN Hollywood on HollywoodStories.LeadStudio = Hollywood.leadstudio 

SELECT * FROM MAYBE ;


-- TEMP TABLE

DROP TABLE IF EXISTS TEMP_HOLLY ;

CREATE TEMPORARY TABLE TEMP_HOLLY (genre TEXT, 
film TEXT,
Profitability TEXT,
leadstudio TEXT,
audiencescore INT
) ;
INSERT INTO TEMP_HOLLY SELECT GENRE, film, Profitability, leadstudio, audiencescore FROM HollywoodStories ;

SELECT * FROM TEMP_HOLLY ;


