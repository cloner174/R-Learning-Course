#                                           #  In the Name of God #                                    #

#                                            #  Learning Script #                                    #


## Lab 2: Intro to R !
##https://github.com/cloner174/R_Learning_Course
# Email:  cloner174.org@gmail.com


## Aims:

## 1. Understand basic R objects (numbers, characters, vector, and data frame)
## 2. Practice basic functions to explore a data frame 
## 3. Check data frame with basic functions
## 4. Manipulate a data frame
## 5. Save data files for future use 
## 6. Read in text and numeric data files 
## 7. Write organized scripts


## Using this script:

## 1. The symbol '#' denotes comments. 
##    If in the same line as a command, these comments describe what the command executes.
## 2. All sections labeled 'PRACTICE' are meant to be completed on your own. They will be graded by the point value next to each item. 


# # WHAT IS A SCRIPT? # #

# Text file (.R) with executable written code and user comments 
# Comments (like this one) are lines that start with a '#'. 
# R doesn't see them as code and won't run them, which is helpful for writing instructions/answers in your file


## INSTALLING PACKAGES:

# First we have to install and load a package. This might take a moment:

install.packages('ggplot2') # NOTE: Once you've installed it, you can comment out or delete this line!
library(ggplot2) # This loads the package into your "environment" so you can use it!


## GETTING STARTED ## 
## GETTING STARTED ## 

#1) Open RStudio
#2) In RStudio, to open a script (e.g. this file) go to: File -> Open File...


## CONSOLE PANE ## 

# This pane is in the bottom left
# Executing commands (i.e. telling R what you want it to do):
# 1. '>' is the prompt (i.e. "Hi I'm R, what do you want me to do now?")
# 2. You can type code (i.e. "Hi I'm your new user, this is what I want you to do.") in Console
# 3. Hit 'enter'  to run the code

# The console can be a useful place to test out code, but most of your work should be in your
# script file (think of it like a Word doc) which is in the "Source" pane


# # SOURCE PANE # #

# This pane is in the top/center left (it should be where you see this file!)
# This is where you'll do most of your work!
# You can write code here and save it as you go

# To run a line of code, click anywhere on the line and then:
# 1) you can click "Run" in the top of this pane OR
# 2) you can use the keyboard shortcut: Ctrl+Enter (Windows) or	Command+Enter (Mac)

# You can also highlight a section of code to run multiple lines at once using the shortcut or button


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
##                                   1. R Basics ## 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # CALCULATIONS # # -------------------------------------------------------------------------------

# Calculations: At its most basic, R can be used as a calculator

4 + 5 #execute this command by typing it into the Console

4 + 5 #execute this command from the Source Script (i.e. here) with the keyboard shortcut


# Functions: R can execute pre-defined functions (arguments in parentheses) that return a value

sum(4, 5) # The sum() function sums numbers

print('I am a new R user and this is my first text output!') # print() "prints" text

# In the console, the 'up' arrow retrieves last command you ran. Use that to rerun the 4+5 command from earlier
# Use 'Tab' to autocomplete the commands and object names in R. 
# E.g. As you start to the type "sum", if you type "su" and then press tab, 
# it will suggest possible things you're trying to type (including "sum")
# The 'up' arrow and 'Tab' are probably your best friends with RStudio.
# Common mistake: unfinished command! In the console, '+' indicates an unfinished command 
# It won't let you run anything else while there's a '+'. Press 'Esc' on your keyboard to get out of this
# Not sure what a function does? Ask R by adding '?' before the command and run it:

?sum


# # OTHER OPERATORS AND FUNCTIONS # # 

# Run the code below to get a sense of different commands and operators in R:

3 * 4 - 2 # Multiply and subtract

12 / 6 # Divide

2 ^ 4 # 2 to the 4th power

# # Using functions # #

sum(1:10) #sums numbers in a sequence from 1 to 10

prod(2, 5) #multiplies numbers

sqrt(25) #square root

round(198.5894503, digits=4) #rounds number to specified digits

signif(198.5894503, digits=4) #gives number to specified total digits in scientific notation

abs(-103) #absolute value

cos(pi) #cosine of number in radians

rep('hello', 3) #repeats a specified object a specified number of times

rep('gruezi', 3) #repeat function

seq(0, 20, 4) #sequence function: from, to, by



#__________________________________________________________________________________________________________________________________#
#>>>>>>>>>>>>>>>>> PRACTICE 1
# # PRACTICE 1.1:  Write 3 calculations with operators
#solve:
12*5-8/2;
2^10-2;
50/2-25/2+5;
#
## PRACTICE 1.2:  write 3 calcualtions with functions 
#____________________________________________________________________________________________________________________________________#


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
##                                       2. DATA, OBJECTS, VECTORS, and DataFrames:
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # OBJECTS # # ------------------------------------------------------------------------------------

# Object: data structure with attributes of a certain class 
# Assigment operator ('<-' or '='): assigns objects on the right to objects on left
# Resulting objects stored in R's memory (the 'Environment')

# Create two objects: 

a <- 4  #the object a is being assigned to a value of 4

b <- 5

# Look at your objects:

a #run (i.e. execute) this

b #run this

# These objects a and b are now stored in R's memory, so we can use them: 

a + b

sum(a, b)

a==b
# '==' is to test if two numbers are equal to each other, the result is logical type: either 'TRUE' or 'FALSE'

# NOTE! R is case sensitive, and objects cannot be named with spaces or existing functions.
# You can see this by running 'A' or 'B', which do not exist.

A

B


#__________________________________________________________________________________________________________________________________#

# # >>>>>>>>>>>> PRACTICE 2 <<<<<<<<<<<<< **************************************************************************************
# # PRACTICE 2.1: Change object a from above to a different number, then re-add to b. Describe what happens to your object preceeded by #
# # PRACTICE 2.2: Create a new object called "c" with the sum of a and b 
#__________________________________________________________________________________________________________________________________#


# # VECTORS # # ------------------------------------------------------------------------------------

# Vector: sequence of data elements of same basic type that are accessible by their position 
#(position [1], position [2], position[3])

# You can create a vector with the c() function:
myvector <- c(2, 4, 6) 
# This vector contains the numbers 2, 4, and 6

# You can pull a specific element out of a vector using []
# This is called "indexing". In R, the count starts from 1 (in some other coding languages it starts at 0)
myvector[2] # 4 is the 2nd element of myvector
myvector[3] # 6 is the 3rd element of myvector

# We can perform functions on vectors, e.g.:
sum(myvector)

# We can make a vector object our of our existing integer objects:

myvectorAB <- c(a, b) 

# Can also create vector with text data:
# To create a text or "character" object, we put quotation marks around words.
y <- 'bonjour' 

# This is a vector with the two character objects within it 
d <- c('ciao', 'gruezi') #still need to use c() to combine elements


#___________________________________________________________________________________________________________________________#
# # PRACTICE 3 *****************************************************************************************PRACTICE 3 
# PRACTICE 3.1: Create a vector called mytextvector that has both y and d 

# PRACTICE 3.2:Create a vector with 5 numbers and find their sum using the sum() command 

#__________________________________________________________________________________________________________________________________#


# # DATAFRAMES # # ---------------------------------------------------------------------------------

# Dataframe (DF): list of vectors of equal length (numeric AND text)

# EXAMPLE:
##The mtcars dataset is a built-in dataset in R that contains measurements on 11 different attributes for 32 different cars.

data(mtcars)

head(mtcars) #first six rows of DF

# # --> In a data frame, the rows represent recorded observations (rows) for specific variables (columns)
# Now open mtcars from the Environment Pane (top-right) to see the full dataframe. 
# Click on the blue arrow next to mtcars in the Environment tab (upper right corner)
# You can load data into dataframes from R packages, data files from the internet, or from scratch
# using data you type into R code
# We can use the dim() function to get the dimensions of the dataset in terms of number of rows and 
# number of columns:

dim(mtcars)

#We can see that the dataset has 32 rows and 11 columns.
#We can also use the names() function to display the column names of the data frame:

names(mtcars)

# # DATAFRAMES: Extracting Data # # -----------------------------------------------------------------

# I. Using brackets: 
# This is just link indexing a vector, but its in 2D!
# R thinks in [ROWS, COLUMNS].
mtcars[2,1] #pull out the data in the 2nd row, 1st column. What is it?
mtcars[2,] # Pull out data from 2nd row, notice the comma after (that's required)
mtcars[,1] # Pull the data from the 1st column

# II. Using $ and then a variable/column name in your DF:
# This is often easier
mtcars$mpg # Pulls out the data in the mpg column
mtcars$hp # hp column

# It can also be combined with [] to get the column value at a specific row:
mtcars$mpg[5] # Get the mpg for the 5th car (a Hornet Sportabout in this case)


#__________________________________________________________________________________________________________________________________#
# # PRACTICE 4 *****************************************************************************************PRACTICE 
# PRACTICE 4.1 : What is the horsepower (column name: hp) of the car in the 10th row =
#
#__________________________________________________________________________________________________________________________________#


# You can create a smaller dataframeor subset of the larger one using indexing:
(fewer_cars <- mtcars[1:5,]) # this is a new with only the first 5 rows

#Note: when you place the command in paraentheses, R will print the result in the console
# Note that "x:y" in R denotes the number x through y (in this case 1 through 5)


#_________________________________________________________________________________________________________________________________#
# # PRACTICE 5 *****************************************************************************************PRACTICE 5 
# PRACTICE 5.1 : Create a smaller data frame named fewer_cars2 from mtcars with all rows 1 through 10 and columns 1 through 5
#__________________________________________________________________________________________________________________________________#


# # DATAFRAMES: Adding New Data # # -----------------------------------------------------------------

# I. Add new vector to existing DF

fewer_cars$rating <- c(3.5, 4, 4.5 ,2) # Personal ratings for the cars

# ERROR: what happened? Error because = ((( replacement has 4 rows, data has 5 )))
# Now, add a vector as dd$clothes that works
fewer_cars$rating <- c(3.5, 4, 4.5 ,2, 2) # Personal ratings for the cars

# We could have checked the length of our new vector with the length function

length (fewer_cars$rating)
dim(fewer_cars)

#The length of the vector must be equal to the number of rows in order to add the vector as a new column in the dataframe. 

# II. First create a vector, then add it as new column
# Is the car a Mazda?

mazda_car <- c("Y", "Y", "N", "N", "N") 

fewer_cars$mazda <- mazda_car

#__________________________________________________________________________________________________________________________________#
# # PRACTICE 6 *****************************************************************************************PRACTICE 6 
# PRACTICE 6.1 : Now, look at fewer_cars. What changed? Write code to explore the new column names 
#
# PRACTICE 6.1 :Write code to explore new dimensions of the data frame.
#__________________________________________________________________________________________________________________________________#

# DELETING DATA FROM A DF # 

# Use [ ] to index rows and columns in DF
# Remember that R thinks in [ROWS, COLUMNS]
# NOTE: We are creating a NEW DF that is subsetted, in order to not overwrite the original one.

fewer_cars_shorter <- fewer_cars[-5,] #delete 5th row from mydf

fewer_cars_less_variables <- fewer_cars[,-3] #delete 3rd column from mydf

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #                               3. EXPLORE DATAFRAME WITH BASIC FUNCTIONS # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#__________________________________________________________________________________________________________________________________#

# # PRACTICE: EXPLORE DATAFRAME # # ----------------------------------------------------------------

dim(fewer_cars) #rows, columns =   ?  ?

nrow(fewer_cars) #number of rows =  ?

ncol(fewer_cars) #number of columns = ?

#__________________________________________________________________________________________________________________________________#

# Dataframe Data Types
# str gives the structure of an object
str(fewer_cars) #columns can be "numeric", "factors", or "characters" (or other things too)

# This dataframe has all nunmeric columns and one character (or text) column 
# we can confirm this
# Numerical: numerical values (continuous, discrete, integers, etc.)

is.numeric(fewer_cars$mpg) #numeric? =  TRUE
is.numeric(fewer_cars$mazda) #numeric? = FALSE


# Character: an object made up of string values
is.character(fewer_cars$mazda) #character? = TRUE

# Factor: variables that have limited number of different values or categorical values (e.g., types of cloths) 
is.factor(fewer_cars$mazda) # Is the mazda variable a factor?  FALSE

# Can change it into a factor:
fewer_cars$mazda <- as.factor(fewer_cars$mazda)
is.character(fewer_cars$mazda) #character? = FALSE
is.factor(fewer_cars$mazda) #character? =  TRUE
levels(fewer_cars$mazda) #The categories in our factor variable

#__________________________________________________________________________________________________________________________________#
# # PRACTICE 7 *****************************************************************************************PRACTICE 7
# Practice 7.1 Check the structure of the fewer_cars dataframe
#
#__________________________________________________________________________________________________________________________________#

# # 4. CHECK DATA WITH BASIC FUNCTIONS # # 

# Duplicate mtcars data frame

mycars <- mtcars

# Refresher: Pulling out data to use

mycars$mpg # Individual column, '$' is used before the column name
mycars$mpg[4] # Individual cell, 4th row of mpg column
mycars[4, 1] #4th row, first column

# Summary function

summary(mycars) #of every column
# This will give the summary statistics (mean, median, quantile and etc) of each column

summary(mycars$mpg) #of one column
# This will give the summary statistics (mean, median, quantile and etc) of column mpg

# Many R objects are composed of multiple elements. There are various ways to extract one 
# (or more) elements from an object, depending on the object itself.
# You can use double brackets to select elements in more or less the same way as single brackets. 
# The difference between single and double is that with double brackets any element names are not displayed. 

#compare the difference in a single bracket versus a double bracket
summary(mycars$mpg)[1]
summary(mycars$mpg)[[1]]

# Data maximum
max(mycars$mpg)

# Data minimum
min(mycars$mpg)

#__________________________________________________________________________________________________________________________________#
# # PRACTICE 8 *****************************************************************************************PRACTICE 8 
# Practice 8.1 Find the minimum value for horsepower (hp) in the fewer_cars dataframe using the summary function and the min function
## Practice 8.2 Find the maximum value for horsepower (hp)in the fewer_cars dataframe using the summary function and the max function
#
#__________________________________________________________________________________________________________________________________#

# Data  range (The difference between the lowest and highest values.)

range(mycars$mpg)

# Data Interquartile range (The interquartile range of these values is a range where 25% on either side is cut off. 
# Statistically, the interquartile range is the difference between the upper quartile and the lower quartile.)
IQR(mycars$mpg)

# Data standard deviation (a measure of the amount of variation or dispersion of a set of values):
sd(mycars$mpg)

# Unique entries

unique(mycars$cyl) #lists all unique entries
length(unique(mycars$cyl)) #number of unique entries. Notice how we're nesting two functions!

#__________________________________________________________________________________________________________________________________#
# # PRACTICE 9 *****************************************************************************************PRACTICE 9
# Practice 9.1 Using code, what are the unique elements of the column gears in the fewer_cars dataframe?
#
## Practice 9.2 Using code, how many unique elements ar there in the column gears in the fewer_cars dataframe?
#__________________________________________________________________________________________________________________________________#

# Sort data

sort(mycars$cyl) #sorts column by increasing numeric order

(mycars_rev <- mycars[order(mycars$mpg),]) #orders the entire mycars from low to high mpg 

#note: see how the function can be placed in the place for rows and calling a column.
# IMPORTANT: Find the record with the maximum weight
# The which() function in R returns the position or the index of the value which satisfies the given condition. 
# The Which() function in R gives you the position of the value in a logical vector. 
# The position can be of anything like rows, columns and even vector as well.

which.max(mycars$wt) # which.max finds which row the maximum value is in!

mycars[which.max(mycars$wt),] # By combining it with indexing, we can find which car it is!

#__________________________________________________________________________________________________________________________________#
# # PRACTICE 10 *****************************************************************************************PRACTICE 10 
# Practice 10.1:  Using code, find the minimum value of the mycars drat column

# Practice 10.2:  Using code, which record has the minimum value of the mycars drat column
#__________________________________________________________________________________________________________________________________#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
##                                         5. DF MANIPULATION # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # NA VALUES # # ----------------------------------------------------------------------------------

# What if you don't have all the data for mpg?

mycars$mpg_missing <- mycars$mpg #duplicate column

# In R (or R Studio), NA stands for Not Available. Each cell of your data that displays NA is a missing value.
# NAs can cause many issues.

mycars$mpg_missing[10:15] <- NA #insert NA values

# Now calculate the mean. Why is the mean NA?
mean(mycars$mpg_missing) 

# R Can't do math with NA values!!!
# But we can use a special "argument" in most commands to get by this:
mean(mycars$mpg_missing, na.rm = TRUE) #tell R to remove 'NA' values for purposes of calculation
# In this case, we're adding a comma and then the name of an option "na.rm". 
# By setting that to TRUE, we're telling R to ignore NAs!

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
##                                            6. Basic Plots and Graphics # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# We'll use the ggplot() command to visualize data
# It is a third-party package that is highly flexible and has great online documentation!
library("ggplot2")
?ggplot

# It works by creating a plot using the command ggplot() and including the data you want to use
# Then you "build" on top of that by adding +'s and then further commands
# We'll start basic and keep getting fancier throughout the semester!

# In the mycars data frame, column `mpg' means the mileage per gallon of gas for each car, 'wt' is each car's weight and 'cyl' is the number of cylinder of the car engine. 

# draw Points
ggplot(mycars, aes(x=wt, y=mpg)) + geom_point()
# aes() describes what variables we're using. It is short for aesthetics. 
# In this case, wt is the x variable and mpg is the y variable
# change color by adding an option to geom_point!
ggplot(mycars, aes(x=wt, y=mpg)) + geom_point(col='red')
# draw a line showing how mpg varies over the rows of the dataframe
ggplot(mycars, aes(x=1:length(mycars$mpg),y=mpg)) + geom_line()
# In this case, our x variable is the row number 
# (from 1 to the total number of observations which we get using length())

#__________________________________________________________________________________________________________________________________#
# # PRACTICE 11 *****************************************************************************************PRACTICE 11
# Practice 11.1:  Describe the relationship between mpg and wt.
#__________________________________________________________________________________________________________________________________#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #                                         7. SAVE / EXPORT DATA # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # WORKING DIRECTORY # # --------------------------------------------------------------------------

# Set a directory to prevent re-typing path every time
# Use 'tab' key for options after each '/'
# '~/' represents the home directory. 

setwd('~/Desktop/') #for Windows Users, it is your desktop
setwd('~/') #for Mac users, it is your home directory

# You can set it to your Documents using something like:
setwd('~/Documents/') 
# If you want to set it to a specific folder in your documents, press tab again after the / and it will show options

setwd(C:users/intel/Documents); 

# # SAVE TO CSV# # ---------------------------------------------------------------------------------------

# CSV, which stands for Comma Separated Value, is a lightweight and flexible dataframe storage format
# You can read and write CSVs from R as well as Excel/Google Sheets/etc

write.csv(mycars, file='mycars.csv') #or export DF as .CSV file

# Try to find this file in your computer! It should be wherever you set your working directory
# above (could be your home, your desktop, or your documents, or somewhere else if you customized it!)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #                                   8. READ IN DATA # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Load .CSV file: use this type of file whenever possible

data_C <- read.csv('./mycars.csv')

# NOTE: "." represents your working directory. 
# The content behind the last / is the file to be read in to R.


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #                                 9. WRITING SCRIPTS # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # BEST PRACTICES: Organizing your script # # -----------------------------------------------------------

# Initialize each script with general information (e.g., project, name, date, aims, generated DFs)

# Clear R's memory at beginning of script: rm(list=ls())

# Write descriptive comments using '#' that are useful to YOU

# Split code into manageable sections and limit length of text line

# Only keep relevant code in main body of script

# Dedicate a folder within each project folder on computer for corresponding R scripts

# SAVING:

# Save generated dataframes in one place (e.g. 'project_name_YEAR/results/first_df.xlsx')

# Save scripts in one place (e.g. 'project_name_YEAR/scripts/first_script.R')

#* # *#* # # *# # *# # *# # *# # # #* # # # # # #* # *# # # # # *# *# # # # #* # # *# # # #* # # # #* # # # *# # #* # 

# Email:  cloner174.org@gmail.com
#cloner174#https://github.com/cloner174/R_Learning_Course####

# # References # # 
# R manuals by CRAN
# <https://cran.r-project.org/manuals.html>
# Basic Reference Card
# <https://cran.r-project.org/doc/contrib/Short-refcard.pdf>
# R for Beginners (Emmanuel Paradis)
# <https://cran.r-project.org/doc/contrib/Paradis-rdebuts_en.pdf>
# The R Guide (W. J. Owen)
# <https://cran.r-project.org/doc/contrib/Owen-TheRGuide.pdf>
# An Introduction to R (Longhow Lam)
# <https://cran.r-project.org/doc/contrib/Lam-IntroductionToR_LHL.pdf>
# Advanced R (Hadley Wickham)
# <http://adv-r.had.co.nz/>
# The R Inferno: useful for trouble shooting errors
# <http://www.burns-stat.com/documents/books/the-r-inferno/>

# # ONLINE TUTORIALS # #
# YouTube R channel
# <https://www.youtube.com/user/TheLearnR>
# R Programming in Coursera
# <https://www.coursera.org/learn/r-programming>
# Various R videos
# <http://jeromyanglim.blogspot.co.uk/2010/05/videos-on-data-analysis-with-r.html>

###################        End         ###################         https://github.com/cloner174/R_Learning_Course       ##################