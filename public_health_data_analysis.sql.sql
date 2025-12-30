select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

-- the data that we are going to use
select Location , date, total_cases,new_cases, total_deaths,population
from PortfolioProject..CovidDeaths
order by 1,2

-- Total cases vs Total deaths
select Location , date, total_cases,total_deaths , (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
order by 1,2


select Location , date, total_cases,total_deaths , (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%India%'
order by 1,2

--Total Cases Vs population
-- Percentage of population got covid
select Location , date, population ,total_cases,(total_cases/population )*100 as CovidPercentage
from PortfolioProject..CovidDeaths
where location like '%India%'
order by 1,2


-- Countries with highest infection rate compared to population
select Location , population ,MAX(total_cases) as HightInfectionCount ,MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%India%'
Group by location , population
order by PercentPopulationInfected desc


-- Countries with highest Death Count per population
select location ,MAX(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
Group by location
order by TotalDeathCount desc


-- continents with the highest death counts
select continent ,MAX(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
Group by continent
order by TotalDeathCount desc

--Calculates daily global COVID statistics (total cases, total deaths, and death percentage)
select date,SUM(new_cases) AS total_cases,SUM(CAST(new_deaths AS INT)) AS total_deaths,SUM(CAST(new_deaths AS INT)) * 100.0 / NULLIF(SUM(new_cases), 0) AS DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
Group by date
order by date;

--Calculates overall global COVID statistics (total cases, total deaths, and death percentage)
select SUM(new_cases) AS total_cases,SUM(CAST(new_deaths AS INT)) AS total_deaths,SUM(CAST(new_deaths AS INT)) * 100.0 / NULLIF(SUM(new_cases), 0) AS DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2;



-- Total Population vs vaccinations
WITH PopvsVac AS (
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        vac.new_vaccinations,
        SUM(CONVERT(int, vac.new_vaccinations)) 
            OVER (PARTITION BY dea.location ORDER BY dea.date) 
            AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *,
       (RollingPeopleVaccinated * 100.0 / population) AS PercentPopulationVaccinated
FROM PopvsVac;


-- Top 10 countries by vaccination coverage
WITH PopvsVac AS (
    SELECT 
        dea.location,
        dea.population,
        SUM(CONVERT(int, vac.new_vaccinations)) 
            OVER (PARTITION BY dea.location ORDER BY dea.date) 
            AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT DISTINCT 
    location,
    population,
    MAX(RollingPeopleVaccinated * 100.0 / population) AS PercentVaccinated
FROM PopvsVac
GROUP BY location, population
ORDER BY PercentVaccinated DESC;

