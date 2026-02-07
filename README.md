# 🌍 World Wide Energy Consumption Analysis (SQL Analytics Project)

## Project Overview
This project is a relational SQL-based analytics solution designed to evaluate **global energy consumption, production, emissions, GDP, and population data** at a country and year level.

The analysis focuses on identifying **energy efficiency and emission intensity** by integrating economic and demographic indicators, enabling normalized comparisons across countries of different sizes and development levels.

---

## Problem Definition (Analytical Perspective)

Traditional energy and emission analysis relies heavily on **absolute values**, which leads to misleading conclusions when comparing countries with vastly different population sizes and economic scales.

### Key Analytical Gap
> How can energy emissions be evaluated **fairly and comparably** across countries while accounting for population size and economic output?

---

## Objectives

- Design a normalized relational database for global energy analytics
- Integrate energy production, emission, GDP, and population datasets
- Perform country-level and time-series analysis
- Create derived metrics such as:
  - Per-capita emissions
  - GDP-normalized emission intensity
- Identify inefficient energy systems with high emissions relative to economic output

---

## Data Model & Schema Design

The database consists of the following core entities:
- **Country** (dimension table)
- **Energy Production** (fact table)
- **Energy Emissions** (fact table by energy type)
- **GDP** (economic indicator table)
- **Population** (demographic indicator table)

All fact tables are linked via a common country dimension, ensuring consistent aggregation and join logic.

---

## Analytical Techniques Used

- Multi-table joins
- Aggregations and grouping
- Time-series trend analysis
- Normalization using GDP and population
- Emission intensity calculations
- Comparative country ranking logic

---

## Key Findings

- Absolute emission values mask inefficiencies; normalized metrics provide clearer insights
- Several countries exhibit **high emissions per unit of GDP**, indicating low energy efficiency
- Energy mix plays a critical role in emission intensity
- Population-normalized analysis highlights disproportionate individual-level environmental impact

---

## Business & Policy Implications

- Enables data-driven energy policy evaluation
- Supports international sustainability benchmarking
- Assists in identifying targets for clean energy transition
- Provides quantitative backing for climate and infrastructure planning

---

## Recommendations

- Shift policy evaluation from total emissions to **efficiency-based metrics**
- Prioritize clean energy investment in high emission-intensity regions
- Integrate economic productivity indicators into climate assessments

---

## Tools & Technologies
- SQL (MySQL)
- Relational database design
- Data normalization and KPI engineering

