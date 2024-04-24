# COVID-19

This repository contains a series of SQL queries used for analyzing COVID-19 data. The analysis covers various aspects such as infection rates, death rates, and vaccination rates across different regions, with a particular focus on Nigeria and Africa.


## Analysis Overview

The SQL scripts in this repository aim to extract and analyze data from the `coviddeath$` dataset to understand:
- The case-fatality rate of COVID-19 in Nigeria.
- Infection rates compared to the total population in Nigeria and across Africa.
- The countries with the highest infection and death rates globally and within Africa.
- Trends in global cases and deaths over time.
- The impact of vaccinations on population immunity.

### Key Findings

1. **Case-Fatality Rate in Nigeria**: Our analysis shows a case-fatality rate of .09% in Nigeria, indicating that <.05% of those diagnosed with COVID-19 in Nigeria have died due to the virus.
2. **High Infection Rates**: Several African countries have infection rates significantly above the global average, with Country South Africa showing the highest rate at 4.2% of its population.
3. **Vaccination Impact**: As of the latest data, 10% of the population in Nigeria has been vaccinated with at least one dose, highlighting the progress and challenges in vaccination efforts.
4. **Global Perspective**: The data shows a fluctuating trend in global new cases and deaths, with peaks occurring in 2021.

### SQL Queries

The queries perform a range of data manipulations and calculations:
- Basic data retrievals for an initial understanding of the dataset.
- Complex joins and window functions for detailed insights, especially concerning vaccinations.
- Creation of views for easier access and repeated analysis.

### Visualization

Visualizations created from the outputs of these queries can be found in(https://public.tableau.com/app/profile/hassan.olakunle.durojaiye/viz/Covid19Tableau_16286025251100/Dashboard1)
.

## Tools Used

- SQL Server: For querying and managing the database.
- Excel/CSV: For storing query outputs and further manipulation .



## Contributing

Contributions to this project are welcome. Please fork the repository and submit a pull request with your suggested changes.

## License

This project is licensed under the [MIT License](LICENSE.md).

---
