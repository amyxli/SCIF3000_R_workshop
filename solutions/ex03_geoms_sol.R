# -- EXERCISE 03: A UNIVERSE OF PLOTS WITH GEOMS ####

# By the end of this exercise we will:
# - understand what a geom (geometric object) is ...
# - ... and how this can be combined with data and aesthetic mappings;
# - be more familiar with the concept of "layering" in ggplot2;
# - know how to create boxplots and violin plots...
#  ... in addition to scatterplots + line graphs.

# Let's go ahead and clear our environment before we start!

# Make sure we have the relevant packages loaded
# and the beaches data imported

library(tidyverse)
library(here)

beaches <- read_csv(here("data","sydneybeaches.csv"))

# Let's begin! ###

# So far we have created a basic scatterplot in exercise 1,
# and also some very pretty line graphs in exercise 2 plotting
# temperature as a function of date... fantastic!

# We will next learn how to create other types of plots.
# But first, let's visit the idea of "layering", which you may
# already have started noticing.

# Exercise 3.1 -- Layers and geoms ####

# I have set up the mappings for the "base layer" of the plot from
# Ex 2.6 that visualises how temperatures vary from day to day.
# Notice how the "base layer" contains a call to ggplot(),
# supplying default data and aesthetic mappings

a <- ggplot(data = beaches,
       mapping = aes(x = date, y = temperature)
)

# Try and print a. What do you notice?
a

# This is a plot with no layers. We can save it to a variable as we have
# done here, and add to it as needed.

# Now we will "add" a geom_point() layer. What do you notice this does?

a + geom_point()

# Instead of a geom_point() layer, can you try adding a geom_line()?
# What do you notice -- does this plot look familiar?

# Solution:
a + geom_line()

# Exercise 3.2: From scatter to box plots ####

# Imagine that, instead of visualising how temperatures vary
# from day-to-day in Exercise 2.6,  we want a broader visual summary
# of how temperatures vary from year to year.

# How would you change the base layer, the variable a, so that
# you supply the appropriate aesthetic mappings?

# After assigning the base layer to the variable b, try and
# represent this data in a scatter plot.

# Solution:

b <- ggplot(data = beaches,
       mapping = aes(x = year, y = temperature)
)

b + geom_point()

# Now try and represent the data in a boxplot by adding the layer
# geom_boxplot() instead of geom_point(). What do you notice?
# Have a look at the console!

# Solution:

b + geom_boxplot()

# Let's fix the plot up according to the warning message in the console.
# Go ahead and overwrite the b variable, so that the group aesthetic
# is correctly set. Then, create a plot where each year's
# temperatures is summarised by a boxplot.

# Solution:

b <- ggplot(data = beaches,
            mapping = aes(x = year,
                          y = temperature,
                          group = year)
)

b + geom_boxplot()

# Exercise 3.3: Combining different types of plots ####

# Let's say we love the summary this new boxplot provides,
# but are missing the fine-grained information provided by
# the individual data points in a scatter plot.

# After all, box plots are nice but don't say much visually
# about the density of data at a location (e.g., how many
# data points cluster around temperature of 30 degrees for
# a given year).

# Using our knowledge of layering and geoms, let's
# try and create a plot that combines the boxplots and
# the individual data points.

b + geom_point() +  geom_boxplot()

# What do you notice? What happens if you reverse the order
# in which the two geoms are added?

# Solution:

b + geom_boxplot() + geom_point()

# Exercise 3.4: Playing with geom details ####

# You might be thinking: that's great we have the individual data
# points presented together with our box plots -- but aren't the
# points really ugly?

# Indeed. Such ugliness with visualising data points will
# happen when have a discrete x aesthetic, but a continuous
# y aesthetic.

# To make it better, we can add "jitter" to the position of points.
# Try comparing the two below, and then play around with the width setting.

b + geom_boxplot() + geom_point(position = "jitter") # too much jittering!

b + geom_boxplot() + geom_jitter(width = 0.2) # geom_jitter lets us customise jitter

# Try changing the width argument to see what happens.
# Paste `?geom_point` into the console to see what other options geom_point gives you.

# Exercise 3.5: Visualising density of data ####

# Let's stay with our current example, with a discrete x aesthetic
# and continuous y aesthetic, just a little bit longer.

# The ggplot2 package comes with many options of visualising
# the density of points at each location.

# Compare these two plots below to each other. Which do you
# like better? Why?

# version 1
b + geom_boxplot()

# version 2
b + geom_violin()

# Exercise 3.6: More violins ####

# The violin plot is very useful - let's play around with it a bit more!
# What if we add another aesthetic to the violin plot to make each `violin` have
# a different color depending on `year` ?  Explore the 'fill' aesthetic!

# Alter the code for the violin plot example, so
# that the violin plots also have a fill aesthetic that is
# mapped onto year.

# Solution

b3 <- b + geom_violin(aes(fill = year))

# Exercise 3.7: Playing with geom details ####

# This time I've set up the mappings (i.e., base layer) for a SLIGHTLY
# different plot. What do you notice this is showing us?

# Notice that in contrast to the previous example, here,
# x and y aesthetics are both continuous.

c <- ggplot(
  data = beaches,
  mapping = aes(
    x = day_num,
    y = temperature,
    group = year,
    colour = year
  )
)


# Now look at what this code produces. Is this plot a good
# easy to read? If not, what steps might you consider taking?
# Try some out!

# e.g., How could you maybe get rid of the error bars?
# And is there a way to collapse all the separate regressions
# into a single one?

c +
  geom_point(size = 2) +
  geom_smooth()


# Hint 1: run ?geom_smooth in the console to bring up the
# "help" page (documentation) for this function.
# Have a go at changing some of the arguments.

# Solution

# Plot 1: get rid of the ribbons that show the error bars
c +
  geom_smooth(se = FALSE) +
  geom_point(size = 2)

# Plot 2: We could take this one step further and collapse
# all the separate regressions into a single one. We can
# do that by changing the "group" aesthetic, for the
# geom_smooth() layer:

c +
  geom_smooth(
    mapping = aes(group = 1),
    se = FALSE) +
  geom_point(size = 2)

# Exercise 3.8: More geoms ####

# The ggplot2 package comes with a very wide
# variety of different geoms we can use. For instance, when
# the x and y aesthetics are both continuous, we have some
# options for visualising the density of points at each
# location.

# Here is one:

d <- ggplot(
  data = beaches,
  mapping = aes(
    x = day_num,
    y = temperature
  )
)

# What is this plot showing us?

# Now try both of these out:

# (Hint: R might complain that you need to install the package "hexbin" in order to use
# geom_hex. Good thing you know how to do this already!)

# Solution:

install.packages("hexbin")
library(hexbin)

d + geom_bin2d()

d + geom_hex()

# Which do you prefer? Are there things we could do better
# with these plots?

# Congratulations! ####

# That's the end of this exercise!

# Before you start on the next exercise script, please read the
# relevant section of the slides (exercise 4: facets).
