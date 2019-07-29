#
#
# This code files contains practicing Matrices & Dataframes manipulation and Vectors.
#
#
#




# Working on data such as Matrices and Dataframes in R

x <- 2:6
y <- 7:11
z <- 12:116

# Create a matrix where x, y and z are columns
# The cbind() command takes a sequence of vector, matrix or data-frame arguments and combine by columns or rows, respectively
cbind(x, y, z)

# Create a matrix where x, y and z are rows
rbind(x, y, z)

# Creating a matrix with numeric and character columns with data in R
cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))


# Create a matrix of the integers from numbers 1 to 120 with 10 rows and 12 columns
matrix(data = 1:120,
       nrow = 10,
       ncol = 12)

# Lets create a matrix with 12 rows and 10 columns
matrix(data = 1:120,
       nrow = 12,
       ncol = 10)

# Lets create a matrix with 12 rows and 10 columns, but fill by row instead of columns
matrix(data = 1:120,
       nrow = 12,
       ncol = 10,
       byrow = TRUE)

# Creating a dataframe of survey data with rows and columns
# The date.frame command is used to create data frames, tightly coupled collections of variables which share many of the properties of matrices and of lists, used as the fundamental data structure by most of R's modeling software
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))

# Display the dataframe data
survey

# structure of the survey dataframe
str(survey)

# Creating a dataframe of survey data WITHOUT factors
# stringsAsFactors - logical: should character vectors be converted to factors? The 'factory-fresh' default is TRUE, but this can be changed by setting options(stringsAsFactors = FALSE)
survey1 <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23),
                     stringsAsFactors = FALSE)

# Displays the structure of the survey1 as a dataframe
str(survey1)
#factors are missing

#The head() command displays the top few rows
head(survey)

#The tail() command displays the last few rows
tail(survey)

# View() opens the entire dataframe in a new window similar to a spreadsheet style format
View(survey)

# Displays the summary statistics of the survey data
# The summary is a generic function used to produce result summaries of the results of various model fitting functions.
summary(survey)

# Print additional structural information about the data frame
str(survey)

# Displays the names of columns in dataframe "ToothGrowth"
names(ToothGrowth)

# Gets the len column data of dataframe "ToothGrowth"
ToothGrowth$len

# Gets the mean of the len column of ToothGrowth
# The mean() command gets the (trimmed) arithmetic mean.
mean(ToothGrowth$len)

# table of the supp column of ToothGrowth
# The table() command uses the cross-classifying factors to build a contingency table of the counts at each combination of factor levels
table(ToothGrowth$supp)

# Gets the top values of the columns len AND supp columns of the dataframe ToothGrowth
head(ToothGrowth[c("len", "supp")])

# Add a new column called sex1 to survey data frame
survey$sex1 <- c("m", "m", "f", "f", "m")

# Changes the name of 1st column of survey dataframe to "a"
names(survey)[4] <- "a"

# Changes the column name from age to age.years using logical indexing
names(survey)[names(survey) == "age"] <- "years"

# Gets the row 1 data from the data frame survey
survey[1, ]

# Gets the column 4 data from the data frame survey
survey[, 4]

# Rows 1:5 and column 2
# Gets the data from the data frame survey for rows 1 to 5 and 2nd column
survey[1:5, 2]

# Gets the data from the data frame ToothGrowth for rows 1 to 6 and 2nd column
ToothGrowth[1:6, 2]

# Gets the data from the data frame ToothGrowth for rows 1 to 5 and columns 1 and 3
ToothGrowth[1:5, c(1,3)]


#Gets the data from  10th row and all columns from the data frame ToothGrowth
ToothGrowth[10, ]

# Creates a new data frame from ToothGrowth with only the rows where supp equals the value VC
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]

# Gets the rows of ToothGrowth where len < 20 AND supp == "VC" AND dose >= 5
# The subset command return subsets of vectors, matrices or data frames which meet conditions.
subset(x = ToothGrowth,
       subset = len < 20 &
         supp == "VC" &
         dose >= 5)

#Creates a subsettted dataframe called oj from the data frame ToothGrowth where supp equals the value OJ
oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")

# Gets the mean on the len from the data frame
mean(oj$len)

# Gets the data from the data frame survey
survey

# Uses index value for calculation
# Evaluate an R expression in an environment constructed from data, possibly modifying (a copy of) the original data.
with(survey, index / years ^ 2)


#working with vectors in R
# Load the library "tidyverse" into R
library(tidyverse)

#determine type of data
#The typeof() command determines the (R internal) type or storage mode of any object
typeof(letters)
typeof(1:10)

#Gets the list of data along with the length
x <- list("a", "b", 1:10)

#This is an example for logical comparison
1:10 %% 3 == 0
length(x)

#Examples of Numberic data
typeof(1)
typeof(1L)

#example of squareroot function
#The sqrt() function computes the square root of the specified float value.
x <- sqrt(2) ^ 2
# Displays the square root of the value
x


# Installs the "pryr" package to the session
install.packages("pryr")
# Loads the "pryr" package to the session
library("pryr")
#Gets the R object size
x <- "check object size."
pryr::object_size(x)

# The rep() command replicates the values in x
y <- rep(x, 1000)
pryr::object_size(y)

#The sample() command takes a sample of the specified size from the elements of x using either with or without replacement
x <- sample(20, 100, replace = TRUE)
#Logical comparison where data is greater than 10, summary and mean
y <- x > 10
#The sum() command returns the sum of all the values present in its arguments
sum(y)
#The mean() command is a generic function for the (trimmed) arithmetic mean.
mean(y) 

#check the data type of values
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))

#Example of scalar functions in R
sample(10) + 100
runif(10) > 0.5

#using Rep and Tibble functions
# The tibble() command is a trimmed down version of data.frame()
tibble(x = 1:4, y = rep(1:2, 2))

#assigning names to vectors
#The set_names() command sets Names In A Vector
set_names(1:3, c("a", "b", "c"))

#Subset the vectors using assignment functions
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]
x[c(-1, -3, -5)]

# Get the missing values in a vector
# The generic function is.na indicates which elements are missing
x[!is.na(x)]
# All even (or missing!) values of x
# Gets all the even numbers in a list
x[x %% 2 == 0]

#Gets the character subset for vector
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

#Example of recursive vectors in R
x <- list(1, 2, 3)
# Displays the vector
x

#Example of the multi type list in R
z <- list(list(1, 2), list(3, 4))

#Examples of setting attributes for vectors
#The attr() commmand Get or set specific attributes of an object.
x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
#The attributes() command accesses an object's attributes. The first form below returns the object's attribute list.
attributes(x)

#Examples of the generic functions understanding and applicationiin R
# Functions to convert between character representations and objects of class "Date" representing calendar dates.
as.Date
# Describes what a function in R does
methods("as.Date")
# Get a method for an S3 generic, possibly from a namespace or the generic's registry.
getS3method("as.Date", "default")

# Example of Augmenting vectors
#factors - designed to represent categorical data in R for vectors
# The function factor is used to encode a vector as a factor (the terms 'category' and 'enumerated type' are also used for factors)
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)

#Format the dates in R are numeric vectors that represent the number of days since 1 January 1970.
x <- as.Date("1971-01-01")
x <- lubridate::ymd_hm("1970-01-01 01:00")
#With unclass<- you can circumvent class dispatch on the assignment operator
unclass(x)

typeof(x)

attributes(x)

#Example of TimeZone Attributes
attr(x, "tzone") <- "US/Pacific"
# Displays the time zone attributes
x

#Tibbles are augmented lists with the class "tbl_df" + "tbl" + "data.frame", and column and row names attributes
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)
attributes(tb)
