# Public Health Data Analysis using SQL

## 📌 Project Overview
This project focuses on analyzing a large real-world public health dataset using SQL to extract meaningful insights related to COVID-19 cases, deaths, population impact, and vaccination progress.  
The objective is to demonstrate strong SQL fundamentals along with analytical thinking through structured queries.

Although the dataset is healthcare-related, the SQL techniques used in this project are directly transferable to business, finance, sales, and operational analytics.

---

## 🎯 Objectives
- Analyze COVID-19 cases and deaths over time
- Compare total cases with population to measure infection rates
- Identify countries and continents with the highest impact
- Perform time-series analysis for global trends
- Analyze vaccination progress using cumulative metrics
- Demonstrate advanced SQL concepts such as joins, window functions, and CTEs

---

## 🗂 Dataset Used
- **CovidDeaths** – Contains data on cases, deaths, population, and locations
- **CovidVaccinations** – Contains vaccination-related data by date and location

Source: Public COVID-19 datasets (commonly used for analytical case studies)

---

## 🛠️ Tools & Technologies
- SQL Server
- SQL Server Management Studio (SSMS)

---

## 🔑 Key SQL Concepts Demonstrated
- `SELECT`, `WHERE`, `ORDER BY`
- Aggregations: `SUM`, `MAX`
- `GROUP BY`
- Calculated fields and percentages
- Handling NULL values (`NULLIF`)
- Joins (`INNER JOIN`)
- Window functions (`OVER`, `PARTITION BY`)
- Common Table Expressions (CTEs)
- Time-series analysis

---

## 📊 Analysis Performed

### 1️⃣ Data Exploration
- Filtered country-level data by excluding aggregated rows (world and continent totals)
- Selected relevant columns for analysis

### 2️⃣ Case & Death Analysis
- Total cases vs total deaths
- Death percentage calculation
- Country-specific analysis (example: India)

### 3️⃣ Population Impact
- Percentage of population infected
- Countries with highest infection rates relative to population

### 4️⃣ Death Count Analysis
- Countries with highest total deaths
- Continents with highest death counts

### 5️⃣ Global Time-Series Analysis
- Daily global cases, deaths, and death percentage
- Overall global summary statistics

### 6️⃣ Population vs Vaccination Analysis
- Joined deaths and vaccination datasets
- Calculated rolling (cumulative) vaccinations per country
- Computed percentage of population vaccinated
- Identified top countries by vaccination coverage

---

## 🧠 Key Insight Example
Using window functions, cumulative vaccination progress was tracked per country over time, enabling a clear comparison between population size and vaccination coverage.

---

## 📈 Sample Query Highlight
```sql
SUM(CONVERT(int, vac.new_vaccinations)) 
OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
