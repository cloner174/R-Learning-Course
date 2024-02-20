#                                           #  In the Name of God #                                    #

#                                            #  Learning Script #                                    #


## Lab 3: Descriptive statistics !
##https://github.com/cloner174/R_Learning_Course
# Email:  cloner174.org@gmail.com



# Today's Learning Goals
## 1. Get acquainted with some of the different things R can do
## 2. Understand why we use descriptive statistics and data visualization
## 3. Understand how we can describe the "shape" of data and why that's useful
## 4. Learn how to use summary statistics to describe central tendency, dispersion, skewness, and kurtosis 



# R concepts: Packages #

## Packages ## 

##- like a lego pieces
##We will be using different packages throughout class (we'll help you install them as-needed)

#like this ---->>> install.packages('kableExtra','Hmisc')

##  - At the top of your assignments, you'll install and/or load the required R packages.

library(ggplot2)

install.packages('kableExtra','Hmisc')

library(kableExtra)
library(pander)




## Working directory

## - The working directory is where RStudio will look first for code scripts and data files

## - Keeping everything in a self contained directory helps organize code and analyses

## - Check and change you current working directory with
## getwd()
## \setwd(`path/to/file')

# R concepts: Basic Operation #
## Basic math operations*************************

##  `+'  addition
## `-'  subtraction
## '*'  multiplication
## `/'  division
## `%'  modulus (remainder)
##`^'  to the power


## Basic logical operations************************

## `!'     NOT
## '&', '&&'     AND
## '|' , '||'     OR
## `=='   equality
## `!='    NOT equality

## R concepts: Variables **************************

## -  (Named containers for data)
##- Better if names describe what the stored data is (e.g. my_height instead of variable_1) 
## Creating / Setting variables 
##To assign a value to a variable use `<-'
## `=' works too, '<-' is more often used 

## R concepts: Data Types and Structures ********************
## Data type: The format of the data values 
## Numeric: integer (whole numbers only) and floating point (allows decimals)
## Characters: for textual information
## Logical: 'TRUE' and `FALSE'
## Factor: categorical data
## Date and time
## Special values: missing values: 'NA', infinite values: 'Inf'



## Data structure: The organization of the data**************************************************

## array:  Arrays are data storage objects in R containing more than or equal to 1 dimension. 

##Arrays can contain only a single data type.

## vector: an array of same types of data in 1 dimension.

## data frame: excel sheet

##list 

##matrix:Matrix in R is a table-like structure consisting of elements arranged in a fixed number of rows and columns. 
##All the elements belong to a single data type.

##List versus vector
##A list holds different data such as Numeric, Character, logical, etc. 
##Vector stores elements of the same type or converts implicitly.
##Lists are recursive, whereas vector is not.
##The vector is one-dimensional, whereas the list is a multidimensional object.

##  vector
(z <- seq(1,20,1))
length(z)

## list
b <- list(seq(1,20,1)) 
c <- list('cat') 
(a <- list(b,c))  

length(a)
length(b)
length(a[1]) 
length(a[2])                   
a[1][[1]][1]
a[1][[1]][2]

##matrix 
A = matrix(seq(1,9,1),
  
  # No of rows and columns
  nrow = 3, ncol = 3, 
  
  # By default matrices are
  # in column-wise order
  # So this parameter decides
  # how to arrange the matrix         
  byrow = TRUE                            
)

print(A)

##arrays - Arrays are the R data objects which can store data in more than two dimensions.
# Create two vectors of different lengths.
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)

# Take these vectors as input to the array.
result <- array(c(vector1,vector2),dim = c(3,3,2))
print(result)



## This lab *************************************************************************************************
## Learn the basic operations dealing with data types and data structures 
##Getting data in and out of R 

# Descriptive statistics and Visualizations: Why #**************************************

## What are some things we might want to learn from this data?

## How could we describe this data to a collaborator? 

## How can we go from "data" to "knowledge"?

# Descriptive statistics and visualizations: What they're used for #


## Intuitive summaries of data

## Ways to investigate the "shape" of the data:
##  1. Is it peaky?
##  2. Is it clustered around that point or spread out?
##  3. Is it symmetric or skewed in one direction or the other?
##  4. Where is it "centered"?


# Types of plots
## There are a million different ways to visualize data, and we'll learn many methods
## For today, we'll focus on one of the most useful: histogram

## Histogram shape characteristics

##1. Kurtosis:  measure of peaky or flat **look at hypothetical data
## Platykurtic: Not peaky, Kurtosis < 
## Leptokurtic: Peaky, Kurtosis > 
par(mfrow=c(1,2), lwd=4)
## rnorm generates a nrmal distribution _ we will get to that
hist(rnorm(1000), breaks=10, main = 'Peaked', xlab = '', ylab='')
axis(1,at = 0:10)
##runif - generates random numbers
hist(runif(1000), breaks=10, main = 'Non Peaked', xlab = '', ylab='')
axis(1,at = 0:10)

##2. Number of peaks

par(mfrow=c(1,2),lwd=4)
hist(rnorm(1000), breaks=10, main = '1 Peak', xlab = '', ylab='')
axis(1,at = 0:10)
hist(cbind(rnorm(500), rnorm(500, mean =6)), breaks=10, main = '2 Peaks', xlab = '', ylab='')
axis(1,at = 0:10)

## 3. Symmetric or not: A distribution can have right (or positive), left (or negative), or zero skewness. 
## Skewness is a commonly used measure of the symmetry of a statistical distribution. 
## A right-skewed distribution is longer on the right side of its peak, 
## and a left-skewed distribution is longer on the left side of its peak:
## A normal A normal distribution does not have a positive skew or negative skew, 
## but rather the probability distribution is a symmetrical bell curve.

par(mfrow=c(1,3),lwd=4)
a <- as.integer(rbeta(1000,8,1)*100)
b<- as.integer(rbeta(1000,8,8)*100)
c<- as.integer(rbeta(1000,1,8)*100)
hist(a, breaks=10, main = 'Skewed Left', xlab = '', ylab='')
hist(b, breaks=10, main = 'Symmetric', xlab = '', ylab='')
hist(c, breaks=10, main = 'Skewed Right', xlab = '', ylab='')
axis(1,at = 0:10)


# Measure of central tendency*******************************************

##mode:* most frequently occurring values in data sets (Not used very much)
##we can use code that we learned last week to find the most frequent element
uniqvA <- unique(a)
(my_modeA <- uniqvA[which.max(tabulate(match(a, uniqvA)))])

uniqvB <- unique(b)
(my_modeB <- uniqvB[which.max(tabulate(match(b, uniqvB)))])

uniqvC <- unique(c)
(my_modeC <- uniqvC[which.max(tabulate(match(c, uniqvC)))])

hist(a, breaks=10, main = 'Skewed Left', xlab = '', ylab='')
abline(v=my_modeA,col="yellow",lwd=3)
hist(b, breaks=10, main = 'Symmetric', xlab = '', ylab='')
abline(v=my_modeB,col="yellow",lwd=3)
hist(c, breaks=10, main = 'Skewed Right', xlab = '', ylab='')
abline(v=my_modeC,col="yellow",lwd=3)
axis(1,at = 0:10)

##mean:* arithmatic average of values in data set - the sum of values divided by the # of observations

## Calculating Mean by hand
##Data: 1, 2, 5, 6, 6
##1+2+5+6+6 = 20
##20 / 5 = 4

v <- c(1,2,5,6,6) # given a vector of numbers
(m1 <- (1+2+5+6+6)/5) #manually calculate the mean
(m2 <- mean(v)) # use R function
m1==m2 # Make sure the result was the same

# use the R function to calculate the mean of our sample vectors
(my_meanA <- mean(a)) 
(my_meanB <- mean(b))
(my_meanC <- mean(c))

#add the mean value to the histogram
hist(a, breaks=10, main = 'Skewed Left', xlab = '', ylab='')
abline(v=my_modeA,col="yellow",lwd=3)
abline(v=my_meanA, col="red",lwd=3)
hist(b, breaks=10, main = 'Symmetric', xlab = '', ylab='')
abline(v=my_modeB,col="yellow",lwd=3)
abline(v=my_meanB, col="red",lwd=3)
hist(c, breaks=10, main = 'Skewed Right', xlab = '', ylab='')
abline(v=my_modeC,col="yellow",lwd=3)
abline(v=my_meanC, col="red",lwd=3)
axis(1,at = 0:10)


## median:* the value that divides data set into halves; also defined as 50th percentile
## If there's an even number of observations, it's the mean of the middle two values (e.g. median of 2, 3, 5, 6 is 4)
# Calculating Median by hand
## Data: 1, 2, 5, 6, 6
## Median: The middle value
## 1, 2, **5**, 6, 6

(sortv=sort(v)) # manually calculate the median
(med1=sortv[(5+1)/2])
(med2 <- median(v)) #use R function

med1==med2 # Make sure the result was the same

## use the R function to calculate the median of our sample vectors
(my_medianA <- median(a)) 
(my_medianB <- median(b))
(my_medianC <- median(c))

## add the median to the histograms
hist(a, breaks=10, main = 'Skewed Left', xlab = '', ylab='')
abline(v=my_modeA,col="yellow",lwd=3)
abline(v=my_meanA, col="red",lwd=3)
abline(v=my_medianA, col="blue",lwd=3)
hist(b, breaks=10, main = 'Symmetric', xlab = '', ylab='')
abline(v=my_modeB,col="yellow",lwd=3)
abline(v=my_meanB, col="red",lwd=3)
abline(v=my_medianB, col="blue",lwd=3)
hist(c, breaks=10, main = 'Skewed Right', xlab = '', ylab='')
abline(v=my_modeC,col="yellow",lwd=3)
abline(v=my_meanC, col="red",lwd=3)
abline(v=my_medianC, col="blue",lwd=3)
axis(1,at = 0:10)


##IMPORTANT to note:******************************************
##mean tends to be high when the data are skewed right
##And the mean is low when the data are skewed left: 


# Measures of Dispersion- how spread out the data is

## range:* difference between highest and lowest values: x_{max} - x_{min}
range(a)
range(b)
range(c) 

## interquartile range (IQR):* difference between 75th and 25th percentiles: x_{0.75} - x_{0.25}
## The interquartile range of an observation variable is the difference of its upper and lower quartiles. 
## It is a measure of how far apart the middle portion of data spreads in value.

## the quantile function allows you to calacuate the nth percential of the data 
quantile(a, prob=c(0.25,0.5,0.75))
quantile(b, prob=c(0.25,0.5,0.75))
quantile(c, prob=c(0.25,0.5,0.75))

##what is the 50th percentile
## variance : a numerical measure of how the data values is dispersed around the mean.
## sample variance (s^2):* average squared difference between any datum values and the mean
## divided by the number of observations -1
##
var(a)
var (b)
var (c)
  
##**Note:** unit of variance is square of that of the data 

## standard deviation:* square root of variance, 

sd(a)
sd(b)
sd(c)
## **Note:** unit of standard deviation is same as the data 

##Boxplots*****************************************************************************
## The box plot of an observation variable is a graphical representation based on its quartiles, as well as its smallest and largest values. 
## It attempts to provide a visual shape of the data distribution.
##Box plots divide the data into sections that each contain approximately 25% of the data in that set.

## the box itself contains the upper and lower quartile range. The 'whiskers' are the min and max. 
# the median is the middle line within the box. 

boxplot(a) ##skewed left / positive
boxplot(b)
boxplot(c) #skewed right / negative




##***************************************************************************************************
## set your own working directory

#change the "</home/admin/Documents/R/Lab_3>" to your Lab_3 folder

#setwd('/home/admin/Documents/R/Lab_3') 

##Daily COVID cases and mortalities in Colorado in Spring 2020
covid=read.csv("ColoradoCovid.csv")

##print first 6 rows to look at dataframe
head(covid)

##print structure of data
str(covid)

##Apply to our Covid data
head(covid)
dim(covid)
str(covid)
names(covid)

par(mfrow=c(1,1),lwd=4) ## This command returns the plots window to a 1:1 matrix
## Now test the distribution with different breaks

h=hist(covid$positiveIncrease,breaks=10, xlab='Case numbers', ylab='Freq', 
       main = 'Histogram of new daily positive cases')

##remove any NAs from data before calcualtions with na.rm = TRUE

(meanCovid<-mean(covid$positiveIncrease,na.rm = TRUE )) # mean tests

(medianCovid<-median(covid$positiveIncrease,na.rm = TRUE )) # median tests

h=hist(covid$positiveIncrease,breaks=10, xlab='Case numbers', ylab='Freq', 
       main = 'Histogram of new daily positive cases')
abline(v=meanCovid,col="blue",lwd=3)
abline(v=medianCovid, col="red",lwd=3)
## Now test the distribution with different breaks

h=hist(covid$positiveIncrease,breaks=20, xlab='Case numbers', ylab='Freq', 
       main = 'Histogram of daily positive cases')
abline(v=meanCovid,col="blue",lwd=3)
abline(v=medianCovid, col="red",lwd=3)


h=hist(covid$positiveIncrease,breaks=50, xlab='Case numbers', ylab='Freq', 
       main = 'Histogram of daily positive cases')
abline(v=meanCovid,col="blue",lwd=3)
abline(v=medianCovid, col="red",lwd=3)




##*************************************************************#************##********#
##                                           Questions  ##
##                    Questions  ##

##                                                                 Questions  ##



# QUESTION 1 *********************************************************************************************
##Please find which date has the most increased death and which date has the most increased positive cases 
# and which date has the most tests

# Hint: use which.max() to find the row with the maximum for each separately, then use [] to find the dates, 
#and put the results in the comments
# Include both your code and your answer!




# QUESTION 2  ********************************************************************************************

##In the data frame 'covid', please add a new column called 'positivityRate' 
# to show the daily positive rate (positiveIncrease/totalTestResultsIncrease)




# QUESTION 3 ******************************************************************************************* 

##Based on the variable you added in Question 2

# QUESTION 3.1 PLOT the daily positivity rate over time

## HINT: create a new variable in your dataframe for day number since the first date
##USE +xlab("days since 9/1/2021") to label your x axis in your graph
##load your package ggplot



# QUESTION 3.2 PLOT the cumulative deaths over time 



# QUESTION 3.3: What are the trends over the time for these two variables?




# QUESTION 4: ************************************************************************************

## QUESTION 4.1 Make a histogram of the daily positivity rate with the mean and median added in red and blue respectively



## In the lecture we used base R. Try to make your histogram using ggplot2 package.Either will get your credit.
## See this site for instructions on ggplot histograms:
## http://www.sthda.com/english/wiki/ggplot2-histogram-plot-quick-start-guide-r-software-and-data-visualization
## for base R use par(mfrow=c(1,1),lwd=4) to return yoru plot frame to a 1:1 matrix



## QUESTION 4.2 Add a mean vertical line to your histogram in red



## QUESTION 4.3 Add a median vertical line to your histogram in blue



## QUESTION 4.4:Is the distribution left-skewed, right-skewed, or fairly symmetric? Answer in the comments?



## QUESTION 4.5: what is the better choice of central tendency? The mean or the median?





## QUESTION 5: *************************************************************************************************

## QUESTION 5.1 Create a boxplot of positivity rate
## See: http://www.sthda.com/english/wiki/ggplot2-box-plot-quick-start-guide-r-software-and-data-visualization

# Basic box plot



## QUESTION 5.2 What are the 25th and 75th percentile (the values to calculate the Interquartile range) values for positivuty Rate?






#_________________________________________________________________________________________________________________________#
# End! Once you're done, make sure to save this script (File -> Save)
# by clicking the "Export" button in the Plots pane you can save your plots!

# Email:  cloner174.org@gmail.com
#cloner174#https://github.com/cloner174/R_Learning_Course####

###################        End         ###################         https://github.com/cloner174/R_Learning_Course       ##################