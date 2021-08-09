--querying the needed data from the covDeath dataset
Select location, date, total_cases, new_cases,total_deaths, population
FROM portfolio..coviddeath$
ORDER BY 1,2

-- Exploring data the dataset 


-- total_cases to total_death
--- this shows the probability of dying from covid in Nigeria
Select location, date,
total_cases, total_deaths,
(cast(total_deaths AS int)/total_cases)* 100 AS percentageDeath
FROM portfolio..coviddeath$
WHERE location = 'Nigeria'
ORDER BY 1,2


-- total_cases to Population
Select location, convert(varchar(11),date,110) as date, population,
total_cases, 
(total_cases/population)* 100 AS percentagePeopleInfection
FROM portfolio..coviddeath$
WHERE location = 'Nigeria' AND continent is not null
ORDER BY 1,2


--Highest infected African countries  compare to population
Select location, population,
Max(total_cases) AS HighestInfectionCount, 
Max((total_cases/population))* 100 AS percentagePeopleInfected
FROM portfolio..coviddeath$
WHERE continent is not null
AND continent = 'Africa'
GROUP BY location, population
ORDER BY percentagePeopleInfected DESC

-- Highest African countries death count per population
Select location,population, 
Max(cast(total_deaths AS int)) AS HighestDeathCount
FROM portfolio..coviddeath$
WHERE continent is not null
AND continent = 'Africa'
GROUP BY location, population
ORDER BY HighestDeathCount DESC

-- Highest infected countries compare to population 
Select location, population,
Max(total_cases) AS HighestInfectionCount, 
Max((total_cases/population))* 100 AS percentagePeopleInfected
FROM portfolio..coviddeath$
WHERE continent is not null
GROUP BY location, population
ORDER BY percentagePeopleInfected DESC

-- Highest death count per population
Select location,population, 
Max(cast(total_deaths AS int)) AS HighestDeathCount
FROM portfolio..coviddeath$
WHERE continent is not null
GROUP BY location, population
ORDER BY HighestDeathCount DESC


--Highest death count by continent

Select continent,
Max(cast(total_deaths AS int)) AS TotalDeathCount
FROM portfolio..coviddeath$
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC



--Global cases

SELECT date, SUM(new_cases) AS Total_cases, 
SUM(CAST(new_deaths AS int)) AS Total_Death,SUM(CAST(new_deaths AS int))/ SUM(new_cases) *100 AS DeathPercentage
FROM portfolio..coviddeath$
WHERE continent is not null
GROUP BY date
ORDER BY 1,2
 
 create view Globalcases as
 SELECT date, SUM(new_cases) AS Total_cases, 
SUM(CAST(new_deaths AS int)) AS Total_Death,SUM(CAST(new_deaths AS int))/ SUM(new_cases) *100 AS DeathPercentage
FROM portfolio..coviddeath$
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

--JOING CovidVaccinations with CovidDeath

SELECT *
FROM portfolio..coviddeath$ Death
JOIN portfolio..covidvaccination$ Vaccinations
ON Death.location = Vaccinations.location
AND Death.date = Vaccinations.date


--Total population compare to viccinations

With TotalPeopleVaccinated (continent,location,date,population,new_vaccinations,RollingPeopleVaccinated) 
AS (
SELECT Death.continent,Death.location,Death.date,Death.population,
Vaccinations.new_vaccinations,
SUM(CAST(Vaccinations.new_vaccinations AS int)) OVER(PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM portfolio..coviddeath$ Death JOIN portfolio..covidvaccination$ Vaccinations 
ON Death.location = Vaccinations.location 
AND Death.date = Vaccinations.date 
WHERE Death.continent is not null)

SELECT *,(RollingPeopleVaccinated/population)* 100 AS PercentagePeopleVaccinated
FROM TotalPeopleVaccinated

--creating view for visualization

create view TotalPeopleVaccinated2 AS 
SELECT Death.continent,Death.location,Death.date,Death.population,
Vaccinations.new_vaccinations,
SUM(CAST(Vaccinations.new_vaccinations AS int)) OVER(PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM portfolio..coviddeath$ Death JOIN portfolio..covidvaccination$ Vaccinations 
ON Death.location = Vaccinations.location 
AND Death.date = Vaccinations.date 
WHERE Death.continent is not null

SELECT *
FROM Globalcases
