#
#
# This code files contains practicing data visualization using functions such as aes, geom, facets and positions.
#
#
#




# Load the library "tidyverse" into R
library(tidyverse)

# Load the library "ggplot2" into R
library(ggplot2)

# Creating a graphical plot using ggplot
# Aesthetic mappings describe how variables in the data are mapped to visual properties (aesthetics) of geoms. Aesthetic mappings can be set in ggplot2() and in individual layers
# ggplot() initializes a ggplot object. It can be used to declare the input data frame for a graphic and to specify the set of plot aesthetics intended to be common throughout all subsequent layers unless specifically overridden
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#Creating a resuable template to use it in the next lines of the code
#ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# Plot to map colors of points to the class variable to display class of car
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

#Plot to map the class to size of a car
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))


#Plot to map class to the alpha aesthetic which controls the transparency of the points in the plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

#Plot to map class to the alpha aesthetic which controls the shape of the points in the plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#Plot using facet_wrap() to facet the plot by a single variable - class  
# The facet_wrap wraps a 1d sequence of panels into 2d.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#Plot using facet_wrap() to facet the plot by a 2 variable
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

#The geom is the geometrical object that a plot uses to represent data
# The point geom is used to create scatterplots. The scatterplot is most useful for displaying the relationship between two continuous variables. It can be used to compare one continuous and one categorical variable, or two categorical variables
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# The geom_smooth command aids the eye in seeing patterns in the presence of overplotting. geom_smooth() and stat_smooth() are effectively aliases: they both use the same arguments
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# This function can be used to add legends to plots. Note that a call to the function locator(1) can be used in place of the x and y arguments
# Hide the legend using show.legend as false in the plot
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# Plot using multiple geoms functions in the same plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#The bar geom is used to produce 1d area plots: bar charts for categorical x, and histograms for continuous y
#Plot using bar geom
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

#Plot used to override the default mapping from transformed variables. display a bar chart of proportion
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# The stat_summary allows for tremendous flexibilty in the specification of summary functions. The summary function can either operate on a data frame (with argument name fun.data) or on a vector (fun.y, fun.ymax, fun.ymin)
# Plot using stat_summary() to summarise the y values for each unique x value
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  ))

#Plot using coloring bar charts using colors to display the data
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

#This plot stacks bars automatically using clarity
#The plot is using identity to know the exact position of each object    
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
geom_bar(fill = NA, position = "identity")

#This plot uses dodge for the position to place overlapping objects directly beside one another.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")


#Plot used to flip x and y using coord_flip
# Flip cartesian coordinates so that horizontal becomes vertical, and vertical, horizontal. This is primarily useful for converting geoms and statistics which display y conditional on x, to x conditional on y.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

