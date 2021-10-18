# -- EXERCISE 01: INTRODUCTION ####

# By the end of this exercise we will:
# - understand how to install and load packages
# - know how to read in data
# - have written our first few lines of code.

# Let's begin! ####

# First, we need to install some packages that we need.
# Their names are "tidyverse" and "here".

# If you haven't done this already...
# Do so by running the line below; highlight the code
# you want to run, then hit command + return

# install.packages("tidyverse")
# install.packages("here")

# (Also notice how when you highlight *this* line, nothing
# is evaluated in the console. That's because the line
# starts with a #, indicating a comment.)

# Are the packages are successfully installed?
# Check the "packages" panel on the right hand side to
# see if they're there. If so, hooray!

# Now we make sure we have the relevant packages loaded.
# We can tick the boxes next to the package's name under the "packages" panel.
# Or, we can load the packages using code. This is the easiest (and also
# makes your code shareable, since you'll make sure that your
# collaborators are also loading the packages).

library(tidyverse)  # library() tells R to load the package named inside the brackets
library(here)       # no double quotes are needed around package name

# We want to now load the beaches data into our environment.
# i.e., import the data and assign to variable "beaches"

# First we must tell R exactly where the data file is.

file <- here("data","sydneybeaches.csv")
file # print this by highlighting the line and running it.
     # compare your console output to another student's

beaches <- read_csv(file) # the read_csv function helps us... read the csv file

# Exercise 1.0 ####

# Before we start getting into visualisation, let's first take
# a look at our Environment panel. What do you see?

# Try clicking on "beaches" in the Environment panel to
# view the full dataset.

# Exercise 1.1: Your first scatterplot ####

# This is a stripped down version of the plot that
# we've used in the slides (p). It is a scatter-plot showing
# temperature on the x-axis and rainfall on the y-axis. First,
# run this section of code and see what happens:

p <- ggplot(data = beaches,
            mapping = aes(x = temperature, y = rainfall)
            ) +
  geom_point()

p

# Now it's your turn: we want to visualise temperature
# as a function of time (date). We can probably agree this
# is a more interesting visualisation!

# Make a new scatter-plot, stored in the variable q,
# that plots temperature as a function of date.

# There is already some code to get you started,
# but you will need to fill in the MISSING_BITS.
# Have a go!

q <- ggplot(data = beaches,
            mapping = aes(x = MISSING_BIT, y = MISSING_BIT)
            ) +
  geom_point()

q


# Exercise 1.2: Your first line plot ####

# Now overwrite the scatter-plot (q) with a line plot, plotting
# temperature as a function of date

q <- ggplot(data = beaches,
            mapping = aes(x = MISSING_BIT, y = MISSING_BIT)
) +
  geom_point()

q


# Exercise 1.3: Adding titles ####

# Next we need to add a title to your previous plot.
# Create a new plot (r) that uses the labs() function to add
# an informative title to the plot.

# Hint: any text strings need to be wrapped in quotes;
# or else R thinks that you are referring to a variable (stored
# within the environment).

r <- ggplot(data = MISSING_BIT,
            mapping = aes(x = MISSING_BIT, y = MISSING_BIT)
) +
  MISSING_BIT +
  labs(title = MISSING_BIT)

r


# That's it! This one is short!

# Before you start on the next exercise script, please read the
# relevant section of the slides (exercise 2: all about aesthetics).
