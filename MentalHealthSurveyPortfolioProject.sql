Select *
From portfolio.mental_health_survey
Order by 1,4;







-- Select data that we are going to be using
-- Looking at mental health data vs phys health data data

Select 
	Timestamp AS 'survey_date', 
    Age, 
    Gender, 
    Country, 
    mental_health_consequence, 
    phys_health_consequence
From 
	portfolio.mental_health_survey
Order by 3,4;







-- Shows people who have wellness program had treatment in the USA
-- Looking at wellness program vs treatment in the USA

Select 
	Timestamp AS 'survey_date', 
    Age, 
    Gender, 
    Country, 
    wellness_program, 
    treatment
From portfolio.mental_health_survey
Where Country Like '%states%' 
	And treatment ='Yes' 
    And wellness_program ='Yes' 
Order by 3,4;







-- Showing countries with highest mental health consequences

Select 
	Country, 
    Count(treatment) AS 'no_cases'
From portfolio.mental_health_survey
Where Country IS NOT NULL 
	And mental_health_consequence ='Yes' 
Group by Country
Order by no_cases DESC;







-- Showing countries with highest physical health consequences

Select 
	Country, 
    Count(treatment) AS 'no_cases'
From portfolio.mental_health_survey
Where Country IS NOT NULL 
	And phys_health_consequence ='Yes' 
Group by Country
Order by no_cases DESC;







-- Showing state in the USA with highest mental health consequences

Select 
	state, 
    Count(treatment) AS 'no_cases'
From portfolio.mental_health_survey
Where Country Like '%states' 
	And mental_health_consequence ='Yes' 
Group by state
Order by no_cases DESC;







-- Showing state in the USA with highest physical health consequences

Select 
	state, 
    Count(treatment) AS 'no_cases'
From 
	portfolio.mental_health_survey
Where Country Like '%states' 
	And phys_health_consequence ='Yes' 
Group by state
Order by no_cases DESC;







-- Looking at age between 40-60 with mental health consequences and physical health consequences

Select 
	Age, 
    Gender, 
    Country, 
    mental_health_consequence, 
    phys_health_consequence
From 
	portfolio.mental_health_survey
Where 
	mental_health_consequence ='Yes' 
	And phys_health_consequence ='Yes' 
	And Age Between 40 And 60
Order by Age;







-- Global case numbers

Select SUM(CASE 
			WHEN treatment = 'Yes' then 1 
            else 0 end) AS 'total_cases'
From portfolio.mental_health_survey
Where treatment = 'Yes';







-- TEMP TABLE

DROP TABLE IF EXISTS TechEmployeeMentalHealth;
Create Table TechEmployeeMentalHealth(
	Timestamp DATE,
    Age INT,
    Gender VARCHAR(255),
    Country VARCHAR (255),
    Mental_Health_Consequence VARCHAR(255),
    Tech_Company VARCHAR(255)
    );
    
Insert Into TechEmployeeMentalHealth (Timestamp, Age, Gender, Country, Mental_Health_Consequence, tech_company)
Select Timestamp, Age, Gender, Country, mental_health_consequence, tech_company 
From portfolio.mental_health_survey
Where tech_company ='Yes';

Show Tables Like 'TechEmployeeMentalHealth';








-- Creating view to store data for later visulations

Create View TechEmployeeMentalHealthView AS
Select 
	Timestamp, 
    Age, 
    Gender, 
    Country, 
    mental_health_consequence, 
    tech_company 
From portfolio.mental_health_survey
Where tech_company ='Yes';


