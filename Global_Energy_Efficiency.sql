CREATE DATABASE ENERGYDB;
USE ENERGYDB;


-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10),
    Country VARCHAR(100) PRIMARY KEY
);

SELECT * FROM COUNTRY;

-- 2. emission table
CREATE TABLE emission (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM EMISSION;


-- 3. population table
CREATE TABLE population (
    countripopulationes VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);


SELECT * FROM PRODUCTION;   

-- 5. gdp table
CREATE TABLE gdp (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

SELECT * FROM GDP;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM COUNTRY;
SELECT * FROM EMISSION;
SELECT * FROM POPULATION;
SELECT * FROM PRODUCTION;   
SELECT * FROM GDP;
SELECT * FROM CONSUMPTION;

set sql_safe_updates = 0;

delete from gdp where year = 2024;
delete from population where year = 2024;

## Data Analysis Questions

-- What is the total emission per country for the most recent year available?

select country, sum(emission) as total_emission
from emission
where year = (select max(year) from emission)
group by country;

-- What are the top 5 countries by GDP in the most recent year?

select country
from gdp
where year = (select max(year) from emission)
group by country;

-- Compare energy production and consumption by country and year. 

with cte1 as ( select p.country, c.year, production, consumption
from production p
join consumption c
on p.country = c.country and p.year = c.year)

select country, year, sum(production) as Production , sum(consumption) as Consumption, (sum(production) - sum(consumption)) as Difference 
from cte1
group by country, year
order by difference;

-- Which energy types contribute most to emissions across all countries?

select energy_type, sum(emission) as total_emission
from emission
group by energy_type
order by total_emission desc;

-- Trend Analysis Over Time

-- How have global emissions changed year over year?

select year, avg(emission)
from emission
group by year
order by year;

-- What is the trend in GDP for each country over the given years?

select country, year, value
from gdp 
order by value, year;

-- How has population growth affected total emissions in each country?

select country, year, population, emission,
population - lag(population) over(partition by country order by year) as Population_Change,
emission - lag(emission) over(partition by country order by year) as Emission_Change
from (
select e.country, e.year, e.emission, p.value as Population
from emission e
join population p
on e.country = p.countries and e.year = p.year
order by country, year) as d;

-- Has energy consumption increased or decreased over the years for major economies?

select * , consumption - lag(consumption) over(partition by country order by year) as Consumption_Difference
from
(select g.country, g.year, g.value as gdp, c.consumption
from gdp g
join consumption c
on g.country = c.country and g.year = c.year
join (select country
from gdp
group by country
order by max(value) desc
limit 10) as top_contries
on top_contries.country = g.country) as d;

-- BY CTE:

with cte1 as (select country
from gdp
group by country
order by max(value) desc
limit 10),

cte2 as (select g.country, g.year, g.value as gdp, c.consumption
from gdp g
join consumption c
on g.country = c.country and g.year = c.year 
join cte1 on cte1.country = g.country)

select * , consumption - lag(consumption) over(partition by country order by year) as Consumption_Difference
from cte2;

-- What is the average yearly change in emissions per capita for each country?

select country,avg(per_capita_emission_change) as avg_yearly_per_capita_change,year
from (select country, year, per_capita_emission - lag(per_capita_emission) over(partition by country order by year) 
as per_capita_emission_change from emission) as d
where per_capita_emission_change is not null
group by year,country;


## Ratio & Per Capita Analysis

-- What is the emission-to-GDP ratio for each country by year?

select e.country, e.year, e.emission, g.value as gdp, e.emission/g.value as emission_to_gdp_ratio
from emission e
join gdp g
on e.country = g.country and e.year = g.year
order by e.country, e.year; 

-- By taking sum of emission as gdp is same for same year

with total_emission as (select country, year, sum(emission) as total_emission
from emission
group by country,year
order by country)

select t.country, t.year, g.value as gdp, t.total_emission /g.value as emission_to_ratio
from total_emission t
join gdp g
on t.country = g.country and t.year = g.year
order by country, year;

-- What is the energy consumption per capita for each country over the last decade?

select country , year, population, consumption, consumption * 1.0/population as consumption_per_capita
from(

select c.country, p.year, p.value as Population , c.consumption
from population p
join consumption c
on p.countries = c.country and p.year = c.year) as d
order by country, year;

-- as population same throughout one year

with cte1 as( select countries as country, year, max(value) as Population
from population 
group by country, year),

cte2 as ( select country, year, sum(consumption) as Consumption
from consumption
group by country, year)

select cte1.country, cte1.year, consumption * 1.0 / population as Consumption_per_Capita
from cte1
join cte2
on cte1.country = cte2.country and cte1.year = cte2.year
order by country, year;

-- How does energy production per capita vary across countries?

with population1 as ( select countries as country, year, max(value) as population
from population
group by countries, year ),

total_production as ( select country, year, sum(production) as production
from production
group by country, year )

select p.country, p.year, p.population, t.production, production * 1.0 / population as production_per_capita
from population1 p
join total_production t
on p.country = t.country and p.year = t.year
order by country, year;

-- Which countries have the highest energy consumption relative to GDP?

with cte1 as (select country, year, sum(consumption) as Total_consumption
from consumption
group by country, year),

cte2 as (select g.country, g.year, cte1.total_Consumption, g.value as gdp, cte1.total_consumption * 1.0 /g.value as consumption_to_gdp
from cte1
join gdp g 
on cte1.country = g.country and cte1.year = g.year)

select country, avg(consumption_to_gdp) as avg_consumption_to_gdp
from cte2
group by country
order by avg_consumption_to_gdp desc;

-- What is the correlation between GDP growth and energy production growth?

with cte1 as ( select country, year, sum(production) as total_production
from production
group by country, year ),

cte2 as (select cte1.country, cte1.year, cte1.total_production, g.value as gdp
from cte1 
join gdp g
on cte1.country = g.country and cte1.year = g.year),

cte3 as (select *, total_production - lag(total_production) over(partition by country order by year) as production_growth,
gdp - lag(gdp) over(partition by country order by year) as gdp_growth
from cte2)

select country,
( avg(production_growth * gdp_growth) - avg(production_growth) * avg(gdp_growth))
/
( STDDEV_POP(production_growth) * STDDEV_POP(gdp_growth) ) AS correlation_gdp_production
from cte3
where production_growth is not null and gdp_growth is not null
group by country;


##  Global Comparisons

-- What are the top 10 countries by population and how do their emissions compare?

with population_country as ( SELECT countries as country, MAX(value) as population
from population
group by countries
),

top_10_population as ( select country, population
from population_country
order by population desc
limit 10
),

emission_country as ( select country, sum(emission) as total_emission
from emission
group by country
)

select t.country, t.population, e.total_emission
from top_10_population t
join emission_country e
on t.country = e.country
order by t.population desc;

-- Which countries have improved (reduced) their per capita emissions the most over the last decade?

WITH emission_country_year AS (
    SELECT
        country,
        year,
        SUM(emission) AS total_emission
    FROM emission
    GROUP BY country, year
),

per_capita AS (
    SELECT
        e.country,
        e.year,
        e.total_emission,
        p.value AS population,
        e.total_emission * 1.0 / p.value AS per_capita_emission
    FROM emission_country_year e
    JOIN population p
        ON e.country = p.countries
       AND e.year = p.year
),

bounds AS (
    SELECT
        country,
        MIN(year) AS start_year,
        MAX(year) AS end_year
    FROM per_capita
    GROUP BY country
),

start_end_values AS (
    SELECT
        p.country,
        MAX(CASE WHEN p.year = b.start_year THEN p.per_capita_emission END) AS start_per_capita,
        MAX(CASE WHEN p.year = b.end_year THEN p.per_capita_emission END) AS end_per_capita
    FROM per_capita p
    JOIN bounds b
        ON p.country = b.country
    GROUP BY p.country
)

SELECT
    country,
    start_per_capita,
    end_per_capita,
    (start_per_capita - end_per_capita) AS per_capita_reduction
FROM start_end_values
WHERE start_per_capita IS NOT NULL
  AND end_per_capita IS NOT NULL
  AND start_per_capita > end_per_capita
ORDER BY per_capita_reduction DESC;

-- What is the global share (%) of emissions by country?

select country, concat((sum(emission) * 1.0 / (select sum(emission) from emission) * 100), "%") as Share_of_emission
from emission
group by country
order by share_of_emission desc;

-- What is the global average GDP, emission, and population by year?

with cte1 as (select country, year, sum(emission) as total_emission
from emission
group by country, year),

avg_emission as (select year, avg(total_emission) as avg_emission
from cte1
group by year),

avg_gdp as (select year, avg(value) as avg_gdp
from gdp
group by year),

avg_population as (select year, avg(value) as avg_population
from population
group by year)

select e.year, g.avg_gdp, e.avg_emission, p.avg_population
from avg_emission e
join avg_gdp g
on e.year = g.year
join avg_population p
on e.year = p.year
order by e.year;

-- ------------------------------------------------------------------------------