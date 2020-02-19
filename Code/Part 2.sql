

\* Question 1: How many users completed an exercise in their first month per monthly cohort */

SELECT months,

(COUNT(DISTINCT CASE
 WHEN same_month > 0 THEN user_id 
 END) / COUNT(DISTINCT user_id))*100.0 AS initial_completion_percent_same_month 
 
 FROM(
 
 SELECT exercises.user_id,MONTH(exercise_completion_date) AS months,
 SUM(CASE
  WHEN MONTH(exercise_completion_date)=MONTH(created_at) THEN 1 
  ELSE 0 
  END )AS same_month
 FROM users AS u
 LEFT JOIN exercises ON u.user_id=exercises.user_id 
 WHERE exercise_completion_date IS NOT NULL 
 GROUP BY MONTH(created_at),user_id

 ) AS a
 GROUP BY months

# ‘’Question 2: finds the top five organizations that have the highest average phq9 score per patient.‘’

SELECT p.organization_name,AVG(score),COUNT(score) AS num_patients FROM providers p
JOIN phq9 pro 
ON  p.provider_id=pro.provider_id
GROUP BY organization_name ORDER BY AVG(score) DESC LIMIT 0,5

