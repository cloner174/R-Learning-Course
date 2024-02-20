#                                           #  In the Name of God #                                    #

#                                            #  Completed Script #                                    #


## Lab 4: spatial descriptive statistics !
##https://github.com/cloner174/R_Learning_Course
# Email:  cloner174.org@gmail.com

## load packages


if (!requireNamespace("conflicted", quietly = TRUE)) {
  install.packages("conflicted", dependencies = TRUE)
  library(conflicted)
} else {
  library(conflicted)
};
library(plyr);
library(dplyr);
library(sp);
library(sf)
library (tidyverse)
library(terra)
library(ggplot2)
library(stringi)
library(compiler);
library(spatial);
library(raster);
library(pillar);
if (!requireNamespace("geometries", quietly = TRUE)) {
  install.packages("geometries", dependencies = TRUE)
  library(geometries)
} else {
  library(geometries)
};



## set working directory -change this to your working directory.
getwd();
#setwd('C:/Users/Documents/Lab4')




## step 2 read in wildfire data using sf package   ***************************************
## read in the wildfire data
fires <-st_read("mtbs_wildfires_2020.shp");  #Simple feature, Geometry type: MULTIPOLYGON#
class(fires);    # "sf"   -->>      "data.frame" #




## QUESTION 1 **************************************************************************************

##--------------------------------------------------------------------------------------------------
## Q1a: What type of vector data is the shapefile (point, line or polygon)
##HINT: in the console, it tells you under Geometry type. 


str(fires);   
          # ANSWER --->>>  geometry  :sfc_MULTIPOLYGON of length 820 #
          ## ANSWER --->>> The  type of vector data is polygon ##



## Q1b. How many features are there in this shapefile? How would you find out using code? 

## HINT: This spatial data has an attribute table. The attribute table has a row for every feature. The columns 
## in the table given information about the feature in that row. You can think of the attribute table as a dataframe 
## with rows and columns. 



ncol(fires);
          # ANSWER --->>> There are 2 features in it: based on=  %%feature == column%%  #
          ## ALSO WE COULD USE  names()  FUNCTION TO FIND OUT names of THOSE COLUMNS or FEATURES ##




## Q1c. Print the first six rows of the spatial attribute table for fires. What are the column names?


#head(fires);
names(fires);
            # ANSWER --->>> "Incid_Name" "geometry" #




####**************************************************************************************
## Put the units in hectares. 1 ha = 100x100m
myArea <- st_area(fires)/10000
## add a field to the dataframe equal to the area in ha.
fires$areaFire <- myArea

myArea <- units::set_units(st_area(fires), hectare)
fires$areaFire <- myArea

## convert polygons to points. Use points on surface.  
firePoints <- st_point_on_surface(fires)




##**Question 2. **********************************************************************
##----------------------------------------------------------------------------------
#Q2a. Plot the firePoints. Show your code using ggplot(). 


#str(firePoints); 
              ## geometry  :sfc_POINT ##
ggplot() +
  geom_sf(data = firePoints, col='red');



##Q2b. What region of the US did not have many fires in 2020?  


 #**ANSWER* --->>> Based on plot we had on "Q2a", it seems that in the pretty square area between,
 ## these four point :{[50N,80W],[40N, 80W], [50N, 100W], [40N, 100W]} there is very low 
 ###  fire that makes it a region of US "did not have many fires in 2020".
 ####Important:: In whole Plot just {50N to 20N AND 80W to 120W} is inside the US.
 #### IOWA, MINNESOTA, WISCONSIN, MICHIGAN ####
 ##### from what I saw in Plot, I had this idea that could write a code for question 2b?
 ###### If we pay attension to which area is inside US and it would be what percentage of
 ####### all the plot, and based on what we study in lab1 with function "quantile()",
 ######## Maybe we could do that. By guess -->> {20% of N and 20% of W} is free of fire!
 ######### and it placed of near the end of all range of N and W. if you look at my code,
 ### It much explained itself!! #####
dfregion <- as.data.frame(region_NW);    #I do that because I'm goint to use geom_point #
region <- as.array(firePoints$geometry);
region_NW <- gm_coordinates(region);     #Turned out that this amazing function is exist!#
names(region_NW);                        #I do this for finding out the names of N and W 's column!#
regionN <- region_NW$c1;
regionW <- region_NW$c2;
N = quantile(regionN, prob = c(0.6, 0.8));     #my guess about the area that is free of fire points!#
W = quantile(regionW, prob = c(0.65, 0.95));

myplot <- ggplot() + geom_sf(data = firePoints) ;
#myplot + geom_point(mapping = aes(x =  W[1], y = N[1] ), col = 'red') +
#  geom_point(mapping = aes(x =  W[1], y = N[2] ), col = 'yellow3') +
#  geom_point(mapping = aes(x =  W[2], y = N[1] ), col = 'skyblue3') +
#  geom_point(mapping = aes(x =  W[2], y = N[2] ), col = 'purple');

#I think maybe lines are better!#
myplot +
  geom_line(mapping = aes(x = W[1], y = N), col = 'blue') +
  geom_line(mapping = aes(x = W[2], y = N), col = 'yellow3') +
  geom_line(mapping = aes(x = W, y = N[1]), col = 'green3') +
  geom_line(mapping = aes(x = W, y = N[2]), col = 'red');
 





##Step 5 **********************************************************************************
## Get the projection of the firePoints.
st_crs(fires);
## HINT: If your data has been projected, the text within the coordinate reference system will read PROJCRS[]. 





## Question 3 ***************************************************************************************************
##---------------------------------------------------------------------------------------------------------------
## Q3a. what is the name of the projection for firePoints? 


st_crs(fires);
      #**Answer* --->>> "North_America_Albers_Equal_Area_Conic".



## Q3b: What is the unit of measurement for this projection? (e.g., meters, feet, degrees)
## HINT: look for LENGTHUNIT[] as you read down through the st_crs() print out. 


#*** ANSWER --->>> Based on "Q3a" and your Hint :  (( metres )) ***#


## Q 3c. Why is the unit of length important to know for spatial analyses? 
## HINT: how far is a decimal degree at the poles compared to the equator in a geographic coordinate system?


#**ANSWER**## --->>> Well as you said, it could be very helpful for us to know
## about measurement of an area that we are studying for. And of course if the area is wide,
##  or i don't know if we attempt to doing a convert between maps it would be very helpful 
## for us to know about the unit of our source to do some math on it and make the data or map
## biger or smaler or in general, ready. Or readies data for explaining and make a measurement, definable!***##




##**QUESTION 4 **************************************************************************************
##--------------------------------------------------------------------------------------------------
## Q4a: ##What is the mean center x coordinate value for wildfires in 2020?  Name the Mean center x object as MCx.Show code and answer.
##Create a vector for X and Y




#First I think we should have a variable for it that we could use it since now on:
FPcoord <- st_coordinates(firePoints);
names(FPcoord);
FPcoord_x <- FPcoord[1:820,1];      #A vector for all Xs!
FPcoord_y <- FPcoord[1:820,2];      #A vector for all Ys.
MCx <- mean(FPcoord_x);             #Calculate the mean X.
MCx;                                # MCx =   -395294.7 #                      



## Q4b: ##What is the mean center y coordinate value for wildfires in 2020? Name the Mean center Y object as MCy.  show code and answer.


#**ANSWER*# --->>> Since we done all jobs in "Q4a" :
MCy <- mean(FPcoord_y);
MCy;                     # MCy = -241134.2 #



##Step 6***********************************************************************************************
## Create a dataframe by combining the X and Y mean centers. 
(meanCenter <- data.frame(cbind(MCx, MCy)))
## Create sf object
(meanCenter_sf <- st_as_sf(meanCenter,coords=c("MCx", "MCy"), crs = st_crs(fires)))
#Create fields with X and Y coordinates
meanCenter_sf$MCx <- MCx
meanCenter_sf$MCy <- MCy
#Explore the new fields
(meanCenter_sf)
## Now we can map the mean center and the fire points together. We can add a geom_point after we plot the fires. 
##Calculate the distance between ten points to get a sense of what the st_distance function does. 
(distSubset <- st_distance(firePoints[1:10,]))
##Now Calculate the distance between all points
dist <- st_distance(firePoints)
## We can take the mean of each column to determine the average distance for each point and all other points.
(distMeans <- colMeans(dist))
## If we then take the fire point with the minimum value, we have the point that is the median center. 
(distMin <- min(colMeans(dist)))




##Question 5 ***************************************************************************************
##--------------------------------------------------------------------------------------------------

##Q5a. Determine which point in the firePoints is the central feature within the firePoints sf object using the results above. 
## HINT: Filter the firePoints layer to only have this point and name it centralFeature. You know the row number. 
## Get to coordinates for x and y of the central feature. Make new fields in centralFeature with the coordinate column names (as we did in the mean center) 
## and map it onto your previous map. 
## Fill the central feature with blue. 



#**ANSWER**#
# We have all of the answer basically:
#dist and distmin and which. so we just need to run which and find out the row number.

CFrow <- which(distMeans==distMin);   #**/*** It gaves me 18 18 #
(centralFeature <- firePoints[18,]);         ##**#* 18: Fire412 FIRE   POINT(-385550.2 -375953.2)  8934.104[hectare] ####
CFcoord <- st_coordinates(centralFeature);
(CFx <- CFcoord[1,1]);
(CFy <- CFcoord[1,2]);
centralFeature$CFx <- CFx;
centralFeature$CFy <- CFy;
(centralFeature);              #**Explor what we did!#
#** I had my base plot from back in "Q2" called -myplot- *#

myplot + 
  geom_point(data = centralFeature, mapping = aes(x = CFx, y = CFy),size = 7, fill="blue",shape = 23);





## Q5b. Describe where the central feature with respect to the mean center. Does this make sense to you? Why?  


#**ANSWER**## ---->>>> Based on their plots, actually they are very very close together!#
#* and it's make sense because one of them tell us where the average point or area is located, 
#* that seems to me just another definition of  centrality! And another shows us where is the place 
#* that had minimum distance to others, and it is the actual concept of center. Additionally,
#* for being an area with absolute minimum distance to others, had to be located somewhere 
#*  close to all other points ON AVERAGE.##




##********************************************************************************************************************************

## Step 8*************************************************************************************************************************

## Question 6 ************************************************************************************************************
##------------------------------------------------------------------------------------------------------------------------
## Q6a. calculate the median center of firePoints. Name the point medianCenter and add it to a map of firePoints with the mean center and central feature.
## Fill the medianCenter in yellow.
##HINT: follow steps in step 6 to create a meanCenter, but use median. 


#**ANSWER*# --->>> from "Q4" I have X and Y for all points separately for firepoints:*#
# FPcoord_x;
# FPcoord_y;
(MedCx <- median(FPcoord_x));    #median center x
(MedCy <- median(FPcoord_y));    #median center y
#create data frame of mediancentre#
( medianCenter <- data.frame(cbind(MedCx,MedCy)));
( medianCenter_sf <- st_as_sf(medianCenter,coords=c("MedCx", "MedCy"), crs = st_crs(fires)));
medianCenter_sf$MedCx <- MedCx ;
medianCenter_sf$MedCy <- MedCy ;
medianCenter_sf;                   #sf object with median coords and x-y #

#Adding to previous plots #
#we use same code for centralFeature and meanCenter #

myplot +
  geom_point(data = medianCenter_sf, mapping = aes(x = MedCx, y = MedCy),size = 7, fill="yellow",shape = 23) +
  geom_point(data = centralFeature, mapping = aes(x = CFx, y = CFy),size = 7, fill="blue",shape = 23) +
  geom_point(data = meanCenter_sf,aes(x = MCx, y = MCy),  size = 7, fill="red",shape = 23);
  



## Q6b. Describe where the median center is with respect to the mean center and central feature. Does this make sense to you? Why? 


medianCenter;
meanCenter;
CFcoord;
##**ANSWer**# --->>> It is near to others but based on their values I can say there is a difference
##*between them, I think median is pretty much irrelevant to our data and analysis
##*because it located just somewhere in between all of points and not helping much for deciding on.





## Q6c. Which point best represents the spatial central tendency in your view and why?

#**Answer***# --->>> I think it should be Central Feature, not only because it located in
#*the middle of two others-Mean center and median center -, but the concept of central feature is
#*basically same as central tendency. I mean, if going to be there a value that is the most representative of
#* the source data, it should be the nearest point to all of them in general, and that's exactly 
#* what was we do for calculate the central feature, wasn't we?! ##***#*#******##




library(units);
##****************************************************************************************************************
## Part 2 ********************************************************************************************************
##****************************************************************************************************************

## Explore the variable area for wildfire size. 
## Question 7*************************************************************************************************
###-------
###--------------------------------------------------------------------------------------------------------
#
## Q7a. Plot a histogram of the area of wildfires.Show code.
## since our area has units in hectares, you must first open the package called units. 
#
#
#
ggplot(data = firePoints, aes(areaFire)) +
  geom_histogram();



##Q 7b. Describe the distribution of wildfire size in 2020. Be specific if it is skewed. 



#**Answer Q 7b** First I need more bins to decide better : #**#

 #first I think the scale of histogram is not quite right! so I need more breaks for each bin.
#Based on ggplot2 features, there is a same name operand for doing that:
## geom_histogram(breaks =   ????  )  , But it require a vector for each step-break we want.
## so i start with this:

#**#*range(firePoints$areaFire)
#**#*median(firePoints$areaFire);
#*BASED on  histogram"Q7a" , " areafire[hectar] " in that , median of area fire , and finally range of it:
#**#*hectares <- c(seq(200, 2000, 10))
#**#*ggplot(data = firePoints, aes(areaFire)) +
#**#*  geom_histogram(breaks = hectares);

# After a few testing, I finally got there I wanted to!
# It seems ggplot is very kind actually!! I can directly use seq() function in operand' Breaks #
# It seems most fires are in  range 0 and 5000 hectar, but it is a bit heavy for my pc, and I think
# we are going to have a better judge on its skewed by divided that on smaller numbers, so:##
ggplot(data = firePoints, aes(areaFire)) +
  geom_histogram(breaks = seq(min(firePoints$areaFire), 1000, 10));

ggplot(data = firePoints, aes(areaFire)) +
  geom_histogram(breaks = seq(1000, 2500, 10));

ggplot(data = firePoints, aes(areaFire)) +
  geom_histogram(breaks = seq(2500, 5000, 10));

ggplot(data = firePoints, aes(areaFire)) +
  geom_histogram(breaks = seq(min(myArea), mean(myArea), 50));  # here is histogram from minimum to average!

#**Continuing answer **Q7b# Based on what we now are seeing, most of fires are happened on area under 1500 hectare,
#* when we look at histogram that is in range 200 to 1000, It is defiantly Symmetric!
#* but if we look at the histogram of general fire areas, that it would be 95% of all I think :
#*quantile(areaFire, prob = 0.95);##

ggplot(data = firePoints, aes(areaFire)) +
  geom_histogram(breaks = seq(min(firePoints$areaFire), quantile(myArea, prob = 0.95), 100));


#* It is look just like skewed-right, for making sure,
#* we already know that if it skewed-right so it sould have = mean > median !
#* we code this like this:

if(isTRUE(mean(firePoints$areaFire)>median(firePoints$areaFire))) print("It is skewed-RIGHT") else print("It is skewed-LEFT");

#yes, it is skewed-right#






##Q 7c. What is the maximum fire size and what fire incident recorded it? 



MaxAeraFireValue <- max(firePoints$areaFire);
(MAF_rowNumber <- which(firePoints$areaFire == MaxAeraFireValue)); #Number_of_row_with_max_area_fire_in_firePoints

(max_aera_fire_incident <- firePoints$Incid_Name[MAF_rowNumber]);  #** Answer : "AUGUST COMPLEX" *#








## Step 9 ******************************************************************************



## QUESTION 8 **************************************************************************************
##----------------------------------------------------------------------------------------------------
## Q8a: What region of the US appears to have the largest fire according to your graduated symbol map? 



  ##**Answer **## --->>> sorry but I can't tell much using previous plot, beacuse it is not quite shows that!
  ##* I think maybe this could help :

ggplot(data = firePoints, aes(x=FPcoord_x, y= FPcoord_y)) +
  geom_sf() +
  geom_point(aes(size=as.numeric(areaFire), color=as.numeric(areaFire)))+ 
  scale_size_continuous(name="areaFire")+
  scale_color_gradient(low = "white", high = "red3") +
  ggtitle("Area of US Wildfires in 2020") + 
  xlab("Longitude (Degrees)") + 
  ylab("Latitude (Degrees)") ;
                               #**#/#* It basically is what you are coded! 
                               #additionally I use degrees because i use color for measurement the fire area!
  
                             # I just add color to clarification 
#**base on plot I coded and using graduated plot in (meter):*
#* seems near the 30N and between 105W and 125W had the biggest fires.


 

## Q8b: What region of the US appears to have the most large fires according to your graduated symbol map? 



##**##**#**#**Answer -->>####
##*  I think it's the one near the 120W and on 40N ; It is very red!!




## Q8c: Add a central tendency  point to the map by rewriting the above code to include the mean center, central feature or median center point. 


(myplotwithCT <-
  ggplot(data = firePoints) +
    geom_point(aes(x = FPcoord_x, y = FPcoord_y, size = as.numeric(areaFire))) +
    geom_point(aes(x = MCx, y = MCy), size = 5, col = "red") +
    geom_point(aes(x = MedCx, y = MedCy), size = 5, col = "yellow3") +
    geom_point(aes(x = CFx, y = CFy), size = 5, col = "blue") +
    ggtitle(" Area of US Wildfires in 2020 With central tendency ") + 
    xlab("Longitude (m)") + 
    ylab("Latitude (m)"));


#I just add a big circle to make central tendency more obvious !

(myplotwithCT +
  geom_point(aes(x = CFx, y = CFx), size = 20, shape = 1));






##****************************************************************************************************

## Step 10 ************************************************************************************************

## calculate the number of fires per state and the % area burned
## Bring in US states spatial data. 

##Question 9 ******************************************************************************************
##-------------------------------------------------------------------------------------------------------
## Q9a: read in US states data and create a sf object and call the variable 'states' -
## HINT: look at code where we read in the fires at begining of lab. 
## The US states shapefile is called: cb_2018_us_state_20m.shp 
## It should be in your data folder. 


states <- st_read("cb_2018_us_state_20m.shp");
(head(states));





##Q9b: what is the coordinate reference system of states (e.g., GEOGCRS or PROCRS?)? How does this compare to the projection of our fire data? -
##(HINT: use the function to check the coordinate reference system)
## It is important that all spatial data is in the same projection so that we can overlay them. 




#str(states);    #I just checked if it works too!#It did not!
st_crs(states);
              #**Answer* it is not projected, It coordinate reference system is GEOGCRS.
              #*Well It is indeed different from previous (fires) file we read before.
              #*That was projected but this is not!




##*****************************************************************************************************


##reproject using st_transform. You need to provide the crs of firePoints
states <- st_transform(states, crs = st_crs(firePoints))




##Question 10*******************************************************************************************
##-------------------------------------------------------------------------------------------------------
## Q10a Map the state polygons with the firePoints over the state boundary polygons.


ggplot() +
  geom_sf(data = states) +
  geom_point(aes(x = FPcoord_x, y = FPcoord_y), size = 0.6);



## Q10b. List two states that did not have any wildfires in 2020.



##** Answer ***# --->>> I am sorry i didn't get that you want from us to made a code for
##*this or just looking into map, but base on where you asked it, i think probably second it is!
##*  ** we have (( WISCONSIN )) and (( IOWA)). second one was figured out sooner! 
##*   **#*******




## Q10c. Calculate the area of each state. Create a field called 'areaState' and make it equal to the area of each state in hectares.
## HINT: we did this above with areaFire.

myArea_2meter
myArea2hec

myArea_2meter <- st_area(states);

myArea2hec <- myArea_2meter/10000;

myArea2hec <- units::set_units(st_area(states), hectare);

states$areaState <- myArea2hec;
#ncol(states);

states[1:10, 11];




##********************************************************************************************************

## Step 11********************************************************************************************

## Use the aggregate function. The FUN is the function. You can do many functions here. 
(fireAreaSum<- aggregate(x = firePoints["areaFire"], by = states, FUN = sum))
## Now we can join this new field back to states by making a field in states equal to our new areaFire calculation
states$areaFire <- fireAreaSum$areaFire




##Question 11 ******************************************************************************************
##------------------------------------------------------------------------------------------------------
## Q11a.  Which state had the most hectares burned in 2020? -

#**Answer**#:
#which.max(states$areaFire);   #It returned number "13" for the row that have our answer.

# The state which it had the most hectares burned in 2020, is:
(states$NAME[which.max(states$areaFire)]);






## Q11b. Create a new field in your 'states' sf object called 'PercentAreaBurned'and make it equal to
## the areaFire / areaState.  Show your code. 

AreaBurned <- states$areaFire ;
head(AreaBurned);
PercentAreaBurned.temp <- AreaBurned / myArea2hec;
    
PercentAreaBurned <- units::set_units(PercentAreaBurned.temp, "%");         #beacuse it is percent 
states$PercentAreaBurned <-PercentAreaBurned ;

head(states);






## Q11c. Create two maps: 1 - a map of states displayed by variable 'areaFire' and 2 - a map of states displayed by 'PercentAreaBurned'.  

#colors()

ggplot() +
  geom_sf(data = states, aes(fill = as.numeric(areaFire))) +
  scale_fill_gradient(low = "beige", high = "darkred",n.breaks = 12, na.value = "blue", name = "Map-Colors Guide" ) +
  labs(caption = "BLUE : Where had no fire!");


ggplot() +
  geom_sf(data = states, aes(fill = as.numeric(PercentAreaBurned))) +
  scale_fill_gradient(low = "beige", high = "darkred",n.breaks = 100, na.value = "white", name = "100%" ,labels = NULL )+
  labs(title = "Fire-Base Damages", caption = "White is 0%", subtitle = "From 0% to 100% in states");






## Q11d. How do your maps from above differ? Does summing the wildfire hectares by state provide an example of the Modifiable Areal Unit Problem (MAUP)? 
## Why or Why not? Define MAUP and then provide answer. - 

#**Answer**# #-->>The modifiable areal unit problem (MAUP) refers to a statistical bias that occurs when
#* point-based measures of spatial phenomena are aggregated into spatial units with arbitrary boundaries that
#* can be modified. Two mechanisms can create modifiable areal units: the zoning effect, 
#* where new boundaries are drawn to create new zoning systems, and the scale effect, 
#* where the spatial resolution of the data is changed by either merging or subdividing areal units.
#I think maybe yes! Although the boundaries for states are typically fixed,
# and there is no arbitrary modification of boundaries, but during the summing wildfire,
# we actually did some changes,  which it could effect the data and results of our analysis. 
#In addition, the word "aggregating" in the definition of "MAUP" was a bit interesting for me,
#because we use an exact same function during the change, didn't we?! ####







##*****************************************************************************************************
## Question 12*****************************************************************************************
##----------------------------------------------------------------------------------------------------

##Q12a. Count the number of fires in each. Which state has the highest number of fires? 
## USe the tools you have learned. How would yo do this? HINT - you will need to make a new field in firePoints. 
## your final field in 'states' needs to be called 'fireCount'


 #**Answer**## --> For us to finding out which  fires are happened in each state,
 ## we are going to need some function(/functions). A function to could tell us,
 ## between a group of polygons and a geometrical area that we are specified for,
 ## which polygons are in that aera!
#Step 2: Create a loop using "for" to do the same thing for ALL states.
#Step3: Use length() function to finding out each states have what number of fires!
#step 4: In states df, Associate each state with its own number of fires, in new column named "fireCount"!##**#


## FOR DOING THIS, I SHOULD ADD GEOMETRY of ALL POINTS TO OUR firePoints df,
 ###**firePoints$exactgeom <- fires$geometry;#*###  #dont use this#
##Or simply Use fires$geometry:


states.fire.id = list();            #It let me to record each answer that comes from my loop.
                                    # Otherwise, only the last answer will remain.Also to Know which is which!!

message(" Please  BE  Patient ")
for ( x in c(1:52) ) {
  states.fire.id[x] <-as.data.frame(st_intersects(fires$geometry, states[[10]][[x]]))
}
message("Please don't attention to last Warning! \n Every thing is allright!");

#As you already see, the name of the function that could do tell 
#the same polygons between two area is "st_intersects()".

states.fire.count = vector();
for(x in c(1: 52)) {
  states.fire.count[x] <- length(states.fire.id[[x]])
  states$fireCount[x] <- states.fire.count[x]
};
#class(states.fire.count)
#states.fire.count[6]
#**#check out:**#

head(states)
#And for last part, use which(), remember we definitely should use na.rm = TRUE , beacuse NAs in fireCount!
states$NAME[which(states$fireCount == max(states$fireCount, na.rm = TRUE))];





## Q12b. Map states by number of fires (not areaFire). How does this map differ from the areaFire map?


# I had to use same kind code to telling the difference:

#max(states$fireCount)
ggplot() +
  geom_sf(data = states, aes(fill = as.numeric(fireCount))) +
    scale_fill_gradient(low = "white", high = "darkred", na.value = "blue", name = "Guide to Map:\n White(Minimum)->  0 \n DarkRed(Max)  -> 106") +
  labs(title = " States with EACH NUMBER of fires ", caption = "BLUE : MEANS NOT Defined");

# because it's hard to recognize the map using the default color for na.value i rather use blue#
#**ANSWER**## --> yes there is huge and important difference between Map States using area fires and fires count,
#* I wonder WHY!##
#* Was it because we used a very granular method to find the number of wildfires each state experienced?
#* Because it seems that there may be some differences in the boundaries of the states and fires in the border points?
#* However, our method of finding the number of fires per state was much more accurate,
#* because we use geometry for found out which places were within the boundaries of each state.##




## Q12c. Standardize the count variable by areaState to create a density map. Make a map of 'fireDensity'.  


##**Answer**# for doing this, we should have mean() of areastates Variable, deviation and also for count variable.##
# look ::


Standardize.area.temp <- ( states$areaState - mean(states$areaState) );
Standardize.area <- Standardize.area.temp / sd(states$areaState) ;

Standardize.count.temp <- ( states$fireCount - mean(states$fireCount) );
Standardize.count <-  Standardize.count.temp / sd(states$fireCount);

head(Standardize.count);
message("Because of amount being so small: Only, we see a slight change in number 6. \n Because, before that, only two states had a value, which was 1. \n In 6 but, we counted 3 fires.");

#sd(Standardize.area)    #result =  1 -->> OK
fireDensity <-  Standardize.count/Standardize.area;

ggplot() +
  geom_sf(data = states, aes(fill = as.numeric(fireDensity))) +
  scale_fill_gradient(low = "white", high = "darkred");

##**Remember?**##
             #(myplotwithCT +
             #  geom_point(aes(x = CFx, y = CFx), size = 20, shape = 1));
##* feel free to run it once again#
## in the exact same place that we had central tendency, density of fire is most highest!#
#Amazing #

##****************************************************************************************************************************************

##Congratulations!!

# In addition:
message(" Please don't attention to this Warning, below ! \n        **  Every thing is allright!  ** ")

# Email:  cloner174.org@gmail.com
#cloner174#https://github.com/cloner174/R_Learning_Course####


###################        End         ###################         https://github.com/cloner174/R_Learning_Course       ##################