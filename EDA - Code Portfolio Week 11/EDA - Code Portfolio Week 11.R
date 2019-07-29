#
#
# This code files contains practicing Principal Component Analysis, Eigen values & vectors and interpreting PCA plots.
#
#
#





#importing and installing libraries for the R session
# Install the "devtools" package
install.packages("devtools")
# Install the "Rcpp" package
install.packages("Rcpp")
# Load the library "devtools" into R
library("devtools")
# Install the "ggbiplot" package from Github
install_github("vqv/ggbiplot")
# Load the library "ggbiplot" into R
library(ggbiplot)

#Principal component Analysis
# Performs a principal components analysis on the given data matrix and returns the results as an object of class prcomp

#passing mtcars numerical data into prcomp function for prinical component analysis
mtcars.pca <- prcomp(mtcars[,c(1:7,10,11)], center = TRUE,scale. = TRUE)

#Displays the summary of prcomp function data of the mtcars dataset
summary(mtcars.pca)

#Displays the structure of the dataset
str(mtcars.pca)

#plot the Principal component Analysis result
ggbiplot(mtcars.pca)

#Add rownames to the dataset
ggbiplot(mtcars.pca, labels=rownames(mtcars))

#Understanding the results by classifying them into 3 categories
mtcars.country <- c(rep("Japan", 3), rep("US",4), rep("Europe", 7),rep("US",3), "Europe", rep("Japan", 3), rep("US",4), rep("Europe", 3), "US", rep("Europe", 3))

# Plot the results for better understanding
# ellipse - draw a normal data ellipse for each group?
ggbiplot(mtcars.pca,ellipse=TRUE,  labels=rownames(mtcars), groups=mtcars.country)

# Plot other component by using the choices argument of the ggbiplot.
# choices - which PCs to plot
ggbiplot(mtcars.pca,ellipse=TRUE,choices=c(3,4),   labels=rownames(mtcars), groups=mtcars.country)

# Adding a circle to the center of the dataset using circle dataset in the ggbiplot.
# circle - draw a correlation circle? (only applies when prcomp was called with scale = TRUE and when var.scale = 1)
ggbiplot(mtcars.pca,ellipse=TRUE,circle=TRUE, labels=rownames(mtcars), groups=mtcars.country)

#Adding the scaling for the samples such as obs.scale and var.scale to the dataset
# scale - covariance biplot (scale = 1), form biplot (scale = 0). When scale = 1, the inner product between the variables approximates the covariance and the distance between the points approximates the Mahalanobis distance
# obs.scale - scale factor to apply to observations
# var.scale - scale factor to apply to variables
ggbiplot(mtcars.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(mtcars), groups=mtcars.country)

#Removing the arrows in the plot using var.axes
# var.axes - draw arrows for the variables?
ggbiplot(mtcars.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,var.axes=FALSE,   labels=rownames(mtcars), groups=mtcars.country)


#Display a plot by specifiying the colors, adding a title, specifying the theme and moving the legend
ggbiplot(mtcars.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(mtcars), groups=mtcars.country) +
scale_colour_manual(name="Origin", values= c("forest green", "red3", "dark blue"))+ggtitle("PCA of mtcars dataset")+theme_minimal()+theme(legend.position = "bottom")

#Adding a spacecar to mtcars dataset to create a new dataset mtcarsplus
spacecar <- c(1000,60,50,500,0,0.5,2.5,0,1,0,0)
#The rbind() command will take a sequence of vector, matrix or data-frame arguments and combine by columns or rows, respectively.
mtcarsplus <- rbind(mtcars, spacecar)
mtcars.countryplus <- c(mtcars.country, "Jupiter")

#Implement the Principal Compnent Analysis using prcomp function
# The prcomp() command performs a principal components analysis on the given data matrix and returns the results as an object of class prcomp.
mtcarsplus.pca <- prcomp(mtcarsplus[,c(1:7,10,11)], center = TRUE,scale. = TRUE)

#Display a plot by specifiying the colors, adding a title, specifying the theme and moving the legend
ggbiplot(mtcarsplus.pca, obs.scale = 1, var.scale = 1, ellipse = TRUE, circle = FALSE, var.axes=TRUE, labels=c(rownames(mtcars), "spacecar"), groups=mtcars.countryplus)+
  scale_colour_manual(name="Origin", values= c("forest green", "red3", "violet", "dark blue"))+
  ggtitle("PCA of mtcars dataset, with extra sample added")+
  theme_minimal()+
  theme(legend.position = "bottom")

#Adding the scaling for the samples such as obs.scale and var.scale to the dataset
# scale - covariance biplot (scale = 1), form biplot (scale = 0). When scale = 1, the inner product between the variables approximates the covariance and the distance between the points approximates the Mahalanobis distance
# obs.scale - scale factor to apply to observations
# var.scale - scale factor to apply to variables
s.sc <- scale(t(spacecar[c(1:7,10,11)]), center= mtcars.pca$center)
#Apply the rotation of the sample which is being scaled
s.pred <- s.sc %*% mtcars.pca$rotation

#Bind the projected values to the rest of the dataframe
mtcars.plusproj.pca <- mtcars.pca
mtcars.plusproj.pca$x <- rbind(mtcars.plusproj.pca$x, s.pred)

#Display a plot by specifiying the colors, adding a title, specifying the theme and moving the legend
ggbiplot(mtcars.plusproj.pca, obs.scale = 1, var.scale = 1, ellipse = TRUE, circle = FALSE, var.axes=TRUE, labels=c(rownames(mtcars), "spacecar"), groups=mtcars.countryplus)+
  scale_colour_manual(name="Origin", values= c("forest green", "red3", "violet", "dark blue"))+
  ggtitle("PCA of mtcars dataset, with extra sample projected")+
  theme_minimal()+
  theme(legend.position = "bottom")