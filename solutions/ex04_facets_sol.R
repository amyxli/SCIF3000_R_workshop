# -- EXERCISE 04: FACETS ####

# By the end of this exercise we will:
# - understand how to partition data visualised into multiple panels
# - ... and how this can be combined with data and aesthetic mappings.
# Also learn a little about data types.

# Let's go ahead and clear our environment before we start!

# Make sure we have the relevant packages loaded
# and the beaches data imported

library(tidyverse)
library(here)

beaches <- read_csv(here("data","sydneybeaches.csv"))

# Exercise 4.1: First facets ####

# let's start this exercise off the way we did the last:
# with our simple temperature over time scatter plot,

a <- ggplot(data = beaches,
            mapping = aes(x = date,
                          y= temperature
            )
) +
  geom_point()

a

# Wouldn't it be great to have a look at temperatures in each of
# the months?

# Use facet_wrap to plot the data separately as a function
# of month_name. (i.e., split the data up into panels by
# month_name). Store this plot in the variable b
# Try and make this code as succinct as possible.

# Then, store this plot in the variable b

# Solution:

b <- a +
  facet_wrap(~month_name)

b

# Exercise 4.2 ####

# The months are out of order! R had put them in
# alphabetical order instead of chronological order.
# Use the reorder function, so that the levels of
# month_name are ordered by month.

# Hint: check back at exercise 2 where we did
# something similar.

# Overwrite (b) with this new plot.

# Ask: What does the facetting do to your
# visual impression of plots (b) relative to the
# original plot (a)? Do they emphasise different
# patterns in the data?

### YOUR-CODE-HERE ###

# Solution
b <- a +
  facet_wrap(~reorder(month_name, month))

b

# Exercise 4.3 ####

# Let's keep on working on plot "b".
# Let's visualise trends in the data by adding a geom_smooth to this.

# geom_smooth will fit a line to our data points and this could be
# done using different methods.
# Try it in the default version, and then with explicitly stating
# "method = "lm".


# Notice that the smoothing is different in each
# facet. The facetting variable has grouped
# the data.

# Solution:

# default
b +
  geom_smooth()

# the default is equivalent to:
b +
  geom_smooth(method = "loess")

# with method = "lm"
b +
  geom_smooth(method = "lm")


# Exercise 4.4 ####

# Now, suppose we want to visualise how temperatures
# change *throughout* the year across the 12 months, separately
# for each year.

# Can you write some code below that will let you do this?

# Hint: we want temperature trends across the 12 months,
# facetted by year

### YOUR-CODE-HERE ###

# Solution

ggplot(beaches, aes(month, temperature)) +
  geom_point() +
  facet_wrap(~year)

# Exercise 4.5 ####

# What do you notice about the months on the x-axis?
# glimpse the beaches data and notice the data type
# indicated in <> of month. Do a quick google
# to see what this (and the other data types) means.
# Try also running this: glimpse(beaches$month).
# to glimpse only the month variable of beaches.

# Then, try wrapping month (mapped onto your x aesthetic)
# inside the brackets of as.factor()
# and observe what happens.

# Hint: run ?as.factor in the console, to bring up
# its documentation which will explain what it does.

ggplot(beaches, aes(as.factor(month), temperature)) +
  geom_point() +
  facet_wrap(~year)

# Congratulations! ####

# That's the end of this exercise! We're now able to make all kinds
# of plots with R, so let's now move onto DATA WRANGLING.

# Before you start on the next exercise script, please take a break.
# Then, read the relevant section of the slides
# (exercise 5: data wrangling) before you begin (we may also
# go through this in class).
