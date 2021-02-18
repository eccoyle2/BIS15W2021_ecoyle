---
title: "Intro to Spatial Data 1"
date: "2021-02-17"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
---



## Learning Goals
*At the end of this exercise, you will be able to:*  
1. List and join multiple files from a directory.  
2. Format dates in a data frame. 

## Listing Files in Folder

Often, the data we need is split up into multiple files, either by some geographical variable such as county, or by a time consitiuent such as months or weeks. The best method to deal with data in multiple files will be quick and also reproducible. We want to avoid doing anything by hand (besides very minor editing) to the original files someone sends us. We want everything to be reproducible so we can easily track any problems or errors that may crop up and prevent us from making careless errors ourselves. 

So copying/pasting multiple files together isn't an option for us. Let's see how we can do this in R. In the `data/spiders` folder there are 32 files, each named for a county in California. Each file contains a record of an observation of a type of cave spider. Each observation contains a unique ID for each spider as well as some other important information such as date and location name. Let's use R to list all the `.csv` files in the `spiders` folder.

But first, load the tidyverse.

```r
library(tidyverse)
```


```r
getwd()
#> [1] "C:/Users/ericc/Desktop/BIS15W2021_ecoyle/Final Project/Map tutorial_lab9"
```


```r
files <- list.files(path = "data/spiders", pattern = ".csv")
files
#>  [1] "Alameda .csv"        "Amador .csv"         "Butte .csv"         
#>  [4] "Calaveras .csv"      "Contra Costa .csv"   "Del Norte .csv"     
#>  [7] "El Dorado .csv"      "Humboldt .csv"       "Kern .csv"          
#> [10] "Marin .csv"          "Mariposa .csv"       "Mendocino .csv"     
#> [13] "Monterey .csv"       "Napa .csv"           "Placer .csv"        
#> [16] "Plumas .csv"         "San Bernandino .csv" "San Francisco .csv" 
#> [19] "San Mateo .csv"      "Santa Clara .csv"    "Santa Cruz .csv"    
#> [22] "Shasta .csv"         "Sierra .csv"         "Siskiyou .csv"      
#> [25] "Solano .csv"         "Sonoma .csv"         "Stanislaus .csv"    
#> [28] "Tehama .csv"         "Trinity .csv"        "Tulare .csv"        
#> [31] "Tuolumne .csv"       "Yolo .csv"
```

We could also get the full path names with `full.names = TRUE`.

```r
files <- list.files(path = "data/spiders", pattern = ".csv", full.names = TRUE)
files
#>  [1] "data/spiders/Alameda .csv"        "data/spiders/Amador .csv"        
#>  [3] "data/spiders/Butte .csv"          "data/spiders/Calaveras .csv"     
#>  [5] "data/spiders/Contra Costa .csv"   "data/spiders/Del Norte .csv"     
#>  [7] "data/spiders/El Dorado .csv"      "data/spiders/Humboldt .csv"      
#>  [9] "data/spiders/Kern .csv"           "data/spiders/Marin .csv"         
#> [11] "data/spiders/Mariposa .csv"       "data/spiders/Mendocino .csv"     
#> [13] "data/spiders/Monterey .csv"       "data/spiders/Napa .csv"          
#> [15] "data/spiders/Placer .csv"         "data/spiders/Plumas .csv"        
#> [17] "data/spiders/San Bernandino .csv" "data/spiders/San Francisco .csv" 
#> [19] "data/spiders/San Mateo .csv"      "data/spiders/Santa Clara .csv"   
#> [21] "data/spiders/Santa Cruz .csv"     "data/spiders/Shasta .csv"        
#> [23] "data/spiders/Sierra .csv"         "data/spiders/Siskiyou .csv"      
#> [25] "data/spiders/Solano .csv"         "data/spiders/Sonoma .csv"        
#> [27] "data/spiders/Stanislaus .csv"     "data/spiders/Tehama .csv"        
#> [29] "data/spiders/Trinity .csv"        "data/spiders/Tulare .csv"        
#> [31] "data/spiders/Tuolumne .csv"       "data/spiders/Yolo .csv"
```

Now we want to read each of these files into R without having to do them one at a time because there are quite a few. There are several ways to do this, but a quick and straightforward way is to import them as a list. A list in R is an object which can store multiple other objects of the same or differing types. Lists are common in R so it's useful to be comfortable with them. Let's import our csv files into a list. The `lapply()` funtion is a part of the `apply` family of functions. It will iterate over elements of an object, apply a function we specify, and return a list. We have a character vector of file paths, so we want to iterate over all the path names and apply `read_csv()`.


```r
spider_list <- 
  lapply(files, read_csv)
class(spider_list)
#> [1] "list"
```

We can view elements in our list with double brackets. Let's view the data for Butte county. 

```r
spider_list[[3]]
#> # A tibble: 1 x 9
#>   Accession Family  Genus  Country State   County Locality       Date  Collector
#>       <dbl> <chr>   <chr>  <chr>   <chr>   <chr>  <chr>          <chr> <chr>    
#> 1   9038509 Telemi~ Usofi~ USA     Califo~ Butte  Dry Creek Rd,~ 2/3/~ RO Schus~
class(spider_list[[3]])
#> [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
```

## Practice

What are the names of our list elements?

```r
names(spider_list[[3]])
#> [1] "Accession" "Family"    "Genus"     "Country"   "State"     "County"   
#> [7] "Locality"  "Date"      "Collector"
```

## Naming List Elements
We don't need to here, but for demonstration purposes we can name the elements in our list. We will first get the names of each file, but we only want the county part. We will use `strsplit()` for that, which creates a nested list of strings. We want to keep the first element of each list element. Because there is only one element in each nested list element, we can use `unlist()`.

```r
names <- list.files(path = "data/spiders", pattern = ".csv")
names_list <- strsplit(names, split = " .csv")
names_list
#> [[1]]
#> [1] "Alameda"
#> 
#> [[2]]
#> [1] "Amador"
#> 
#> [[3]]
#> [1] "Butte"
#> 
#> [[4]]
#> [1] "Calaveras"
#> 
#> [[5]]
#> [1] "Contra Costa"
#> 
#> [[6]]
#> [1] "Del Norte"
#> 
#> [[7]]
#> [1] "El Dorado"
#> 
#> [[8]]
#> [1] "Humboldt"
#> 
#> [[9]]
#> [1] "Kern"
#> 
#> [[10]]
#> [1] "Marin"
#> 
#> [[11]]
#> [1] "Mariposa"
#> 
#> [[12]]
#> [1] "Mendocino"
#> 
#> [[13]]
#> [1] "Monterey"
#> 
#> [[14]]
#> [1] "Napa"
#> 
#> [[15]]
#> [1] "Placer"
#> 
#> [[16]]
#> [1] "Plumas"
#> 
#> [[17]]
#> [1] "San Bernandino"
#> 
#> [[18]]
#> [1] "San Francisco"
#> 
#> [[19]]
#> [1] "San Mateo"
#> 
#> [[20]]
#> [1] "Santa Clara"
#> 
#> [[21]]
#> [1] "Santa Cruz"
#> 
#> [[22]]
#> [1] "Shasta"
#> 
#> [[23]]
#> [1] "Sierra"
#> 
#> [[24]]
#> [1] "Siskiyou"
#> 
#> [[25]]
#> [1] "Solano"
#> 
#> [[26]]
#> [1] "Sonoma"
#> 
#> [[27]]
#> [1] "Stanislaus"
#> 
#> [[28]]
#> [1] "Tehama"
#> 
#> [[29]]
#> [1] "Trinity"
#> 
#> [[30]]
#> [1] "Tulare"
#> 
#> [[31]]
#> [1] "Tuolumne"
#> 
#> [[32]]
#> [1] "Yolo"
```


```r
names_vec <- unlist(names_list)
names_vec
#>  [1] "Alameda"        "Amador"         "Butte"          "Calaveras"     
#>  [5] "Contra Costa"   "Del Norte"      "El Dorado"      "Humboldt"      
#>  [9] "Kern"           "Marin"          "Mariposa"       "Mendocino"     
#> [13] "Monterey"       "Napa"           "Placer"         "Plumas"        
#> [17] "San Bernandino" "San Francisco"  "San Mateo"      "Santa Clara"   
#> [21] "Santa Cruz"     "Shasta"         "Sierra"         "Siskiyou"      
#> [25] "Solano"         "Sonoma"         "Stanislaus"     "Tehama"        
#> [29] "Trinity"        "Tulare"         "Tuolumne"       "Yolo"
```


```r
names(spider_list) <- names_vec
names(spider_list)
#>  [1] "Alameda"        "Amador"         "Butte"          "Calaveras"     
#>  [5] "Contra Costa"   "Del Norte"      "El Dorado"      "Humboldt"      
#>  [9] "Kern"           "Marin"          "Mariposa"       "Mendocino"     
#> [13] "Monterey"       "Napa"           "Placer"         "Plumas"        
#> [17] "San Bernandino" "San Francisco"  "San Mateo"      "Santa Clara"   
#> [21] "Santa Cruz"     "Shasta"         "Sierra"         "Siskiyou"      
#> [25] "Solano"         "Sonoma"         "Stanislaus"     "Tehama"        
#> [29] "Trinity"        "Tulare"         "Tuolumne"       "Yolo"
```

## Practice

Now that our list elements are named, how could we access the Butte County data by name?

```r
spider_list$Butte
#> # A tibble: 1 x 9
#>   Accession Family  Genus  Country State   County Locality       Date  Collector
#>       <dbl> <chr>   <chr>  <chr>   <chr>   <chr>  <chr>          <chr> <chr>    
#> 1   9038509 Telemi~ Usofi~ USA     Califo~ Butte  Dry Creek Rd,~ 2/3/~ RO Schus~
```

## Merging Files

We are fortunate here in that all of our data frames have the same column names. This makes it easy to merge the data together with `bind_rows()` from`dplyr`. `bind_rows()` matches columns by name.


```r
spiders_all <- bind_rows(spider_list)
head(spiders_all)
#> # A tibble: 6 x 9
#>   Accession Family  Genus  Country State   County Locality       Date  Collector
#>       <dbl> <chr>   <chr>  <chr>   <chr>   <chr>  <chr>          <chr> <chr>    
#> 1   9038521 Telemi~ Usofi~ USA     Califo~ Alame~ Berkeley       2/3/~ LM Smith 
#> 2   9038522 Telemi~ Usofi~ USA     Califo~ Alame~ Castro Valley  24/3~ WM Pearce
#> 3   9038523 Telemi~ Usofi~ USA     Califo~ Alame~ Niles, off Ni~ 2/1/~ V Roth   
#> 4   9038524 Telemi~ Usofi~ USA     Califo~ Alame~ Oakland        18/2~ WG Benti~
#> 5   9038525 Telemi~ Usofi~ USA     Califo~ Alame~ Oakland        25/1~ R Schust~
#> 6   9038526 Telemi~ Usofi~ USA     Califo~ Alame~ Oakland        18/2~ WC Benti~
view(spiders_all)
```

## Joining Files

Sometimes data we need is stored in a separate file or becomes available later and we need to join it to our existing data in order to work with it. Here, the latitude and longitude for each spider were recorded from the field records at a later date, and now we need to join it to our rbinded data frame. The lat/long were recorded into one single file for each observation. Let's read in the lat/long data. 

```r
spiders_locs <- read_csv("data/spiders locations/spiders_locations.csv") 
```


```r
head(spiders_locs)
#> # A tibble: 6 x 3
#>   Accession Latitude Longitude
#>       <dbl>    <dbl>     <dbl>
#> 1   9038521     37.9     -122.
#> 2   9038522     37.7     -122.
#> 3   9038523     37.6     -122.
#> 4   9038524     37.8     -122.
#> 5   9038525     37.8     -122.
#> 6   9038526     37.8     -122.
```

We will use a join here to merge lat/long to our data frame. There are several types of join in `dplyr`. It's always a good idea to read the help for the join function you are using and make sure it meets your needs. Both files contain a unique identifier called `Accession` which we will use to join.

## Practice

Read the help for `dplyr::join`. How many different types of joins are there?

```r
?join
#> starting httpd help server ... done
```

Let's use the `left_join()` function in case there are no matching locations for some of our observations. 

```r
spiders_with_locs <- left_join(spiders_all, spiders_locs, by = c("Accession"))
summary(spiders_with_locs)
#>    Accession           Family             Genus             Country         
#>  Min.   : 9034549   Length:270         Length:270         Length:270        
#>  1st Qu.: 9038573   Class :character   Class :character   Class :character  
#>  Median : 9038644   Mode  :character   Mode  :character   Mode  :character  
#>  Mean   : 9641191                                                           
#>  3rd Qu.: 9038718                                                           
#>  Max.   :90387441                                                           
#>     State              County            Locality             Date          
#>  Length:270         Length:270         Length:270         Length:270        
#>  Class :character   Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
#>                                                                             
#>                                                                             
#>                                                                             
#>   Collector            Latitude       Longitude     
#>  Length:270         Min.   :34.67   Min.   :-124.1  
#>  Class :character   1st Qu.:37.88   1st Qu.:-122.5  
#>  Mode  :character   Median :38.19   Median :-122.1  
#>                     Mean   :38.49   Mean   :-121.6  
#>                     3rd Qu.:38.88   3rd Qu.:-120.5  
#>                     Max.   :44.51   Max.   :-115.5
```

```r
head(spiders_with_locs)
#> # A tibble: 6 x 11
#>   Accession Family Genus Country State County Locality Date  Collector Latitude
#>       <dbl> <chr>  <chr> <chr>   <chr> <chr>  <chr>    <chr> <chr>        <dbl>
#> 1   9038521 Telem~ Usof~ USA     Cali~ Alame~ Berkeley 2/3/~ LM Smith      37.9
#> 2   9038522 Telem~ Usof~ USA     Cali~ Alame~ Castro ~ 24/3~ WM Pearce     37.7
#> 3   9038523 Telem~ Usof~ USA     Cali~ Alame~ Niles, ~ 2/1/~ V Roth        37.6
#> 4   9038524 Telem~ Usof~ USA     Cali~ Alame~ Oakland  18/2~ WG Benti~     37.8
#> 5   9038525 Telem~ Usof~ USA     Cali~ Alame~ Oakland  25/1~ R Schust~     37.8
#> 6   9038526 Telem~ Usof~ USA     Cali~ Alame~ Oakland  18/2~ WC Benti~     37.8
#> # ... with 1 more variable: Longitude <dbl>
```

As a side note, often joining data can highlight problems or typos with the data when the join does not go as expected. 

## Formatting Dates

We finally have a single data frame with all our spider data including locations. That was a lot of work, even with R. But remember, now we have a reproducible workflow starting from the original files. This workflow serves as a record of what we did, keeps the original files untouched, and can make it easier to track down problems later in our analysis. 

There is one last thing to change. Did you notice the date column? It seems to be in the format Day/Month/Year. We want to change our date column to the standard "YEAR-MO-DA" format that R will recognize as a date. We can use the base R function `as.Date()` for this. We need to tell the function what format our date is currently in. To do this we put a percent sign in front of the letter corresponding to the year, month, or day, and the characters used to separate them in our current date ("%d/%m/%y").


```r
spiders_with_locs$Date <-  as.Date(spiders_with_locs$Date, format = "%d/%m/%y")
class(spiders_with_locs$Date)
#> [1] "Date"
head(spiders_with_locs$Date)
#> [1] "2019-03-02" "2019-03-24" "2019-01-02" "2019-02-18" "2019-01-25"
#> [6] "2019-02-18"
```

The `lubridate` package was specifically created to deal with dates of all types. There are many useful functions in `lubridate` for working with dates if you need to go beyond `as.Date()`.

We should save our final data frame to a csv so we can use it later. 

```r
write.csv(spiders_with_locs, file = "spiders_with_locs.csv", row.names = FALSE)
```

## That's it, let's take a break!   

-->[Home](https://jmledford3115.github.io/datascibiol/)
