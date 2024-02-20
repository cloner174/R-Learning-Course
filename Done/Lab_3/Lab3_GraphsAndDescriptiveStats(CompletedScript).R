#                                           #  In the Name of God #                                    #

#                                            #  Completed Script #                                    #

## Lab 3: Descriptive statistics !

## cloner174 (cloner174.org@gmail.com)





library(ggplot2);
library(kableExtra);
library(pander);


##Use the "Lab2_Introduction_to_R" file as the first place to look if you're not sure how to do something.

# The enclosed 'ColoradoCovidRecent.csv' file contains the basic covid statistics for the state of Colorado since September 1st, 2021
# The following is the description of each column:
# Date: each day of record
# State: Colorado
# death: accumulative number of death till each day
# deathIncrease: new confirmed death on each day
# positive: accumulative number of positive cases till each day
# positiveIncrease: new confirmed positive cases on each day
# totalTestResults: accumulative number of test conducted till that day
# totalTestResultsIncrease: new tests on each day

##*******************************************************************************************************************
#Read the csv file

read.csv("ColoradoCovid.csv");       #result of this command is not satisfying beacuse = 
                                    #[ reached 'max' / getOption("max.print") -- omitted 54 rows ]
                                    #so I looked up in Help section and find and use this:
options("max.print" = 10000);


#read in your data an set working directory

getwd();     #Result in console = "C:/Users/intel/Documents/Lab_2023/Mohammadi_ Lab3_2023"

##Daily COVID cases and mortalities in Colorado in Spring 2020


         #I rather assign a name to the table of our data:

     COVID = read.csv("ColoradoCovid.csv");
  print(COVID);                                  #Making sure of everything to be ok!
     
     #so now on we call our table = COVID ,,

# QUESTION 1 *********************************************************************************************
##Please find which date has the most increased death and which date has the most increased positive cases 
# and which date has the most tests

# Hint: use which.max() to find the row with the maximum for each separately, then use [] to find the dates, 
#and put the results in the comments
# Include both your code and your answer!

most_kill <- which.max(COVID$death)  ;   
most_positive <- which.max(COVID$positive);
most_tests <- which.max(COVID$totalTestResults);

print(most_kill);                      #Result = 178, which means 178th row in COVID that would be 2020/08/29    
print(most_positive);                  ## 179
print(most_tests);                     ### 179


COVID[most_kill,];                     #178   20200829     CO    1843     8     56773     430        985622     12632

COVID[most_positive,];               ## 179   20200830     CO    1843     0     57041     268        994951      9329

COVID[most_tests,];                 ### 179   20200830     CO    1843     0     57041     268        994951      9329


   #for pure date, we can use this:
 COVID[most_kill,1];                         #This will give us the exact date ==== 20200829
 COVID[most_positive,1];                   ##20200830
 COVID[most_tests,1];                      ###20200830

# QUESTION 2 : ********************************************************************************************

##In the data frame 'covid', please add a new column called 'positivityRate' 
# to show the daily positive rate (positiveIncrease/totalTestResultsIncrease)

positiveIncrease = c(COVID$positiveIncrease) ;
length(positiveIncrease);                  #179

totalTestResultsIncrease = c(COVID$totalTestResultsIncrease);
length(totalTestResultsIncrease);                          #179

positivity_Rate <- c(positiveIncrease/totalTestResultsIncrease);
length(positivity_Rate);       #also 179

print(positivity_Rate);     #just for make sure!

dim(COVID);      #179 , 8

COVID$positivityRate <- positivity_Rate;      #adding "positivityRate: column to current COVID table.

dim(COVID); #179 , 9   
                         ##print(COVID); #Optional!      


# QUESTION 3 ******************************************************************************************* 

##Based on the variable you added in Question 2

# QUESTION 3.1 PLOT the daily positivity rate over time

## HINT: create a new variable in your dataframe for day number since the first date
##USE +xlab("days since 9/1/2021") to label your x axis in your graph
##load your package ggplot

                                ##### loading ggplot done in the first of script #####

day_number <- COVID$date[1:179]; 

length(day_number);

ggplot(COVID, aes(x=day_number , y=positivity_Rate)) + geom_line(col='orange')+xlab("Days since 5/3/2020");
          
          #there is a problem with showing us exact date! I assume you was aware of this,
             # so you tell us use label for assign days!



# QUESTION 3.2 PLOT the cumulative deaths over time 

cumulative_deaths <- COVID$deathIncrease ;
length(cumulative_deaths);

ggplot(COVID, aes(x=day_number , y=cumulative_deaths)) + geom_line(col='red')+xlab("Days since 5/3/2020");

# QUESTION 3.3: What are the trends over the time for these two variables?

     ## ((((  ANSWER ==== Based on two plot: the daily positivity rate have absolute decrease over time ,
     ##       But cumulative deaths are the same at the most , beside two points that
      ##       shown unexpected behavior!   )))))) ######


## export image of plot in plot window or take screen shot for word document

# QUESTION 4 : ************************************************************************************

## QUESTION 4.1 Make a histogram of the daily positivity rate with the mean and median added in red and blue respectively

ggplot(COVID, aes(positivityRate)) + 
  geom_histogram(binwidth = 0.009 ) +
  labs(title="The Daily Positivity Rate Histogram Plot",x="daily positivity rate", y = "frequenty")+
  theme_bw();

         ##for "binwidth" i randomly checked numbers and figure out which ones suited!####


## In the lecture we used base R. Try to make your histogram using ggplot2 package.Either will get your credit.
## See this site for instructions on ggplot histograms:
## http://www.sthda.com/english/wiki/ggplot2-histogram-plot-quick-start-guide-r-software-and-data-visualization
## for base R use par(mfrow=c(1,1),lwd=4) to return yoru plot frame to a 1:1 matrix


## QUESTION 4.2 Add a mean vertical line to your histogram in red

ggplot(COVID, aes(positivityRate)) + 
  geom_histogram(binwidth = 0.009) +
  geom_vline(aes(xintercept=mean(positivity_Rate)), color="red",
             linetype="dashed")+
  labs(title="The Daily Positivity Rate Histogram Plot",x="daily positivity rate", y = "frequenty")+
  theme_bw();

## QUESTION 4.3 Add a median vertical line to your histogram in blue


ggplot(COVID, aes(positivityRate)) + 
  geom_histogram(binwidth = 0.009 ) +
  geom_vline(aes(xintercept=mean(positivity_Rate)), color="red",
             linetype="dashed")+
  geom_vline(aes(xintercept=median(positivity_Rate)), color="blue",
             linetype="dashed")+
  labs(title="The Daily Positivity Rate Histogram Plot",x="daily positivity rate", y = "frequenty")+
  theme_bw();


## QUESTION 4.4:Is the distribution left-skewed, right-skewed, or fairly symmetric? Answer in the comments?

mean(positivity_Rate);       #0.094
median(positivity_Rate);    ##0.049

         # It is defiantly (( right-skewed )),
        ##  beacuse not only you could simply say it according to it's histogram,
         ### But also mean > median == and we already knew that:
         #### mean tends to be higher when data is right-skewed.


## QUESTION 4.5: what is the better choice of central tendency? The mean or the median?

            ##The mean of course, here is another fact:
sd(positivity_Rate);    #0.092    so close to mean
var(positivity_Rate);   ##0.008      

## export image of plot with mean and with median in plot window or take screen shot for word document

## QUESTION 5 : *************************************************************************************************

## QUESTION 5.1 Create a boxplot of positivity rate
## See: http://www.sthda.com/english/wiki/ggplot2-box-plot-quick-start-guide-r-software-and-data-visualization

# Basic box plot


bbp = ggplot(COVID, aes(x=day_number, y=positivity_Rate)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=1,
               outlier.size=2)

bbp;

## QUESTION 5.2 What are the 25th and 75th percentile (the values to calculate the Interquartile range) values for positivuty Rate?

quantile(positivity_Rate, prob = 0.25);    ## 0.03455881 

quantile(positivity_Rate, prob = 0.75);    #### 0.1456034 





# End! Once you're done, make sure to save this script (File -> Save)
# by clicking the "Export" button in the Plots pane you can save your plots!


#* # *#* # # *# # *# # *# # *# # # #* # # # # # #* # *# # # # # *# *# # # # #* # # *# # # #* # # # #* # # # *# # #* # 

# Email:  cloner174.org@gmail.com
#cloner174#https://github.com/cloner174/R_Learning_Course####
###################        End         ###################         https://github.com/cloner174/R_Learning_Course       ##################