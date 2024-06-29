# NOAA Storm data 1997
This repository is dedicated to the visualization of major storm events occurring across the regions of united states for a given land area. 
## Introduction
Storms are a regular occurrence in the United States, getting some preliminary statistical analysis on factors that might influence high casualty and damage when a storm does pass helps mitigate its effect.  In this project, a scatter plot diagram of the number of major storm events across a given land area is visualized, the visual is further segregated by region to give an idea of how storm events are spread across different regions of the United States. 
## Data
The Data was accessed from the NOAA database, the dataset contains 51 elements that contain the start and end date for a storm uniquely identified, further information on the states, county, deaths, property damage, and parameters such as its magnitude and rain fall length are captured. For our use case we will be using 8 column elements:
*	BEGIN_YEARMONTH : Year and month of storm occurrence 
*	EPISODE_ID: unique ID given to that storm
*	STATE: state name
*	STATE_ FIPS: state id
*	CZ_NAME: Name of the geography associated with the type.
*	CZ_TYPE : Geographic level
*	CZ_FIPS: Geography ID
*	EVENT_TYPE: Type of storm
## Cleaning
The states and country names will be changed to title case, a unique ID that combines both state ID and Country ID will be created, and the column names would be changed to lower case.
## Analysis
For our analysis we will filter for observations recorded at the country level.
Once the data is cleaned, we will aggregate the dataset by the state to count the number of storm occurrences by state for the year 1997. This data would then be left joined with the default database in R which contains information on State area, and the region it is a part of. Once we merge and select our required columns, a scatter plot of the number of storm events and area will be visualized with a color code separating the regions. 
## Conclusion
The visualization highlights certain clusters formed, helping us identify some correlation between the regions and land area influencing the number of storms occurring in a state. Further analysis might provide insights as to what independent variables influence the severity of a storm. 
