#                                           #  In the Name of God #                                    #

#                                            #  Completed Script #                                    #

## Lab 2: Intro to R

## cloner174 (cloner174.org@gmail.com)





# Run this if you already did not!
# hint: You should first remove the comment syntax, which is -->> (#) ##

#install.packages('ggplot2')



# This loads the package into your "environment" so you can use it!

library(ggplot2) 


# Open RStudio

# In RStudio, to open a script (e.g. this file) go to: File -> Open File...


# # CONSOLE PANE # # ------------------------------------------------------------------------------------

# This pane is in the bottom left

# Executing commands (i.e. telling R what you want it to do):

# 1. '>' is the prompt (i.e. "Hi I'm R, what do you want me to do now?")

# 2. You can type code (i.e. "Hi I'm your new user, this is what I want you to do.") in Console

# 3. Hit 'enter'  to run the code

# The console can be a useful place to test out code, but most of your work should be in your
# script file (think of it like a Word doc) which is in the "Source" pane


# # SOURCE PANE # # ------------------------------------------------------------------------------------

# This pane is in the top/center left (it should be where you see this file!)

# This is where you'll do most of your work!

# You can write code here and save it as you go

# To run a line of code, click anywhere on the line and then:
# 1) you can click "Run" in the top of this pane OR
# 2) you can use the keyboard shortcut: Ctrl+Enter (Windows) or	Command+Enter (Mac)

# You can also highlight a section of code to run multiple lines at once using the shortcut or button


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 1. R Basics # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


# Use 'Tab' to autocomplete the commands and object names in R. 
# E.g. As you start to the type "sum", if you type "su" and then press tab, 
# it will suggest possible things you're trying to type (including "sum")
# The 'up' arrow and 'Tab' are probably your best friends with RStudio.
# Common mistake: unfinished command! In the console, '+' indicates an unfinished command 
# It won't let you run anything else while there's a '+'. Press 'Esc' on your keyboard to get out of this

# Not sure what a function does? Ask R by adding '?' before the command and run it:
?sum




# # PRACTICE 1*****************************************************************************************

# # PRACTICE 1.1:  Write 3 calculations with operators

#solve: {

12*5-8/2; #56 beacuse first "/" and then "-"

2^10-2; #1022 using Ctrl+Enter

50/2-25/2+5; #17.5


# } end of 1.1

## PRACTICE 1.2:  write 3 calcualtions with functions 

abs(cos(pi)); #1

prod(12, 5); #60

sum(1:100); #5050





# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 2. DATA, OBJECTS, VECTORS, and DataFrames # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


# # OBJECTS # # ------------------------------------------------------------------------------------

# Object: data structure with attributes of a certain class 

# Assigment operator ('<-' or '='): assigns objects on the right to objects on left

# Resulting objects stored in R's memory (the 'Environment')





# # PRACTICE 2 *****************************************************************************************PRACTICE 2


# # PRACTICE 2.1: Change object a from above to a different number, then re-add to b. Describe what happens to your object preceeded by #

a = -5;
a + b; # result is "0" , this means if you redefine an object with different value => R also recognized 
       # it by second value from now on and first one will be forgotten.

# # PRACTICE 2.2: Create a new object called "c" with the sum of a and b 

#easy one:)

c = a + b;
c; #run this for result
#or

c = sum(a, b);
c; #Run this for result




# # VECTORS # # ------------------------------------------------------------------------------------

# Vector: sequence of data elements of same basic type that are accessible by their position 
#(position [1], position [2], position[3])

# You can create a vector with the c() function:





# # PRACTICE 3 *****************************************************************************************PRACTICE 3 

# PRACTICE 3.1: Create a vector called mytextvector that has both y and d 
#
#
mytextvector = c(y, d);
mytextvector;            #run this for see the result

# PRACTICE 3.2:Create a vector with 5 numbers and find their sum using the sum() command 
#
#
mypractice = c(5, 3, 2, 31, 8);
mypractice;                      #run this for see the vector
sum(mypractice);                 # 49 is the result






# # DATAFRAMES # # ---------------------------------------------------------------------------------

# Dataframe (DF): list of vectors of equal length (numeric AND text)


# # PRACTICE 4 *****************************************************************************************PRACTICE 4

# PRACTICE 4.1 : What is the horsepower (column name: hp) of the car in the 10th row =
#
#

mtcars$hp[10];   #123
#or
mtcars[10,];   #after run we could head to "hp" column to find out the value;
#or
mtcars[10, "hp"];  #I just find out that even i could use this and have same result

# You can create a smaller dataframeor subset of the larger one using indexing:
(fewer_cars <- mtcars[1:5,]) # this is a new with only the first 5 rows

#Note: when you place the command in paraentheses, R will print the result in the console

# Note that "x:y" in R denotes the number x through y (in this case 1 through 5)


# # PRACTICE 5 *****************************************************************************************PRACTICE 5 
# PRACTICE 5.1 : Create a smaller data frame named fewer_cars2 from mtcars with all rows 1 through 10 and columns 1 through 5.
#
#

fewer_cars2 = mtcars[1:10,1:5];
fewer_cars2;                      #run this with Ctrl+Enter to see the 10's first row and 5's column





# # DATAFRAMES: Adding New Data # # -----------------------------------------------------------------


# # PRACTICE 6 *****************************************************************************************PRACTICE 6 
# PRACTICE 6.1 : Now, look at fewer_cars. What changed? Write code to explore the new column names 
#
fewer_cars; #I run this for see what changed!

#we know our fewer_cars had 12 column after rating so now it sould have 13. we could use:
# this " fewer_cars[,13] " for find out what is the new data added by last changing.
#to figure out the name of that column we could randomly named a row and check the last column.
fewer_cars[1,];

# or simply use this:

names(fewer_cars);

# PRACTICE 6.1 :Write code to explore new dimensions of the data frame.

# 
#
#we could use the function dim() for this:

dim(fewer_cars);


# DELETING DATA FROM A DF # 

# Use [ ] to index rows and columns in DF
# Remember that R thinks in [ROWS, COLUMNS]
# NOTE: We are creating a NEW DF that is subsetted, in order to not overwrite the original one.

fewer_cars_shorter <- fewer_cars[-5,] #delete 5th row from mydf

fewer_cars_less_variables <- fewer_cars[,-3] #delete 3rd column from mydf



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 3. EXPLORE DATAFRAME WITH BASIC FUNCTIONS # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


# # PRACTICE: EXPLORE DATAFRAME # # ----------------------------------------------------------------

dim(fewer_cars) #rows, columns =   5  13

nrow(fewer_cars) #number of rows =  5

ncol(fewer_cars) #number of columns = 13





# Dataframe Data Types


# # PRACTICE 7 *****************************************************************************************PRACTICE 7 

# Practice 7.1 Check the structure of the fewer_cars dataframe
#
#
str(fewer_cars);






# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 4. CHECK DATA WITH BASIC FUNCTIONS # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Many R objects are composed of multiple elements. There are various ways to extract one 
# (or more) elements from an object, depending on the object itself.
# You can use double brackets to select elements in more or less the same way as single brackets. 
# The difference between single and double is that with double brackets any element names are not displayed. 



# # PRACTICE 8 *****************************************************************************************PRACTICE 8 

# Practice 8.1 Find the minimum value for horsepower (hp) in the fewer_cars dataframe using the summary function and the min function
#

summary(fewer_cars$hp); # we sould check the first column called min to find our answer.

#or beacuse we already knew that first one is min so:

summary(fewer_cars$hp)[1]; # this will give us " Min. 93 "

min(fewer_cars$hp);


## Practice 8.2 Find the maximum value for horsepower (hp)in the fewer_cars dataframe using the summary function and the max function


summary(fewer_cars$hp); #After running look for column max;
#or
max(fewer_cars$hp);







# # PRACTICE 9 *****************************************************************************************PRACTICE 9 

# Practice 9.1 Using code, what are the unique elements of the column gears in the fewer_cars dataframe?
#
unique(fewer_cars$gear);  #4 and 3

## Practice 9.2 Using code, how many unique elements ar there in the column gears in the fewer_cars dataframe?
length(unique(fewer_cars$gear)); #2






# IMPORTANT: Find the record with the maximum weight

# The which() function in R returns the position or the index of the value which satisfies the given condition. 
# The Which() function in R gives you the position of the value in a logical vector. 
# The position can be of anything like rows, columns and even vector as well.





# # PRACTICE 10 *****************************************************************************************PRACTICE 10

# Practice 10.1:  Using code, find the minimum value of the mycars drat column

sort(mycars$drat); # beacuse we are just looking for numeric value of drat we could use this,
                   #and simply look at the fist one.
# or :
sort(mycars$drat)[1]; # This will directly pass us the min value of drat.

# Practice 10.2:  Using code, which record has the minimum value of the mycars drat column

which.max(mycars$drat); #6 it would be Valiant             







# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 6. Basic Plots and Graphics # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# We'll use the ggplot() command to visualize data
# It is a third-party package that is highly flexible and has great online documentation!
library("ggplot2")
?ggplot

# It works by creating a plot using the command ggplot() and including the data you want to use
# Then you "build" on top of that by adding +'s and then further commands
# We'll start basic and keep getting fancier throughout the semester!
ggplot(mycars, aes(x=1:length(mycars$mpg),y=mpg)) + geom_line()                                               







# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # 7. SAVE / EXPORT DATA # # 
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
setwd("C:users/intel/Documents"); 





# # SAVE TO CSV# # ---------------------------------------------------------------------------------------
# CSV, which stands for Comma Separated Value, is a lightweight and flexible dataframe storage format
# You can read and write CSVs from R as well as Excel/Google Sheets/etc




# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # 9. WRITING SCRIPTS # # 
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

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 