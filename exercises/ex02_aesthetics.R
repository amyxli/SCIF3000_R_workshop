# -- EXERCISE 02: ALL ABOUT AESTHETICS ####

# By the end of this exercise we will:
# - understand aesthetic mappings in the aes() function
# - have made our first stylistic changes to axis + legend labels
# - know how to save a plot as an image.

# Aesthetic mappings describe how variables in the data are mapped to visual properties
# (aesthetics). Here we will play around with aesthetic mappings set in ggplot().
# Later on, we will see how they can be set in individual layers.

# Go ahead and clear your environment before you begin this exercise.

# Like in Exercise 1, there is already some code to get you started,
# but you will need to fill in the MISSING_BITS!

# In other places, you're going to practice writing code completely on
# your own! This will be flagged by a line saying # ----  YOUR CODE HERE ---- #.

# Let's begin! ####

# Make sure we have the relevant packages loaded (tidyverse and here)
# and the beaches data imported

library(MISSING_BIT)
library(MISSING_BIT)

beaches <- read_csv(here("data","MISSING_BIT"))

# Earlier on you created this line plot that depicts
# temperature over time:

# version 1
q <- ggplot(
  data = beaches,
  mapping = aes(x = date, y = temperature) # locations (x and y) are aesthetics
  ) +
  geom_line()

q

# Now let's try another version of this code, without specifying "data =" and
# "mapping ="

# version 2
q <- ggplot(
  beaches,
  aes(date, temperature)
  ) +
  geom_line()

q

# Notice: are these two plots different or the same?
# Hint: You can use the little blue arrows in the left upper corner of the plot panel to toggle between plots.

# Exercise 2.1 ####

# Let's bring some color to our plots!
# We want to highlight differences in temperatures by color as well.
# Change the plot above so that the colour aesthetic is *also* mapped
# onto the temperature variable (i.e., add another line to the
# mapping). What happens?

# Also -- notice that we are not assigning this plot to a variable,
# then having to print that variable for the plot to show up,
# like we did with plot (q). Instead,the plot is being printed
# straight away.

ggplot(
  data = beaches,
  mapping = aes(
    MISSING_BIT,
    MISSING_BIT,
    MISSING_BIT)
) +
  MISSING_BIT

# Exercise 2.2 ####

# Very cool! However, this colour mapping didn't really add that much
# information to our plot. But what if we could indicate seasons by colour?

# Hint 1: As a first try, instead of mapping the temperature variable onto the colour
# aesthetic, try mapping "season_name" onto the colour aesthetic.
# Does this work? What is happening here?

# Then, create a second plot where you try mapping "season"
# onto colour. Do they give the same results?


# Hint 2: Use glimpse(beaches) to check the data type of the
# season and season_name variables, respectively.

# Plot 1
ggplot(
  data = beaches,
  mapping = aes(
    x = date,
    y = temperature,
    colour = MISSING_BIT)
  ) +
  geom_line()

# Plot 1
ggplot(
  data = beaches,
  mapping = aes(
    x = date,
    y = temperature,
    colour = MISSING_BIT)
  ) +
  geom_line()

# What is happening in the first plot?
# When we then add geom_line(), ggplot2 draws a line for each GROUP.
# By default, ggplot2 tries to guess which data points belong to the same
# group.

# "season_name" is a discrete variable, so ggplot guessed that there
# were four groups, and drew a line for each of the four possible groups.
# however, "season" contains the same information in a continuous form
# (numbers 1 to 4; data type is NUMERIC). So here, ggplot does not try to
# divide our data points into different groups.

# Exercise 2.3 ####

# We just learned that ggplot can be quite particular when it comes to
# discrete vs continuous variables. Most of the time, we can make great use
# of that.

# Suppose I want to use season_name for the colour aesthetic, such that
# each season has its own color.

# But instead of one line for each season, I want every distinct month
# (e.g. Jan 2013, Feb 2013, etc) to be drawn on a different line.
# How do I do this?


# Hint 1: Watch out for the different between the different
# month-related variables. In the console, type beaches$month,
# then see R's suggestions which show the 3 different variables
# starting with the string "month".

# Hint 2: have a look at the "group = " mapping option

# Hint 3: You can change the size of the plot panel to view the plot in more detail.


ggplot(
  data = beaches,
  mapping = aes(
    x = date,
    y = temperature,
    BROKEN_BIT = BROKEN_BIT,
    BROKEN_BIT = BROKEN_BIT)
  ) +
  geom_line()


# Exercise 2.4 ####

# Notice that in the previous plot, every distinct month
# is drawn on its own line. Let's say I only want one line with
# discrete colours based on "season_name" - that means we need to figure out a
# way to prevent ggplot from grouping our data into 4 different groups.
# What should I map to the "group" aesthetic to force ggplot to keep all
# data points in one group?

# Hint: mapped aesthetics can be constants.

ggplot(
  data = MISSING_BIT,
  mapping = MISSING_BIT(
    MISSING_BIT = MISSING_BIT,
    MISSING_BIT = MISSING_BIT,
    MISSING_BIT = MISSING_BIT,
    MISSING_BIT = MISSING_BIT)
) +
  geom_line()


# Exercise 2.5 ####

# Look at the legend for the colour aesthetic. R automatically organises the
# seasons alphabetically. But, it would make more sense to order them
# chronologically, starting with the first season of the year (i.e., summer).

# Let's head() the data again to see how season and season_name relate.

head(MISSING_BIT)

# Notice that we annoyingly can't view the "season_name" variable here.
# Now use glimpse() to see all of the columns. Notice what's different
# here from using head().

glimpse(MISSING_BIT)

# Great, it looks like "season" has four integer values 1 to 4,
# corresponding to summer, autumn, winter, and spring, respectively
# This is exactly the order we want in our legend.
# What we need is a way to tell ggplot to use the order coded
# in the "season" variable.

# Use the "reorder" function to order the "season_name" categories using
# the "season" variable. You do not need to alter the data set, you
# can do this when mapping the "colour" aesthetic.

ggplot(
    data = MISSING_BIT,
    mapping = MISSING_BIT(
      x = MISSING_BIT,
      y = MISSING_BIT,
      colour = reorder(MISSING_BIT, MISSING_BIT),
      MISSING_BIT = MISSING_BIT)
    ) +
  MISSING_BIT

# Exercise 2.6: Improving labels ####

# Great, the legend lables are in order!
# But notice that the legend label is now very ugly...

# This can be fixed using the labs() function. We can use the labs()
# function to label our different aesthetics.
# Note that the x and y axis labels correspond to two of the
# location aesthetics (x and y) in our plot, while the legend also
# corresponds to an aesthetic: "colour".

# What do you need to do to fix the legend?
# When you're done, save the plot to the variable (r).

r <- ggplot(
  data = MISSING_BIT,
  mapping = MISSING_BIT(
    x = date,
    y = temperature,
    colour = reorder(MISSING_BIT, MISSING_BIT),
    MISSING_BIT = MISSING_BIT)
  ) +
  geom_line() +
  labs(
    x = MISSING_BIT,
    MISSING_BIT = MISSING_BIT,
    MISSING_BIT = MISSING_BIT
  )

r

# Exercise 2.7: Saving plots as images ####

# Great, we now have a very nice plot!
# We also now know how to assign this plot to a variable.

# But, what if I'd like it saved as an image? You may have
# noticed that under the "plots" tab, there is an "export"
# button that lets us do so.

# But what if I don't want to go through the code, stop at
# every section where a plot is produced, run it so that
# the plot appears in the "plots" tab, then manually "export" it?

# We can do this via another simple line of code.
# Let's assign your latest new and improved code to the variable
# named "r".

ggsave(
  here("plots", "r.jpg"), # what should the plot be saved as? (i.e., both path, and file name)
  r,                      # which plot do we want to save?
  width = 5, height = 3   # what size should the plot have?
  )

# Have a look at the plots folder to see if out last plot is in there.

# Then, have a go at saving the first plot you made at the beginning of this
# exercise (q). Try playing around with the settings as well as the
# file type (e.g., width/height, or instead of .jpg, try use another extension)
# and see what happens.

# ---- YOUR CODE HERE ---- #

# Congratulations! ####

# That's the end of this exercise! Hopefully you now have a better idea
# of aesthetic mappings in R.

# Before you start on the next exercise script, please read the
# relevant section of the slides (exercise 3: geoms).
