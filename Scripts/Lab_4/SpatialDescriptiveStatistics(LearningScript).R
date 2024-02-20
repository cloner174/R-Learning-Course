#                                           #  In the Name of God #                                    #

#                                            #  Learning Script #                                    #


## Lab 4: spatial descriptive statistics !
##https://github.com/cloner174/R_Learning_Course
# Email:  cloner174.org@gmail.com



## load packages
library(sf)
library (tidyverse)
library(terra)
library(ggplot2)

## set working directory -change this to your working directory.
#setwd('/home/admin/Documents/R/Learning/Lab4')


## step 2 read in wildfire data using sf package   ***************************************

## read in the wildfire data
fires <-st_read("mtbs_wildfires_2020.shp")

class(fires)  


## QUESTION 1 **************************************************************************************
##--------------------------------------------------------------------------------------------------
## Q1a: What type of vector data is the shapefile (point, line or polygon) 
##HINT: in the console, it tells you under Geometry type. 



## Q1b. How many features are there in this shapefile? How would you find out using code? -

## HINT: This spatial data has an attribute table. The attribute table has a row for every feature. The columns 
## in the table given information about the feature in that row. You can think of the attribute table as a dataframe 
## with rows and columns. 


## Q1c. Print the first six rows of the spatial attribute table for fires. What are the column names? 



####**************************************************************************************

## Map the wildfires using the ggplot2 package
## we can map all the fires, but this can take a long time for some computers since there are many fires.
## let's just plot the first 100 fires in the file. 

## use base R plot
plot(fires[1:100,])


## use ggplot2
ggplot(fires[1:100,]) + 
  geom_sf()

####**************************************************************************************

## Step 3 *********************************************************************

## calculate the area of each wildfire using a function in sf called st_area.

st_area(fires)

## the console will print out the area of each polygon. At the top of the console print out (scroll up), you will see
## the units for the area (Units: [m^2])

## Put the units in hectares. 1 ha = 100x100m
myArea <- st_area(fires)/10000

## add a field to the dataframe equal to the area in ha.
fires$areaFire <- myArea

#check your work
head(fires)

##Create a field in hectares and add it to fires
myArea <- units::set_units(st_area(fires), hectare)
fires$areaFire <- myArea

#check your work again
head(fires)

##Step 4****************************************************************************

## convert polygons to points. Use points on surface.  

firePoints <- st_point_on_surface(fires)

## check the dimensions
dim(firePoints)


##Question 2. **********************************************************************
##----------------------------------------------------------------------------------
#Q2a. Plot the firePoints. Show your code using ggplot(). 



##Q2b. What region of the US did not have many fires in 2020?


##Step 5 **********************************************************************************

## Get the projection of the firePoints.

st_crs(firePoints)


## HINT: If your data has been projected, the text within the coordinate reference system will read PROJCRS[]. 
## The text in quotes is the name of the projection.
## If your data has not been projected and is still in a geographic coordinate system (latitude and longitude in decimal degrees)
## then it will read GEOGCRS[].

## look at the coordinates for firePoints. 
head(firePoints)

## You can tell the data is projected since the values are greater than 90 degrees latitude and 180 longitude under the geometry field. 
## Coordinates in a geographic coordinate system will be in decimal degrees (0-90 or 0-180). 
## 90 is at the poles and 0 is at the equator for latitude. 
## 0 is the prime meridian in longitude and half way around the globe is 180. 

## Question 3 ***************************************************************************************************
##---------------------------------------------------------------------------------------------------------------
## Q3a. what is the name of the projection for firePoints? 


## Q3b: What is the unit of measurement for this projection? (e.g., meters, feet, degrees)
## HINT: look for LENGTHUNIT[] as you read down through the st_crs() print out. 



## Q 3c. Why is the unit of length important to know for spatial analyses? 
## HINT: how far is a decimal degree at the poles compared to the equator in a geographic coordinate system?


####**************************************************************************************

## This database is a nice example of the minimum information you may want for a spatial analysis. We have coordinates (a geographic location),
## and we have attribute information at that location that varies across space (wildfire size). 

##get the coordinates
##explore the class of the object
class(st_coordinates(firePoints))
dim(st_coordinates(firePoints))

## this is a matrix




## QUESTION 4 **************************************************************************************
##--------------------------------------------------------------------------------------------------
## Q4a: ##What is the mean center x coordinate value for wildfires in 2020?  Name the Mean center x object as MCx.Show code and answer. 
##Create a vector for X and Y



## Q4b: ##What is the mean center y coordinate value for wildfires in 2020? Name the Mean center Y object as MCy.  show code and answer. 



##Step 6***********************************************************************************************

## Create a dataframe by combining the X and Y mean centers. 
(meanCenter <- data.frame(cbind(MCx, MCy)))

## Create sf object
(meanCenter_sf <- st_as_sf(meanCenter,coords=c("MCx", "MCy"), crs = st_crs(fires)))

##Note - we give the function st_as_sf the dataframe called meanCenter and we tell it that the coords are in the columns named "Mcx" and "MCy".
##Remember when we wrap our line of code in (), it will print the result in the console. This is very useful when you want to see what you are doing. 

#Create fields with X and Y coordinates
meanCenter_sf$MCx <- MCx
meanCenter_sf$MCy <- MCy

#Explore the new fields
(meanCenter_sf)


## Now we can map the mean center and the fire points together. We can add a geom_point after we plot the fires. 
## When we add a point, we can no longer use geom_sf() for the geometry. We must give ggplot the coordinates in a sf dataframe.


ggplot(firePoints) + 
  geom_sf()+ geom_point(data = meanCenter_sf,aes(x = MCx, y = MCy),  size = 7, fill="red",shape = 23)


##Step 7*******************************************************************************************
## Now calculate the central feature and compare it to the mean center. 

##Calculate the distance between ten points to get a sense of what the st_distance function does. 
(distSubset <- st_distance(firePoints[1:10,]))

## It is calculating the distance between each point and all other points in meters. Each point has 
## zero distance between itself. 

##Now Calculate the distance between all points
dist <- st_distance(firePoints)

## We can take the mean of each column to determine the average distance for each point and all other points.
(distMeans <- colMeans(dist))

## If we then take the fire point with the minimum value, we have the point that is the median center. 
(distMin <- min(colMeans(dist)))

## Find the firePoint with the minimum distance
which(distMeans==distMin)

## the which function here gives you the point number or index of which firePoints has the minimum distance to all other points.          


##Question 5 ***************************************************************************************
##--------------------------------------------------------------------------------------------------

##Q5a. Determine which point in the firePoints is the central feature within the firePoints sf object using the results above. 
## HINT: Filter the firePoints layer to only have this point and name it centralFeature. You know the row number. 
## Get to coordinates for x and y of the central feature. Make new fields in centralFeature with the coordinate column names (as we did in the mean center) 
## and map it onto your previous map. 
## Fill the central feature with blue. 



## Q5b. Describe where the central feature with respect to the mean center. Does this make sense to you? Why? 


##********************************************************************************************************************************

## Step 8*************************************************************************************************************************

## Question 6 ************************************************************************************************************
##------------------------------------------------------------------------------------------------------------------------
## Q6a. calculate the median center of firePoints. Name the point medianCenter and add it to a map of firePoints with the mean center and central feature.
## Fill the medianCenter in yellow .
##HINT: follow steps in step 6 to create a meanCenter, but use median. 





## Q6b. Describe where the median center is with respect to the mean center and central feature. Does this make sense to you? Why? 




## Q6c. Which point best represents the spatial central tendency in your view and why? 

##****************************************************************************************************************
## Part 2 ********************************************************************************************************
##****************************************************************************************************************

## Explore the variable area for wildfire size. 

## Question 7*************************************************************************************************
##----------------------------------------------------------------------------------------------------------------

## Q7a. Plot a histogram of the area of wildfires.Show code.
## since our area has units in hectares, you must first open the package called units. 
library(units)





##Q 7b. Describe the distribution of wildfire size in 2020. Be specific if it is skewed. 



##Q 7c. What is the maximum fire size and what fire incident recorded it?  



####**************************************************************************************

## Step 9 ******************************************************************************

##Map the variable 'area' for our wildfire points.

## Create a proportional dot map map the coordinates of the fires.
## for the aes() function, you need to add the coordinates themselves and then scale them by the Area_ha attribute. 
## We can then add a legend with the scaled symbols.
## See how I added a title and labelled the x and y axes.
head(firePoints)

#Note that in the below graph, we had to convert the area in meters to just a number using as.numeric(). This function converts the vector to numbers. 
ggplot() + geom_point(data = firePoints, aes(x=st_coordinates(firePoints)[,1], y=st_coordinates(firePoints)[,2],size=as.numeric(areaFire))) + 
  scale_size_continuous(name="areaFire")+ ggtitle("Area of US Wildfires in 2020") + xlab("Longitude (m)") + ylab("Latitude (m)")



## QUESTION 8 **************************************************************************************
##----------------------------------------------------------------------------------------------------
## Q8a: What region of the US appears to have the largest fire according to your graduated symbol map?


## Q8b: What region of the US appears to have the most large fires according to your graduated symbol map?


## Q8c: Add a central tendency  point to the map by rewriting the above code to include the mean center, central feature or median center point.


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



##Q9b: what is the coordinate reference system of states (e.g., GEOGCRS or PROCRS?)? How does this compare to the projection of our fire data? - 
##(HINT: use the function to check the coordinate reference system)
## It is important that all spatial data is in the same projection so that we can overlay them. 




##*****************************************************************************************************

## We will need to reproject the state data to match that of the wildfire data so that we can run spatial analyses.


##reproject using st_transform. You need to provide the crs of firePoints
states <- st_transform(states, crs = st_crs(firePoints))


##Question 10*******************************************************************************************
##-------------------------------------------------------------------------------------------------------
## Q10a Map the state polygons with the firePoints over the state boundary polygons. 


## Q10b. List two states that did not have any wildfires in 2020.


## Q10c. Calculate the area of each state. Create a field called 'areaState' and make it equal to the area of each state in hectares. 
## HINT: we did this above with areaFire.



##********************************************************************************************************

## Step 11********************************************************************************************

## Sum the wildfire hectares by state. 
## Aggregate the area in the firePoints object we made above by the new states sf object that you just made. 
## There are 820 wildfires and 52 states. We will aggregate those fires by state. 

## Use the aggregate function. The FUN is the function. You can do many functions here. 
(fireAreaSum<- aggregate(x = firePoints["areaFire"], by = states, FUN = sum))

## check the result 
head(fireAreaSum)
dim(fireAreaSum)

## the result is a spatial polygon data frame. 
class(fireAreaSum)

## Now we can join this new field back to states by making a field in states equal to our new areaFire calculation

states$areaFire <- fireAreaSum$areaFire

## check your work 
head(states)

##Question 11 ******************************************************************************************
##------------------------------------------------------------------------------------------------------
## Q11a.  Which state had the most hectares burned in 2020? - 



## Q11b. Create a new field in your 'states' sf object called 'PercentAreaBurned'and make it equal to
## the areaFire / areaState.  Show your code. 




## Q11c. Create two maps: 1 - a map of states displayed by variable 'areaFire' and 2 - a map of states displayed by 'PercentAreaBurned'. 
##

## To map this data as continuous data, you will need to convert the area fields to numeric using function as.numeric()

## Example - the scale_fill_fermenter () is a color package that allows to color in our polygons using already specified colors. 
## the direction = 1 keeps the dark colors in the highest values. 

## see your options for palette colors here: https://ggplot2.tidyverse.org/reference/scale_brewer.html

ggplot() + 
  geom_sf(data = states, aes(fill=as.numeric(areaFire) ) )+
  scale_fill_fermenter(palette = "Oranges",n.breaks = 9, direction=1)



## Q11d. How do your maps from above differ? Does summing the wildfire hectares by state provide an example of the Modifiable Areal Unit Problem (MAUP)? 
## Why or Why not? Define MAUP and then provide answer. - 




##*****************************************************************************************************
## Question 12*****************************************************************************************
##----------------------------------------------------------------------------------------------------

##Q12a. Count the number of fires in each. Which state has the highest number of fires? 
## USe the tools you have learned. How would yo do this? HINT - you will need to make a new field in firePoints. 
## your final field in 'states' needs to be called 'fireCount'




## Q12b. Map states by number of fires (not areaFire). How does this map differ from the areaFire map?



## Q12c. Standardize the count variable by areaState to create a density map. Make a map of 'fireDensity'.



##****************************************************************************************************************************************


##Congratulations!!

# Email:  cloner174.org@gmail.com
#cloner174#https://github.com/cloner174/R_Learning_Course####


###################        End         ###################         https://github.com/cloner174/R_Learning_Course       ##################