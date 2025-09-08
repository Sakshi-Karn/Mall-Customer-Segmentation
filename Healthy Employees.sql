--Create a join table
select * from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r 
on a.Reason_for_absence = r.Number;

--- Find the healthiest employee for the bonus
select * from Absenteeism_at_work 
where Social_drinker = 0 AND Social_smoker=0
AND Body_mass_index < 25 
and  Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work);

--- compensation rate increase for non-smokers / budget $983,221 so .68 increase per hour /1,414.4 per year
select count(*) from Absenteeism_at_work as nonsmokers
where Social_smoker = 0;

--optimize this query
select
a.ID,
r.Reason,
Body_mass_index,
Month_of_absence,
CASE WHEN Body_mass_index < 18.5 then 'Underweight'
     WHEN Body_mass_index between 18.5 and 24.9 then 'HealthyWeight'
     WHEN Body_mass_index between 25 and 30 then 'Overweight'
     WHEN Body_mass_index > 18.5 then 'Obese'
     Else 'Unknown' END as BMI_category,
CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
     WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
     WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
     WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
     ELSE 'Unknown' END as Season_Names,
Month_of_absence,
Day_of_the_week,
Seasons,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r 
on a.Reason_for_absence = r.Number;