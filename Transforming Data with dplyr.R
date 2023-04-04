### Datacamp Course Exercise: Data Manipulation with dplyr: Transforming Data with dplyr ###


# load packages and dataset

library(dplyr,quietly = T)
library(tidyverse)

counties <- readRDS("C:/Users/kaitl/Documents/Professional Development/R/Datacamp/Data Manipulation with dplyr/counties.rds")


# Select the following four columns from the counties variable: state, county, population, poverty (You don't need to save the result to a variable.)
counties_selected <- counties %>%
  select(state, county, population, private_work, public_work, self_employed)

# Here you see the counties_selected dataset with a few interesting variables selected.
# These variables: private_work, public_work, self_employed describe whether people work for the government, for private companies, or for themselves.
# Add a verb to sort the observations of the public_work variable in descending order.
counties_selected %>%
  # Add a verb to sort in descending order of public_work
  arrange(desc(public_work))

# You use the filter() verb to get only observations that match a particular condition, or match multiple conditions.
# Find only the counties that have a population above one million (1000000).
counties_selected %>%
  # Filter for counties with a population above 1000000
  filter(population >1000000)
         
# We're often interested in both filtering and sorting a dataset, to focus on observations of particular interest to you. 
# Here, you'll find counties that are extreme examples of what fraction of the population works in the private sector.
# Filter for counties in the state of Texas that have more than ten thousand people (10000), and sort them in descending order of the percentage of people employed in private work.
# Filter for Texas and more than 10000 people; sort in descending order of private_work
counties_selected %>%
  # Filter for Texas and more than 10000 people
  filter(state == "Texas" & population>10000) %>%
  # Sort in descending order of private_work
  arrange(desc(private_work))

# Use mutate() to add a column called public_workers to the dataset, with the number of people employed in public (government) work.
counties_selected %>%
  # Add a new column public_workers with the number of people employed in public work
  mutate(public_workers = public_work * population / 100)

# Select the columns state, county, population, men, and women.
# Add a new variable called proportion_women with the fraction of the county's population made up of women.
counties_selected <- counties %>%
  # Select the columns state, county, population, men, and women
  select(state, county, population, men, women)

counties_selected %>%
  # Calculate proportion_women as the fraction of the population made up of women
  mutate(proportion_women = women / population)


counties %>%
  # Select the five columns 
  select(state, county, population, men, women) %>%
  # Add the proportion_men variable
  mutate(proportion_men = men / population) %>%
  # Filter for population of at least 10,000
  filter(population > 10000) %>%
  # Arrange proportion of men in descending order 
  arrange(desc(proportion_men))






