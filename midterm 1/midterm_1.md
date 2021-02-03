---
title: "Midterm 1"
author: "Eric Coyle"
date: "2021-02-02"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
library(janitor)
library(dataMaid)
library(dbplyr)
```

## Questions
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">

**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  

# R is an scripting/programming language through which users interface via R studio (a graphical user interface program) to mske using R easier. R performs a variety of analystical, statistical, and organizing functions that make it particularly useful for sharing and presenting data, which is further facilitated by Github, a website where R users can store and shore dat sets, code, and calculations for other users/programmers to build off of and asses. Github also allows for code/data to be repeated by others to assess accuracy or allow for wider collaborations. 
</div>

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**

#We have discussed vectorsd, data matrices 9stacks of vectors in a table like format), and data frames.We are using data frame because they are very common methods to display/store data in R, they can store data of fifferentclasses, and it is relatively easy to transfer lots of gathered biologial data (i.e. in spreadsheets) to R in the form of data frames to work with via Rstudio.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
elephants<- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17...
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204....
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", ...
```

```r
anyNA(elephants)
```

```
## [1] FALSE
```

**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
elephants<-janitor::clean_names(elephants)
elephants
```

```
## # A tibble: 288 x 3
##      age height sex  
##    <dbl>  <dbl> <chr>
##  1   1.4   120  M    
##  2  17.5   227  M    
##  3  12.8   235  M    
##  4  11.2   210  M    
##  5  12.7   220  M    
##  6  12.7   189  M    
##  7  12.2   225  M    
##  8  12.2   204  M    
##  9  28.2   266. M    
## 10  11.7   233  M    
## # ... with 278 more rows
```

```r
elephants$sex<-as.factor(elephants$sex)
class(elephants$sex)
```

```
## [1] "factor"
```

**5. (2 points) How many male and female elephants are represented in the data?**

```r
elephants%>%
  count(sex)
```

```
## # A tibble: 2 x 2
##   sex       n
## * <fct> <int>
## 1 F       150
## 2 M       138
```


**6. (2 points) What is the average age all elephants in the data?**

```r
  mean_age_elephants<-mean(elephants$age)
mean_age_elephants
```

```
## [1] 10.97132
```

**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
elephants%>%
  group_by(sex)%>%
  summarise(across(c(age,height),mean,na.rm=T))
```

```
## # A tibble: 2 x 3
##   sex     age height
## * <fct> <dbl>  <dbl>
## 1 F     12.8    190.
## 2 M      8.95   185.
```

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">

**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

```r
elephants%>%
  group_by(sex)%>%
  summarise(mean_height=mean(height),
         min_height=min(height),
         max_height=max(height),
         total=n())
```

```
## # A tibble: 2 x 5
##   sex   mean_height min_height max_height total
## * <fct>       <dbl>      <dbl>      <dbl> <int>
## 1 F            190.       75.6       278.   150
## 2 M            185.       75.5       304.   138
```
</div>

For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
defaunation<- readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
glimpse(defaunation)
```

```
## Rows: 24
## Columns: 26
## $ TransectID              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 1...
## $ Distance                <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 24...
## $ HuntCat                 <chr> "Moderate", "None", "None", "None", "None",...
## $ NumHouseholds           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46,...
## $ LandUse                 <chr> "Park", "Park", "Park", "Logging", "Park", ...
## $ Veg_Rich                <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, 1...
## $ Veg_Stems               <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, 3...
## $ Veg_liana               <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.38...
## $ Veg_DBH                 <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, 5...
## $ Veg_Canopy              <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, 4...
## $ Veg_Understory          <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, 2...
## $ RA_Apes                 <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78, ...
## $ RA_Birds                <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, 4...
## $ RA_Elephant             <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, 0...
## $ RA_Monkeys              <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, 4...
## $ RA_Rodent               <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, 1...
## $ RA_Ungulate             <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.10...
## $ Rich_AllSpecies         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21,...
## $ Evenness_AllSpecies     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, 0...
## $ Diversity_AllSpecies    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, 2...
## $ Rich_BirdSpecies        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 11...
## $ Evenness_BirdSpecies    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, 0...
## $ Diversity_BirdSpecies   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, 1...
## $ Rich_MammalSpecies      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, 1...
## $ Evenness_MammalSpecies  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, 0...
## $ Diversity_MammalSpecies <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, 1...
```

```r
anyNA(defaunation)
```

```
## [1] FALSE
```

```r
defaunation$HuntCat<-as.factor(defaunation$HuntCat)
defaunation$LandUse<-as.factor(defaunation$LandUse)
class(defaunation$HuntCat)
```

```
## [1] "factor"
```

```r
class(defaunation$LandUse)
```

```
## [1] "factor"
```

**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

```r
names(defaunation)
```

```
##  [1] "TransectID"              "Distance"               
##  [3] "HuntCat"                 "NumHouseholds"          
##  [5] "LandUse"                 "Veg_Rich"               
##  [7] "Veg_Stems"               "Veg_liana"              
##  [9] "Veg_DBH"                 "Veg_Canopy"             
## [11] "Veg_Understory"          "RA_Apes"                
## [13] "RA_Birds"                "RA_Elephant"            
## [15] "RA_Monkeys"              "RA_Rodent"              
## [17] "RA_Ungulate"             "Rich_AllSpecies"        
## [19] "Evenness_AllSpecies"     "Diversity_AllSpecies"   
## [21] "Rich_BirdSpecies"        "Evenness_BirdSpecies"   
## [23] "Diversity_BirdSpecies"   "Rich_MammalSpecies"     
## [25] "Evenness_MammalSpecies"  "Diversity_MammalSpecies"
```

```r
head(defaunation)
```

```
## # A tibble: 6 x 26
##   TransectID Distance HuntCat NumHouseholds LandUse Veg_Rich Veg_Stems Veg_liana
##        <dbl>    <dbl> <fct>           <dbl> <fct>      <dbl>     <dbl>     <dbl>
## 1          1     7.14 Modera~            54 Park        16.7      31.2      5.78
## 2          2    17.3  None               54 Park        15.8      37.4     13.2 
## 3          2    18.3  None               29 Park        16.9      32.3      4.75
## 4          3    20.8  None               29 Logging     12.4      29.4      9.78
## 5          4    16.0  None               29 Park        17.1      36       13.2 
## 6          5    17.5  None               29 Park        16.5      29.2     12.9 
## # ... with 18 more variables: Veg_DBH <dbl>, Veg_Canopy <dbl>,
## #   Veg_Understory <dbl>, RA_Apes <dbl>, RA_Birds <dbl>, RA_Elephant <dbl>,
## #   RA_Monkeys <dbl>, RA_Rodent <dbl>, RA_Ungulate <dbl>,
## #   Rich_AllSpecies <dbl>, Evenness_AllSpecies <dbl>,
## #   Diversity_AllSpecies <dbl>, Rich_BirdSpecies <dbl>,
## #   Evenness_BirdSpecies <dbl>, Diversity_BirdSpecies <dbl>,
## #   Rich_MammalSpecies <dbl>, Evenness_MammalSpecies <dbl>,
## #   Diversity_MammalSpecies <dbl>
```

```r
tabyl(defaunation$HuntCat)
```

```
##  defaunation$HuntCat n   percent
##                 High 7 0.2916667
##             Moderate 8 0.3333333
##                 None 9 0.3750000
```

```r
defaunation%>%
  select(HuntCat,Diversity_MammalSpecies,Diversity_BirdSpecies)%>%
  filter(HuntCat=="Moderate")%>%
  summarise(across(c(Diversity_MammalSpecies,Diversity_BirdSpecies),mean,na.rm=T))
```

```
## # A tibble: 1 x 2
##   Diversity_MammalSpecies Diversity_BirdSpecies
##                     <dbl>                 <dbl>
## 1                    1.68                  1.62
```

```r
defaunation%>%
  select(HuntCat,Diversity_MammalSpecies,Diversity_BirdSpecies)%>%
  filter(HuntCat=="High")%>%
  summarise(across(c(Diversity_MammalSpecies,Diversity_BirdSpecies),mean,na.rm=T))
```

```
## # A tibble: 1 x 2
##   Diversity_MammalSpecies Diversity_BirdSpecies
##                     <dbl>                 <dbl>
## 1                    1.74                  1.66
```



```r
defaunation%>%
  select(HuntCat,Diversity_MammalSpecies,Diversity_BirdSpecies)%>%
  summarise(across(c(Diversity_MammalSpecies,Diversity_BirdSpecies),mean,na.rm=T))
```

```
## # A tibble: 1 x 2
##   Diversity_MammalSpecies Diversity_BirdSpecies
##                     <dbl>                 <dbl>
## 1                    1.70                  1.66
```
#second chunk is to double check that the filter worked right and there is a difference between overall ave diversity and diversity in areas with high and moderate hunting intensity. Interesting that bird diversity decreases with high/mod hunt imntensity but mammal diversity increases.

**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  

```r
def_close<-defaunation%>%
  filter(Distance<5)%>%
  select(contains("RA"),Distance)
def_close
```

```
## # A tibble: 3 x 8
##   TransectID RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate
##        <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1         15    0        85.0       0.290       9.09      3.74        1.86
## 2         17    0        57.8       0          37.8       3.19        1.04
## 3         27    0.24     68.2       0          25.6       4.05        1.88
## # ... with 1 more variable: Distance <dbl>
```


```r
def_far<-defaunation%>%
  filter(Distance>20)%>%
  select(contains("RA"),Distance)
def_far
```

```
## # A tibble: 3 x 8
##   TransectID RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate
##        <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1          3   12.9      59.3        0.56       19.8      3.66        3.71
## 2          6    3.78     42.7        1.11       46.2      3.1         3.1 
## 3         24    4.91     31.6        0          54.1      1.29        8.12
## # ... with 1 more variable: Distance <dbl>
```


```r
def_close%>%
  summarise(across(contains("RA"),mean))
```

```
## # A tibble: 1 x 7
##   TransectID RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate
##        <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1       19.7    0.08     70.4      0.0967       24.1      3.66        1.59
```

```r
def_far%>%
  summarise(across(contains("RA"),mean))
```

```
## # A tibble: 1 x 7
##   TransectID RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate
##        <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1         11    7.21     44.5       0.557       40.1      2.68        4.98
```
#I was not sure how to consalidate the two in one table/screen but the respective graphs show the RA in both the distance categories of <5km and >20km 

**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

```r
defaunation%>%
  group_by(NumHouseholds)%>%
  summarise(across(contains("Veg"),mean,na.rm=T))%>%
  arrange(NumHouseholds)
```

```
## # A tibble: 11 x 7
##    NumHouseholds Veg_Rich Veg_Stems Veg_liana Veg_DBH Veg_Canopy Veg_Understory
##            <dbl>    <dbl>     <dbl>     <dbl>   <dbl>      <dbl>          <dbl>
##  1            13     14.8      44.6     13.1     33.9       3.29           3.32
##  2            17     11.8      37       12.2     42.9       3.29           3.14
##  3            19     14.2      32.6     16.4     57.7       3.25           2.88
##  4            24     14.8      30.9     12.9     45.7       3.38           2.82
##  5            25     12.6      23.7      5.13    45.2       3              3.25
##  6            29     15.7      32.6      9.84    43.4       3.57           2.88
##  7            36     14.6      39.1     11.9     38.1       3.75           3.13
##  8            46     11.6      24.4      8.12    49.2       3.32           3.19
##  9            54     15.1      32.6     10.4     49.4       3.67           3.06
## 10            56     15.8      30.2     14.1     52.1       3.57           2.86
## 11            73     17.4      33.1     12.9     52.4       3.32           3.00
```
#impact of human abundance on the plant communities of transects associated with certain human levels (modeled by number of households)
