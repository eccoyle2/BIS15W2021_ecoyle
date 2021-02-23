---
title: "Lab 12 Homework"
author: "Eric Coyle"
date: "2021-02-23"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(ggmap)
library(albersusa)
```

## Load the Data
We will use two separate data sets for this homework.  

1. The first [data set](https://rcweb.dartmouth.edu/~f002d69/workshops/index_rspatial.html) represent sightings of grizzly bears (Ursos arctos) in Alaska.  
2. The second data set is from Brandell, Ellen E (2021), Serological dataset and R code for: Patterns and processes of pathogen exposure in gray wolves across North America, Dryad, [Dataset](https://doi.org/10.5061/dryad.5hqbzkh51).  

1. Load the `grizzly` data and evaluate its structure. As part of this step, produce a summary that provides the range of latitude and longitude so you can build an appropriate bounding box.

```r
grizzly <- read_csv(here("lab12", "data", "bear-sightings.csv")) %>% clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   bear.id = col_double(),
##   longitude = col_double(),
##   latitude = col_double()
## )
```


```r
glimpse(grizzly)
```

```
## Rows: 494
## Columns: 3
## $ bear_id   <dbl> 7, 57, 69, 75, 104, 108, 115, 116, 125, 135, 137, 162, 185, ~
## $ longitude <dbl> -148.9560, -152.6228, -144.9374, -152.8485, -143.2948, -149.~
## $ latitude  <dbl> 62.65822, 58.35064, 62.38227, 59.90122, 61.07311, 62.91605, ~
```

2. Use the range of the latitude and longitude to build an appropriate bounding box for your map.

```r
grizzly%>%
  summary()
```

```
##     bear_id       longitude         latitude    
##  Min.   :   7   Min.   :-166.2   Min.   :55.02  
##  1st Qu.:2569   1st Qu.:-154.2   1st Qu.:58.13  
##  Median :4822   Median :-151.0   Median :60.97  
##  Mean   :4935   Mean   :-149.1   Mean   :61.41  
##  3rd Qu.:7387   3rd Qu.:-145.6   3rd Qu.:64.13  
##  Max.   :9996   Max.   :-131.3   Max.   :70.37
```

3. Load a map from `stamen` in a terrain style projection and display the map.

```r
lat <- c(55.02, 60.37)
long <- c(-166.2, -131.3)
base_map_box <- make_bbox(long, lat, f = 0.05)
```


```r
base_map<-get_map(base_map_box, maptype = "terrain", source = "stamen")
```

```
## Map tiles by Stamen Design, under CC BY 3.0. Data by OpenStreetMap, under ODbL.
```

```r
ggmap(base_map)
```

![](lab12_hw_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

4. Build a final map that overlays the recorded observations of grizzly bears in Alaska.

```r
ggmap(base_map) + 
  geom_point(data = grizzly, aes(longitude, latitude)) +
  labs(x = "Longitude", y = "Latitude", title = "Bear Sghting Locations Locations")
```

```
## Warning: Removed 255 rows containing missing values (geom_point).
```

![](lab12_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

5. Let's switch to the wolves data. Load the data and evaluate its structure.

```r
wolves<-read_csv(here("lab12", "data", "wolves.csv")) %>% clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   pop = col_character(),
##   age.cat = col_character(),
##   sex = col_character(),
##   color = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
head(wolves)
```

```
## # A tibble: 6 x 23
##   pop     year age_cat sex   color   lat  long habitat human pop_density
##   <chr>  <dbl> <chr>   <chr> <chr> <dbl> <dbl>   <dbl> <dbl>       <dbl>
## 1 AK.PEN  2006 S       F     G      57.0 -158.    254.  10.4           8
## 2 AK.PEN  2006 S       M     G      57.0 -158.    254.  10.4           8
## 3 AK.PEN  2006 A       F     G      57.0 -158.    254.  10.4           8
## 4 AK.PEN  2006 S       M     B      57.0 -158.    254.  10.4           8
## 5 AK.PEN  2006 A       M     B      57.0 -158.    254.  10.4           8
## 6 AK.PEN  2006 A       M     G      57.0 -158.    254.  10.4           8
## # ... with 13 more variables: pack_size <dbl>, standard_habitat <dbl>,
## #   standard_human <dbl>, standard_pop <dbl>, standard_packsize <dbl>,
## #   standard_latitude <dbl>, standard_longitude <dbl>, cav_binary <dbl>,
## #   cdv_binary <dbl>, cpv_binary <dbl>, chv_binary <dbl>, neo_binary <dbl>,
## #   toxo_binary <dbl>
```

```r
glimpse(wolves)
```

```
## Rows: 1,986
## Columns: 23
## $ pop                <chr> "AK.PEN", "AK.PEN", "AK.PEN", "AK.PEN", "AK.PEN", "~
## $ year               <dbl> 2006, 2006, 2006, 2006, 2006, 2006, 2006, 2006, 200~
## $ age_cat            <chr> "S", "S", "A", "S", "A", "A", "A", "P", "S", "P", "~
## $ sex                <chr> "F", "M", "F", "M", "M", "M", "F", "M", "F", "M", "~
## $ color              <chr> "G", "G", "G", "B", "B", "G", "G", "G", "G", "G", "~
## $ lat                <dbl> 57.03983, 57.03983, 57.03983, 57.03983, 57.03983, 5~
## $ long               <dbl> -157.8427, -157.8427, -157.8427, -157.8427, -157.84~
## $ habitat            <dbl> 254.08, 254.08, 254.08, 254.08, 254.08, 254.08, 254~
## $ human              <dbl> 10.42, 10.42, 10.42, 10.42, 10.42, 10.42, 10.42, 10~
## $ pop_density        <dbl> 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, ~
## $ pack_size          <dbl> 8.78, 8.78, 8.78, 8.78, 8.78, 8.78, 8.78, 8.78, 8.7~
## $ standard_habitat   <dbl> -1.6339, -1.6339, -1.6339, -1.6339, -1.6339, -1.633~
## $ standard_human     <dbl> -0.9784, -0.9784, -0.9784, -0.9784, -0.9784, -0.978~
## $ standard_pop       <dbl> -0.6827, -0.6827, -0.6827, -0.6827, -0.6827, -0.682~
## $ standard_packsize  <dbl> 1.3157, 1.3157, 1.3157, 1.3157, 1.3157, 1.3157, 1.3~
## $ standard_latitude  <dbl> 0.7214, 0.7214, 0.7214, 0.7214, 0.7214, 0.7214, 0.7~
## $ standard_longitude <dbl> -2.1441, -2.1441, -2.1441, -2.1441, -2.1441, -2.144~
## $ cav_binary         <dbl> 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ~
## $ cdv_binary         <dbl> 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
## $ cpv_binary         <dbl> 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, ~
## $ chv_binary         <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, ~
## $ neo_binary         <dbl> NA, NA, NA, 0, 0, NA, NA, 1, 0, 1, NA, 0, NA, NA, N~
## $ toxo_binary        <dbl> NA, NA, NA, 1, 0, NA, NA, 1, 0, 0, NA, 0, NA, NA, N~
```

6. How many distinct wolf populations are included in this study? Mae a new object that restricts the data to the wolf populations in the lower 48 US states.

```r
wolves%>%
  tabyl(pop)
```

```
##      pop   n     percent
##   AK.PEN 100 0.050352467
##  BAN.JAS  96 0.048338369
##       BC 145 0.073011078
##   DENALI 154 0.077542800
##    ELLES  11 0.005538771
##     GTNP  60 0.030211480
##   INT.AK  35 0.017623364
##  MEXICAN 181 0.091137966
##       MI 102 0.051359517
##       MT 351 0.176737160
##    N.NWT  67 0.033736153
##      ONT  60 0.030211480
##    SE.AK  10 0.005035247
##      SNF  92 0.046324270
##   SS.NWT  34 0.017119839
##      YNP 383 0.192849950
##     YUCH 105 0.052870091
```



```r
wolves_lower_48<-wolves%>%
  filter(lat>31&lat<49&long>-125)
head(wolves_lower_48)
```

```
## # A tibble: 6 x 23
##   pop    year age_cat sex   color   lat  long habitat human pop_density
##   <chr> <dbl> <chr>   <chr> <chr> <dbl> <dbl>   <dbl> <dbl>       <dbl>
## 1 GTNP   2012 P       M     G      43.8 -111.  10375. 3924.        34.0
## 2 GTNP   2012 P       F     G      43.8 -111.  10375. 3924.        34.0
## 3 GTNP   2012 P       F     G      43.8 -111.  10375. 3924.        34.0
## 4 GTNP   2012 P       M     B      43.8 -111.  10375. 3924.        34.0
## 5 GTNP   2013 A       F     G      43.8 -111.  10375. 3924.        34.0
## 6 GTNP   2013 A       M     G      43.8 -111.  10375. 3924.        34.0
## # ... with 13 more variables: pack_size <dbl>, standard_habitat <dbl>,
## #   standard_human <dbl>, standard_pop <dbl>, standard_packsize <dbl>,
## #   standard_latitude <dbl>, standard_longitude <dbl>, cav_binary <dbl>,
## #   cdv_binary <dbl>, cpv_binary <dbl>, chv_binary <dbl>, neo_binary <dbl>,
## #   toxo_binary <dbl>
```



7. Use the `albersusa` package to make a base map of the lower 48 US states.

```r
us_comp <- usa_sf()
```


```r
ggplot() + 
  geom_sf(data = us_comp, size = 0.125) + 
  theme_linedraw()+
  labs(title = "USA Lower 48")
```

![](lab12_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->


8. Use the relimited data to plot the distribution of wolf populations in the lower 48 US states.

```r
ggplot() + 
  geom_sf(data = us_comp, size = 0.125) + 
  geom_point(data = wolves_lower_48,aes(long,lat,color=pop),size=2.5)+
  scale_color_brewer(palette = "Set1")+
  labs(title = "Wolf Populations in the Lower 48 States (USA)",x="Longitude",y="Latitude")
```

![](lab12_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

9. What is the average pack size for the wolves in this study by region?

```r
wolves_lower_48%>%
  group_by(pop)%>%
  summarise(mean_pack_size=mean(standard_packsize))
```

```
## # A tibble: 6 x 2
##   pop     mean_pack_size
## * <chr>            <dbl>
## 1 GTNP             0.916
## 2 MEXICAN         -1.47 
## 3 MI               0.340
## 4 MT              -0.542
## 5 SNF             -1.02 
## 6 YNP              1.00
```

10. Make a new map that shows the distribution of wolves in the lower 48 US states but which has the size of location markers adjusted by pack size.

```r
wolves_lower_48_new<-wolves_lower_48%>%
  group_by(pop)%>%
  mutate(mean_packsize=mean(standard_packsize))
head(wolves_lower_48_new)
```

```
## # A tibble: 6 x 24
## # Groups:   pop [1]
##   pop    year age_cat sex   color   lat  long habitat human pop_density
##   <chr> <dbl> <chr>   <chr> <chr> <dbl> <dbl>   <dbl> <dbl>       <dbl>
## 1 GTNP   2012 P       M     G      43.8 -111.  10375. 3924.        34.0
## 2 GTNP   2012 P       F     G      43.8 -111.  10375. 3924.        34.0
## 3 GTNP   2012 P       F     G      43.8 -111.  10375. 3924.        34.0
## 4 GTNP   2012 P       M     B      43.8 -111.  10375. 3924.        34.0
## 5 GTNP   2013 A       F     G      43.8 -111.  10375. 3924.        34.0
## 6 GTNP   2013 A       M     G      43.8 -111.  10375. 3924.        34.0
## # ... with 14 more variables: pack_size <dbl>, standard_habitat <dbl>,
## #   standard_human <dbl>, standard_pop <dbl>, standard_packsize <dbl>,
## #   standard_latitude <dbl>, standard_longitude <dbl>, cav_binary <dbl>,
## #   cdv_binary <dbl>, cpv_binary <dbl>, chv_binary <dbl>, neo_binary <dbl>,
## #   toxo_binary <dbl>, mean_packsize <dbl>
```



```r
ggplot() + 
  geom_sf(data = us_comp, size = 0.125) + 
  geom_point(data = wolves_lower_48_new,aes(long,lat,color=pop,size=mean_packsize))+
  scale_color_brewer(palette = "Set1")+
  labs(title = "Wolf Populations in the Lower 48 States (USA)",x="Longitude",y="Latitude")
```

![](lab12_hw_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
