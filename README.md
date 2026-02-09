# 🌍 World Wide Energy Consumption Analysis (SQL Analytics Project)

## Project Overview
This project is a relational SQL-based analytics solution designed to evaluate **global energy consumption, production, emissions, GDP, and population data** at a country and year level.

The analysis focuses on identifying **energy efficiency and emission intensity** by integrating economic and demographic indicators, enabling normalized comparisons across countries of different sizes and development levels.

---

## Analytical Context
Traditional energy and emission analysis often relies on absolute values, which leads to misleading conclusions when comparing countries with vastly different population sizes and economic scales.

This project addresses this analytical gap by normalizing energy and emission metrics using **population** and **GDP**, enabling fair, comparable, and decision-relevant insights across countries.

---

## Project Objectives

- Design a normalized relational database for global energy analytics
- Integrate energy production, emission, GDP, and population datasets
- Perform country-level and time-series analysis
- Derive key performance indicators such as:
  - Per-capita emissions
  - GDP-normalized emission intensity
- Identify countries with economically inefficient energy systems

---

## Dataset Description

The analysis is based on country-level, year-wise datasets including:
- Energy production by source
- Carbon emissions by energy type
- Gross Domestic Product (GDP)
- Population statistics

All datasets are integrated using a common country dimension to ensure consistent aggregation and analysis.

---

## Tools & Technologies

- SQL (MySQL / PostgreSQL compatible)
- Relational database design
- Joins, aggregations, and subqueries
- KPI engineering and normalization techniques

---

## Repository Structure & SQL Access

All SQL code used in this analysis is available in the `sql/` directory:

- **`schema.sql`[https://github.com/VishwasJadhav/Global-Energy-Efficiency-SQL-Analysis/blob/main/Anlaysis_Queries.sql]**  
  Defines the database schema, including table structures, data types, and primary/foreign key relationships.

- **`analysis_queries.sql`[https://github.com/VishwasJadhav/Global-Energy-Efficiency-SQL-Analysis/blob/main/Anlaysis_Queries.sql]**  
  Contains analytical SQL queries mapped to business and analytical questions, including:
  - Energy production and emission analysis
  - Per-capita emission calculations
  - GDP-normalized emission intensity metrics
  - Country-level and time-series comparisons

All queries are written to be modular, readable, and reproducible.

---

## Key Analysis Performed

- Country-wise and year-wise emission analysis
- Energy production versus emission comparison
- Per-capita and GDP-normalized emission evaluation
- Energy-type contribution to total emissions
- Trend analysis across multiple years

---

## Key Findings

- Absolute emission values often conceal inefficiencies; normalized metrics provide clearer insights
- Several countries exhibit high emissions relative to their economic output
- Energy mix significantly influences overall emission intensity
- Population-normalized metrics reveal disproportionate per-capita environmental impact in certain regions

---

## Business & Policy Implications

- Enables data-driven energy and climate policy evaluation
- Supports cross-country sustainability benchmarking
- Identifies targets for clean energy transition
- Assists long-term energy infrastructure and planning decisions

---

## Recommendations

- Shift analytical focus from total emissions to efficiency-based metrics
- Prioritize cleaner energy investments in high emission-intensity regions
- Incorporate GDP and population indicators into sustainability assessments
- Use normalized KPIs for international energy performance comparisons

---

## Key Technical Learnings

- Normalized relational schema design improves analytical flexibility and accuracy
- GDP- and population-based normalization is critical for fair energy analysis
- Absolute metrics alone are insufficient for evaluating sustainability performance
- Well-documented, modular SQL queries enhance reproducibility and reviewability

--
