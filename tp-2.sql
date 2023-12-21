
/***
	Corrections TP 2 - Entonnoir
****/
-- 1
SELECT 
    question_text,
COUNT(user_id) 
FROM survey_data 
GROUP BY question_text 
ORDER BY question_text;

-- 2
SELECT 
    response, 
    COUNT(response) as count 
FROM survey_data 
WHERE question_text ILIKE '2%' 
GROUP BY response 
ORDER BY count DESC;

-- 3
-- 3.1
SELECT response AS age_group, COUNT (response) FROM survey_data WHERE question_text ILIKE '3.%' GROUP BY response ORDER BY response;

-- 3.2
SELECT response AS gender_group, COUNT(response) FROM survey_data WHERE question_text LIKE '4.%' GROUP BY response ORDER BY response;

-- 3.3
SELECT response AS gender_group, COUNT(response) FROM survey_data WHERE question_text LIKE '5.%' GROUP BY response ORDER BY response;

-- 4(1)
SELECT user_id AS uuid,
    CASE    
        WHEN CAST(response as DECIMAL) > 7 THEN 'Promoter'
        ELSE 'Passive'
    END AS nps_segment
    FROM survey_data
    GROUP BY user_id, question_text, response
    HAVING question_text LIKE '1.%'
    ORDER BY user_id;
 
-- 4(2)
SELECT 
    user_id,
CASE
    WHEN response LIKE '9%' OR response LIKE'10%' THEN 'Promoter'
    ELSE 'Passive'
END
AS nps_segment
FROM survey_data
WHERE question_text LIKE '%1%';

-- 4(3)
SELECT user_id,
CASE 
	WHEN CAST(response AS NUMERIC) > 8 THEN 'Promoter'
	ELSE 'Passive'
END
AS nps_segment FROM survey_data WHERE question_text LIKE '1%';

-- 5(1)
SELECT 
    COUNT(CASE
        WHEN response LIKE '9.0' OR response LIKE '10.0' THEN 'Promoter'
    END) * 100 / (SELECT COUNT(response) FROM survey_data WHERE question_text ILIKE '1%')
    AS pourcentage
    FROM survey_data;

-- 5(2)
SELECT DISTINCT
    (SELECT 
     COUNT(user_id) 
     FROM survey_data 
     WHERE response ILIKE '9.0' OR response ILIKE '10.0')
     *100/
     (SELECT 
       COUNT(user_id)
       FROM survey_data 
       WHERE question_text ILIKE '1%') 
       as percentage
FROM survey_data;

-- 5(4)
SELECT
	(COUNT(
            CASE
                WHEN CAST(response AS NUMERIC) > 8 THEN 1 
            END) * 100 / COUNT(*)) AS percentage_promoters
FROM
    survey_data
WHERE
    question_text LIKE '1%';
	

-- 5(5)
ALTER TABLE survey_data ADD COLUMN promoteur2 SMALLINT;
UPDATE survey_data
SET promoteur2 =
CASE
    WHEN response ='9.0' OR response ='10.0' THEN 1
    ELSE 0
END
WHERE question_text = '1. À quel point êtes-vous susceptible de recommander Matelas et Plus à un ami ?';


SELECT SUM(promoteur2)*100/COUNT(DISTINCT(user_id)) FROM survey_data;