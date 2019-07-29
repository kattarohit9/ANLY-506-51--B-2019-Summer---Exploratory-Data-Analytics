#
#
# This code files contains practicing Tidy Data,  Spreading, Gathering, Separating, Uniting, Missing Values, Case Study.
#
#
#



# Load the library "tidyverse" into R
library(tidyverse)

# Display the example Table data
table1
table2
table3
table4
table5

# Get the rate per 10,000 using mutate function from the table1
table1 %>% 
  mutate(rate = cases / population * 10000)

# Get the cases per year using count function from the table1
table1 %>% 
  count(year, wt = cases)

#use gather to get columns into a new pair of variables called Key and Value
# The Gather command takes multiple columns and collapses into key-value pairs, duplicating all other columns as needed
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")

# These are generic functions that dispatch to individual tbl methods - see the method documentation for details of individual data sources
#use left join function to get the data into a single tibble
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

#The Spread() command a key-value pair across multiple columns.
#spread is usded observation is scattered across multiple rows
table2 %>%
  spread(key = type, value = count)

#The separate() command pulls apart one column into multiple columns, by splitting wherever a separator character appears.
#separating rate into cases and population
table3 %>% 
  separate(rate, into = c("cases", "population"))
#separating rate into cases and population using seperator
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
#separating rate into cases and population selecting auto convert for types
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

#separating rate into cases and population splitting last 2 digits of a year
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

#Unite - combines multiple columns into a single column with seperator
#The unite command is a convenience function to paste together multiple columns into one.
table5 %>% 
  unite(new, century, year, sep = "")

# Gets the stocks data using the tibble function
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

#Stocks data is created using the spread function, implicit missing value explicit
stocks %>% 
  spread(year, return)

#The Gather() command takes multiple columns and collapses into key-value pairs, duplicating all other columns as needed.
#set na.rm = TRUE in gather() to turn explicit missing values implicit
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

#Makes missing values explicit in tidy data
stocks %>% 

#use fill for missing data filling  
# The complete() turns implicit missing values into explicit missing values. 
# Fills missing values in selected columns using the previous entry. This is useful in the common output format where values are not repeated, they're recorded each time they change.
stocks %>% 
  fill(return)
  complete(year, qtr)


  
# Returns the complete data  
gather(year, return, `2015`:`2016`, na.rm = TRUE)