#
#
# This code files contains practicing Exploratory Data Analysis.
#
#
#




# To change the working directory 
setwd( "C:\Users\katta\Desktop\Harrisburg\Semester 2\Exploratory Data Analysis\Exploratory Data Analytics - Code Portfolio")

# Load the library "readr" into R
library(readr)

# Load the "US EPA data 2017.csv" dataset into R for analysis
ozone <- read_csv("US EPA data 2017.csv")

# Invokes a spreadsheet-style data viewer on a matrix-like R object "ozone".
View(ozone)

# The names() command is used to get or set the names of an object.
# Change the column names to remove spaces in the dataset for better usablilty in R
names(ozone) <- make.names(names(ozone))

#The nrow() and ncol() commands return the number of rows or columns present in x. NCOL and NROW do the same treating a vector as 1-column matrix, even a 0-length vector
# Gets the number of rows in the data
nrow(ozone)
# Gets the number of columns in the data
ncol(ozone)

# The str() command is used to display internal structure of an R object and is an alternative to summary
# Gets the structure of the dataset
str(ozone)

# start and end of dataset head() and tail() function
# The head() and tail() commands are used to return The First Or Last Part Of An Object
head(ozone)
tail(ozone)

#To display certain elements in the dataset for selective data viewing
head(ozone[, c(6:7, 10)])
tail(ozone[, c(6:7, 10)])

#Get the time measurements 
table(ozone$`State.Code`)
#dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges
# Load the library "dplyr" into R
library(dplyr)

# The filter() command is used to display filtered data in a dataframe
# Use filter() find rows/cases where conditions are true. Unlike base subsetting with [, rows where the condition evaluates to NA are dropped
filter(ozone, State.Code == "36" 
        & County.Code == "033" 
       & Site.Num == "10") %>%
        select( State.Code, County.Code, 
                Site.Num) %>% 
        as.data.frame

#counting and viewing unique data
# View certain records in the ozone dataset
# The select() command keeps only the variables you mention 
select(ozone, State.Name) %>% unique %>% nrow
# Get the non repetitive or unique data in the ozone data
# The unique() command returns a vector, data frame or array like x but with duplicate elements/rows removed.
unique(ozone$State.Name)

#Sumarizing dataset
# The summary() command is a generic function used to produce result summaries of the results of various model fitting functions.
summary(ozone$Observation.Percent)

#additional datset breakdown
# The quantile() command is a generic function quantile produces sample quantiles corresponding to the given probabilities
quantile(ozone$Observation.Percent, seq(0, 1, 0.1))


# Ranking the state with highest value
# The ranking() command returns the sample ranks of the values in a vector. Ties (i.e., equal values) and missing values can be handled in several ways.
ranking <- group_by(ozone, State.Name, County.Name) %>%
  summarise(ozone = mean(Observation.Percent)) %>%
  as.data.frame %>%
  arrange(desc(ozone))

# Display the ranking data from the dataset
ranking

#Get top 10 values in the dataset
head(ranking, 10)

#Get last 10 values in the dataset
tail(ranking, 10)

#checking number of observations using the filter on state = "California" and county = "Mariposa"
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>% nrow

# The mutate() command adds new variables and preserves existing; transmute drops existing variables.
ozone <- mutate(ozone, Date.Local = as.Date(X1st.Max.DateTime))

# Splits the data into levels of time
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>%
           mutate(month = factor(months(X1st.Max.DateTime), levels = month.name)) %>%
           group_by(month) %>%
           summarize(ozone = mean(Sample.Duration))