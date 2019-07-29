#
#
# This code files contains practicing importing, saving, managing data, Workspace management and working directory.
#
#
#




#The ls() is used to show all the objects
#ls()  return a vector of character strings giving the names of the objects in the specified environment.
ls()

x <- c(1990)
y <- c(2012)

#The rm() is used remove objects x and y from the current R session or workspace
rm(x, y)

# Note: Once you run the rm() command to remove an object, it is lost until you add it back to the workspace

#The getwd() is used to get current working directory for the R Session
getwd() 

# To change the working directory 
setwd( "C:\Users\katta\Desktop\Harrisburg\Semester 2\Exploratory Data Analysis\Exploratory Data Analytics - Code Portfolio")

#The list.files() is used to list all the files in the working directory
list.files() 
#The command returned EDA - Code Portfolio Week 2.R since that is the only file in that folder 

# Saving objects x, y to an R Data file called Objects.RData
save(x, y, file = "Objects.RData") # saves the all objects containing data into a single file called Objects.RData

# Example of a data frame which stores data
FootBallTeam.df <- data.frame(id= 1:10,
                       gender = c("f","f","f","m","m","f","f","f","m","m"),
                       goal = c(9, 7, 5, 2, 1, 4, 5, 1, 3, 7))

goal.by.gender <- aggregate(goal ~ gender,
                          FUN = mean,
                          data = FootBallTeam.df)

#The t.test() command is used for the T Test on the FootballTeam data set
FootBallTeam.htest <- t.test(goal ~ gender,
                      data = FootBallTeam.df)

#The save() is used for saving above two objects as a new .RData file to the working directory
save(FootBallTeam.df, goal.by.gender, FootBallTeam.htest, 
     file = "Table1.RData")

#The save.image() command is used to save all the data in workspace
#DataImage.RData contains all objects in current WD
save.image(file = "DataImage.RData")

#The load() command is used to load data objects to the current session from the current working directory
load(file = "image.RData")

#mtcars is an inbuilt cars dataset in R to perform analysis
mtcars

# Using the mtcars dataset we will export data as .txt files by using the write.table() command
write.table(x = mtcars, 
            file = "mtcars.txt",  # saves the text file as mtcars.txt to the working directory
            sep = "\t")         # indicates that the delimiter is a tab

# The read.table() command is used to read text files into R
# Since we know that the file is tab-delimited one and, first row is a header row and also we will not be converting strings to factors
# Also when we don't specify the entire file path R searches current Working Directory(WD) 
ReadFootBallTeam <- read.table(file = "Table1.RData", sep = '\t', header = TRUE, stringsAsFactors = FALSE ) 

# Read the data from the internet
# reading files form a web read.table() function
googleData <- read.table(file = 'http://goo.gl/jTNf6P',
                      sep = '\t',
                      header = TRUE)

# Displays the data in R
googleData 

# Similar to the different types of file formats are there to read non-text file like Stata,SAS and SPSS use package foreign
install.packages("foreign")
# Also to read Excel files we can use package xlsx to read data into R
install.packages("xlsx")
# Using the read.table() command files can be converted into simple text first and then read into R




