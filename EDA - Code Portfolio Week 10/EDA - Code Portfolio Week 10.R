#
#
# This code files contains practicing K means clustering, clustering distances, Heirarchies and its types and optimal clusters.
#
#
#




# Perform k-means clustering on a data matrix in R
#Kmeans algorithm
#K Means Clustering is an unsupervised learning algorithm that tries to cluster data based on their similarity. 
#Unsupervised learning means that there is no outcome to be predicted, and the algorithm just tries to find patterns in the data. In k means clustering, we have the specify the number of clusters we want the data to be grouped into. 
#The algorithm randomly assigns each observation to a cluster, and finds the centroid of each cluster. 
#Then, the algorithm iterates through two steps:
#1. Reassign data points to the cluster whose centroid is closest.
#2. Calculate new centroid of each cluster.

#Below code will simulate some data from three clusters for K means

#setting the seed to 1234
#set.seed in the simEd package allows the user to simultaneously set the initial seed for both the stats and simEd variate generators.
set.seed(1234)

#Let us create a dataframe x and y with random values
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)

#Now plotting a graph for x and y dataframes
plot(x, y, col = "blue", pch = 19, cex = 2)

#Then setting x and y coordinates
# text draws the strings given in the vector labels at the coordinates given by x and y. y may be missing since xy.coords(x, y) is used for construction of the coordinates.
text(x + 0.05, y + 0.05, labels = as.character(1:12))

#creating the data frame from x and y generated earlier
dataFrame <- data.frame(x, y)

#using kmeans to implement K means algorithm 
# Perform k-means clustering on a data matrix in R
kmeansObj <- kmeans(dataFrame, centers = 3)

# Diplaying names in the Kmeans object
names(kmeansObj)

# Check for eacch cluster each data point got assigned using cluster
kmeansObj$cluster

#Let us build a heatmap
#setting the seed to 1234
set.seed(1234)

#Now building a dataframe with sample data
#as.vector returns a vector of cell values. For a RasterLayer it is equivalent to getValues(x).
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]

#Now implementing a kmeans solution
kmeansObj <- kmeans(dataMatrix, centers = 3)

#Now develop a image plot using the datamatrix and the kmeans object clusters
#The par command can be used to set or query graphical parameters. Parameters can be set by specifying them as arguments to par in tag = value form, or by passing them as a list of tagged values.
par(mfrow = c(1, 2))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n", main = "Original Data")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n", main = "Clustered Data")

# Load the library "tidyverse" into R
library(tidyverse) 

# Load the library "cluster" into R
library(cluster)    

# Install the package "factoextra" into R
install.packages("factoextra")

# Load the library "factoextra" into R
library(factoextra) 

# Get the USArrests dataset
df <- USArrests

#Let us remove any missing value from the dataframe
df <- na.omit(df)

#standardize the data using scale function in R
# The scale command is generic function whose default method centers and/or scales the columns of a numeric matrix.
df <- scale(df)

#Clustering methods classify data samples into groups of similar objects. This process requires some methods for measuring the distance or the (dis)similarity between the observations
#get_dist(): Computes a distance matrix between the rows of a data matrix. Compared to the standard dist() function, it supports correlation-based distance measures including "pearson", "kendall" and "spearman" methods
distance <- get_dist(df)
#fviz_dist(): Visualizes a distance matrix
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
# Display top rows of data
head(df)

#Use the kmeans algorithm using kmeans function
k2 <- kmeans(df, centers = 2, nstart = 25)
# Get the structure of the Kmeans data
str(k2)

#Displays the cluster plot
fviz_cluster(k2, data = df)

#Plot to display the standard pairwise scatter plots to illustrate the clusters data
df %>%
  as_tibble() %>%
  mutate(cluster = k2$cluster,
         state = row.names(USArrests)) %>%
  ggplot(aes(UrbanPop, Murder, color = factor(cluster), label = state)) +
  geom_text()

#Build the mulitple kmean solutions and assign to variables
k3 <- kmeans(df, centers = 3, nstart = 25)
k4 <- kmeans(df, centers = 4, nstart = 25)
k5 <- kmeans(df, centers = 5, nstart = 25)

# Display various plots to compare the kmeans output
p1 <- fviz_cluster(k2, geom = "point", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = df) + ggtitle("k = 5")

# Load the library "gridExtra" into R
library(gridExtra)

#Arrange Multiple Grobs On A Page for better display
grid.arrange(p1, p2, p3, p4, nrow = 2)


# Build the dissimilarity matrix
d <- dist(df, method = "euclidean")

# Displays the hierarchical clustering using Complete Linkage
# Hierarchical cluster analysis on a set of dissimilarities and methods for analyzing it.
hc1 <- hclust(d, method = "complete" )

# Plot the obtained dendrogram from the cluster analysis
plot(hc1, cex = 0.6, hang = -1)

# Compute with agnes result
# The agnes command computes agglomerative hierarchical clustering of the dataset.
hc2 <- agnes(df, method = "complete")

# Agglomerative coefficient
# Computes the "agglomerative coefficient", measuring the clustering structure of the dataset.
hc2$ac

# methods to assess
m <- c( "average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")

# functions to compute coefficients
ac <- function(x) {
  agnes(df, method = x)$ac
}

map_dbl(m, ac)


# Get the divisive hierarchical clustering
hc4 <- diana(df)

# Divise coefficient; amount of clustering structure found
hc4$dc

# plotting the dendrogram
pltree(hc4, cex = 0.6, hang = -1, main = "Dendrogram of diana")


# use cutree to cut agnes() tree into 4 groups
# Cutree command cuts a dendrogram tree into several groups by specifying the desired number of clusters k(s), or cut height(s).
hc_a <- agnes(df, method = "ward")
cutree(as.hclust(hc_a), k = 4)

# use cutree to Cut diana() tree into 4 groups
# The diana command computes a divisive hierarchical clustering of the dataset returning an object of class diana
hc_d <- diana(df)
cutree(as.hclust(hc_d), k = 4)

#Determining the number of optimal Clusters
# Partitioning methods, such as k-means clustering require the users to specify the number of clusters to be generated

#fviz_nbclust(): Dertemines and visualize the optimal number of clusters using different methods: within cluster sums of squares, average silhouette and gap statistics.
#Elbow Method
fviz_nbclust(df, FUN = hcut, method = "wss")
#Average Silhouette Method
fviz_nbclust(df, FUN = hcut, method = "silhouette")

#Gap static method
# The clusGap() command calculates a goodness of clustering measure, the "gap" statistic.
gap_stat <- clusGap(df, FUN = hcut, nstart = 25, K.max = 10, B = 50)
#fviz_gap_stat(): Visualize the gap statistic generated by the function clusGap() [in cluster package]. The optimal number of clusters is specified using the "firstmax" method (?cluster::clustGap).
fviz_gap_stat(gap_stat)