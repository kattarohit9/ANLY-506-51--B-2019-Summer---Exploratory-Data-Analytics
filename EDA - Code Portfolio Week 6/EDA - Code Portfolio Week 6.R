#
#
# This code files contains practicing Data transformation and using functions such as filter, arrange, groups and summary.
#
#
#




# Load the library "nycflights13" into R
library(nycflights13)
# Load the library "tidyverse" into R
library(tidyverse)

#The filter function is used to filter the data
filter(flights, month == 1, day == 1)

#Save the results to a variable "dec25" for month = 12 and day = 25
(dec25 <- filter(flights, month == 12, day == 25))

#Logical comparisons in R
#Example for using OR logical function for all flights that departed in November or December
filter(flights, month == 11 | month == 12)

#Example for using IN operator to get every row where month is one of the values in 11,12
nov_dec <- filter(flights, month %in% c(11, 12))

#Example for using NOT operator for flights that weren't delayed (on arrival or departure) by more than two hours
filter(flights, !(arr_delay > 120 | dep_delay > 120))

# Comparing the NA variable
x <- NA
y <- NA
x == y

#Check for NA values in the dataset
is.na(x)

#The arrange() command is used to sort the flights data on year, month, day
arrange(flights, year, month, day)

#Sort the flights data on year by descending
arrange(flights, desc(year))

#The rename() command modifies names by name, not position.
#Rename the tail_num to tailnnum column name 
rename(flights, tail_num = tailnum)

#Moving the time_hour to the beginning of the dataframe using everything() function
select(flights, time_hour,  everything())

# Displays data by selecting columns by name
select(flights, year, month, day)

# Selecting the column names which start with "a" in flights data frame
select(flights, starts_with("a"))

# Selecting columns between the columns "year" and "day" 
select(flights, year:day)

# Selecting all columns in the data frame except those between "year" to "day" 
select(flights, -(year:day))

# Selecting columns containing letters "fl" in the column name
select(flights, starts_with("fl")) 


# Creating new dataset using the mutate() function with certain columns
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

#The transmutate() command adds new variables to the old one and drop existing ones
# use transmute()  to keep columns in the new variables 
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

#Summarizing the dataframe to a single row
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

#Create new dataframe by combining multiple operations using the pipe such as count, filter etc 
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")


