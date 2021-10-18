# -- EXERCISE 05: DATA WRANGLING WITH TIDYVERSE ####

# By the end of this exercise we will:
# - understand the %>% operator in tidyverse
# - use tidyverse to carry out basic data wrangling, including...
# -- select(), group_by(), summarise(), arrange(), filter(),
# -- as well as creating new variables with mutate() and
# -- combining it with ifelse()

# Let's go ahead and clear our environment before we start!

# Exercise 5.1: Set up ####

# As in previous exercises, there is already some code in some sections
# to get you started, but you will need to fill in the MISSING_BITS.

# In other places, you're going to practice writing code completely on
# your own! This will be flagged by a line saying # ----  YOUR CODE HERE ---- #.

# Our data wrangling relies on the `tidyverse`, `here`, and `skimr`
# packages. We have the first two already but not skimr.
# First install skimr; then load the three packages.

# Solution:
# install.packages("skimr")

library(tidyverse)
library(here)
library(skimr)

# Next, we need to load in the data!

# For the rest of our data wrangling exercise, we will be using a different,
# but related dataset to the one we used for data visualisation.

# This is the "sydneybeaches2.csv" file inside the "data" folder.
# Can you see it in your Files panel?

# We will use this dataset since it has a few more variables for us
# to play around with, including information about bacteria
# levels in the water at different beaches.

# Can you try using read_csv() and here() to load the data into R,
# and assign this to the variable beaches2?

# Solution:
beaches2 <- read_csv(here("data", "sydneybeaches2.csv"))

# Now that we've loaded the data, we should take a look at it.
# We can do this via code either by printing beaches2, or glimpsing it.
# The code below prints it but doesn't glimpse. Fix it so that it uses glimpse instead:

# Solution:
glimpse(beaches2)

# Have a look through the variables available in beaches2.
# Our goal for exercise 5 is to use the values for enterococci to inform
# our beach-going decisions.... but first, onto the pipe.

# Exercise 5.2: The %>% ####

# The second  exercise is about the pipe operator `%>%`.
# In the code below, we generate some random numbers and then
# calculates the mean. First, let's decide on how many numbers:

N <- 100

# Here is the nonpiped version of the code:

mean(rnorm(N))

# Now, try write a piped version of the same thing:

# Solution:
N %>% rnorm() %>% mean()

# Exercise 5.3: Using select() and arrange() ####

# Now we know how the pipe (%>%) works, it's time to dig into the data!

# We are interested in water safety at different beaches,
# so it would make sense to drop some unnecessary variables;
# i.e., council, longitude, lat, date, id, region, temperature, rainfall.

# Hint: check the slides associated with Exercise 5!

# Solution:
beaches2_cleaned <- beaches2 %>%
  select(-c(council, long, lat, date, id, region, temperature, rainfall))

# We will notice that entries are a little scrambled...
# Let's list the observations for each beach chronologically, using arrange().

# Have a think about the order of the arguments inside the arrange() function
# (i.e., the variables you place inside arrange()).
# What order makes most sense here? Can you fix the code below?

# Solution:

beaches2_cleaned <- beaches2_cleaned %>%
  arrange(site, year, month, day)

# Exercise 5.4: Using filter() and logical operators ####

# Now that entries from each beach are arrange chronologically,
# view the full beaches2_cleaned dataset by clicking on it
# in the Environment panel.
# What do you notice about the latest entries for each beach?
# Do entries appear to stop at a certain point?

# Turns out, collection was still continuing in October 2018, so
# data from this month onwards is unavailable, and this month
# itself has very few entries. So, let's exclude Oct 2018!

# Hint 1: Check the resulting dataset to make sure we're not dropping ALL
# entries from 2018, or ALL October entries regardless of year.
# Hint 2: check the logical operators slide.

# Solution:
beaches2_cleaned <- beaches2_cleaned %>%
  filter(!(year == 2018 & month == 10))

# We're probably not going to go for a swim during the colder months!
# Let's exclude all observations from May to September, inclusive, then
# store this in the beaches2_cleaned (i.e., overwrite the old data).
# Notice that month is simply the numeric equivalent of the month_name
# variable; whereas month_num is the month number across all the different years.

# Solution 1:
beaches2_cleaned <- beaches2_cleaned %>%
  filter(month < 5 | month > 9)

# Solution 2:
beaches2_cleaned <- beaches2_cleaned %>%
  filter(!(month >= 5 | month <= 9))

# Exercise 5.4: Using summarise() ####

# In this section what we're aiming to do is summarise the mean
# enterococci levels at each beach, since we want to get a sense of
# which beach is safest to swim at.

# Can you fill in the code below, so that we can calculate
# the mean enterococci levels at each beach (site)?

# Solution:
beach_means <- beaches2_cleaned %>%
  group_by(site) %>%
  summarise(
    enterococci = mean(enterococci)
  ) %>%
  ungroup()

# What do you notice here?

# Use the skim() function from skimr to see if there is anything that
# might be causing an issue here. (Hint: look under the n_missing column)

# Solution:
beaches2_cleaned %>% skim()

# Now set na.rm so that we don't get NAs outputted.

# Solution:
beach_means <- beaches2_cleaned %>%
  group_by(site) %>%
  summarise(
    enterococci = mean(enterococci, na.rm = TRUE)
  ) %>%
  ungroup()

# Say we don't really want this issue to annoy us again, and don't want to
# have to specify na.rm = TRUE all the time.
# Let's try and use the na.omit() to remove all incomplete cases of the beaches2.

beaches2_cleaned <- beaches2_cleaned %>% na.omit()

# Have a scroll or skim() the new cleaned data, and compare it to the old beaches2
# dataframe. What do you notice?

# Now let's try again, without using the na.rm = TRUE argument this time.

beach_means <- beaches2_cleaned %>%
  group_by(site) %>%
  summarise(
    enterococci = mean(enterococci)
  ) %>%
  ungroup()

beach_means

# Exercise 5.5: Saving cleaned data ####

# A small aside:
# Let's say we're happy with this current cleaned version of our
# data (beaches2_cleaned) and want to save it as a csv file
# to be used/shared later.

# Make a new folder at the base of your project (i.e., where
# the davaviz.Rproj file + data and plots folders are located)
# named "data_cleaned". It's good practice to keep our cleaned
# data in a folder separate from the "raw" unprocessed data.

# Then, run the code below to write a csv file from the beaches2_cleaned
# dataframe. Check the "data_cleaned" folder -- is it in there?

write.csv(beaches2_cleaned,
          file = here("data_cleaned", "beaches2_cleaned.csv"), # where and what you want your
                                                               # csv file to be saved as.
          row.names = FALSE)

# The row.names = FALSE gets rid of an annoying first column.
# Try running this function again, with row.names = TRUE
# What happens? Then, try saving beaches2_cleaned again,
# this time with a different filename.


# Exercise 5.5: Is Malabar really so bad? ####

# From your beach_means data, it looks like Malabar aren't doing so well here...
# But what if there's something else at play here -- for example, what if
# the figure is inflated due to one single bad year, or if things have been
# steadily improving recently?

# Let's break the mean enterococci levels down by years first, then see
# whether Malabar is the beach with the worst ever yearly mean.

beaches2_cleaned %>%
  group_by(site, year) %>% # what do you notice? what happens if you change "year" to "month"?
  summarise(
    enterococci = mean(enterococci)
  ) %>%
  arrange(desc(enterococci)) %>% # notice: what does desc() do here? what if we omit it?
  ungroup()

# Maybe does it look like Malabar's "least safe beach" title
# varies by year? Either way, Malabar may not deserve a bad reputation.

# Exercise 5.6: Using mutate() and ifelse() ####

# Enterococci is a bacteria that indicates the presence of fecal
# material in water, and therefore possibly the possible presence
# of disease-causing pathogens. So, high levels of enterococci in
# water is a concern, since it could sicken swimmers!

# Enterococci in water is considered potentially of concern
# at more than 41 colony forming units units per 100mL of water.

# Using mutate(), make a new column named "concern" to code for if the water quality
# at a beach is safe or concerning on a given day. If it is safe, we want
# concern = 0, and if not, we want concern = 1.

# Hint: run ?ifelse in the console to see more information on
# how to use the function.

beaches2_cleaned <- beaches2_cleaned %>%
  mutate(concern = ifelse(enterococci > 41, 1, 0))

# Instead of a binary classification of concerning or not,
# say we want a more detailed categorical classification.

# Category  |  Colony forming units per 100ml   |  Basis of Derivation
#
# A         |  < 41                             |  No illness seen in most epidemiological studies
# B         |  41 - 200                         |  Upper threshold is above the threshold of illness transmission reported in most studies
# C         |  201 - 500                        |  Represents a substantial elevation in the probability of adverse health outcomes
# D         |  > 500                            |  Above this level there may be a significant risk of high levels of illness transmission


# CHALLENGE: Can you try and create a new column called "safety"
# that has value of A, B, C, or D?

beaches2_cleaned <- beaches2_cleaned %>%
  mutate(
    safety = ifelse(enterococci < 41, "A",
           ifelse(enterococci >= 41 & enterococci <= 200, "B",
                  ifelse(enterococci >= 201 & enterococci <= 500, "C",
                         ifelse(enterococci > 500, "D",
                                NA))))
  )

# Exercise 5.7 ####

# Say we want to know the % of concerning days at any given beach,
# monthly means from each year. Let's write some code to do this,
# then store it in beach_safety

# Solution:
beach_safety <- beaches2_cleaned %>%
  group_by(site, year, month, month_name) %>% # monthly means
  summarise(
    prop_concern = mean(concern),
    ) %>%
  ungroup()

# Let's just plot this to visually inspect the data!
# You shouldn't need to change anything in the code below.

ggplot(beach_safety,
       aes(x = reorder(month_name, month), y = prop_concern)
  ) +
  geom_boxplot(aes(colour = site),
               show.legend = FALSE) +
  facet_wrap(~site) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.9)) +
  labs(x = "month", y = "% of concerning days")

# Now let's say instead of knowing the % of concerning days
# there are per month, we want to base our beach-going decisions
# on the MEAN LEVEL of enterococci at beaches.

# Part A) Rewrite our beach_safety code to let us do this,
# and store this in the beach_safety variable (to overwrite what
# what previously stored)

# Solution:

beach_safety <- beaches2_cleaned %>%
  group_by(site, year, month, month_name, lat, long) %>% # monthly means
  summarise(
    avg_ent = mean(enterococci),
  ) %>%
  ungroup()

# Part B) Visualise this data like we previously did with % of
# concerning days.Then, try giving it some nicer labels.

# Solution:

safety_plot <- ggplot(beach_safety,
                      aes(x = reorder(month_name, month), y = avg_ent)
) +
  geom_boxplot(aes(colour = site),
               show.legend = FALSE) +
  facet_wrap(~site) +
  theme_bw()

safety_plot


