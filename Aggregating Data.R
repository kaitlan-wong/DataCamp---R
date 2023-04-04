### Datacamp Course Exercise: Data Manipulation with dplyr: Aggregating Data ###

# load packages and dataset

library(dplyr,quietly = T)
library(tidyverse)

counties <- readRDS("C:/Users/kaitl/Documents/Professional Development/R/Datacamp/Data Manipulation with dplyr/counties.rds")


counties_selected <- counties %>%
  select(county, region, state, population, citizens)

# Use count to find the number of counties in each region in descending order
counties_selected %>%
  count(region, sort = TRUE)

# You can weigh your count by particular variables rather than finding the number of counties.
# Find number of counties per state, weighted by citizens, sorted in descending order
counties_selected %>%
  count(state, wt = citizens, sort = TRUE)

# You can combine multiple verbs together to answer increasingly complicated questions of your data. For example: "What are the US states where the most people walk to work?"
# You'll use the walk column, which offers a percentage of people in each county that walk to work, to add a new column and count based on it.
counties_selected <- counties %>%
  select(county, region, state, population, walk)
counties_selected %>%
  # Add population_walk containing the total number of people who walk to work 
  mutate(population_walk = walk * population / 100) %>%
  # Count weighted by the new column, sort in descending order
  count(state, wt = population_walk, sort = TRUE)


# Summarizing
counties_selected <- counties %>%
  select(county, population, income, unemployment)
counties_selected %>%
  # Summarize to find minimum population, maximum unemployment, and average income
  summarize(min_population = min(population),
            max_unemployment = max(unemployment),
            average_income = mean(income))

# Another interesting column is land_area, which shows the land area in square miles. Here, you'll summarize both population and land area by state, with the purpose of finding the density (in people per square miles).
counties_selected <- counties %>%
  select(state, county, population, land_area)

counties_selected %>%
  # Group by state
  group_by(state) %>%
  # Find the total area and population
  summarize(total_area = sum(land_area),
            total_population = sum(population))

# You can group by multiple columns instead of grouping by one. 
# Here, you'll practice aggregating by state and region, and notice how useful it is for performing multiple aggregations in a row.
counties_selected <- counties %>%
  select(region, state, county, population)
counties_selected %>%
  # Group and summarize to find the total population
  group_by(region, state) %>%
  summarize(total_pop = sum(population))


# Previously, you used the walk column, which offers a percentage of people in each county that walk to work, to add a new column and count to find the total number of people who walk to work in each county.
# Now, you're interested in finding the county within each region with the highest percentage of citizens who walk to work.
counties_selected <- counties %>%
  select(region, state, county, metro, population, walk)

counties_selected %>%
  # Group by region
  group_by(region) %>%
  # Find the greatest number of citizens who walk to work
  slice_max(walk, n = 1)


# You've been learning to combine multiple dplyr verbs together. 
#  Here, you'll combine group_by(), summarize(), and slice_min() to find the state in each region with the highest income.
# When you group by multiple columns and then summarize, it's important to remember that the summarize "peels off" one of the groups, but leaves the rest on. 
# For example, if you group_by(X, Y) then summarize, the result will still be grouped by X
counties_selected <- counties %>%
  select(region, state, county, population, income)

# Calculate the average income (as average_income) of counties within each region and state (notice the group_by() has already been done for you).
# Find the state with the lowest average_income in each region.
counties_selected <- counties %>%
  select(region, state, county, population, income)

counties_selected %>%
  group_by(region, state) %>%
  # Calculate average income
  summarize(average_income = mean(income)) %>%
  # Find the lowest income state in each region
  slice_min(average_income, n = 1)

# In how many states do more people live in metro areas than non-metro areas?
# Recall that the metro column has one of the two values "Metro" (for high-density city areas) or "Nonmetro" (for suburban and country areas).
counties_selected <- counties %>%
  select(state, metro, population)

counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) 

# Extract the most populated row for each state
slice_max(population, n =1)

# Count the states with more people in Metro or Nonmetro areas
# You'll need to ungroup the data first, as it is still grouped by state, and you don't want to count within the groups.
ungroup(state) %>%
  count(metro)

