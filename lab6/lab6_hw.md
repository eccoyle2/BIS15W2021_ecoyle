---
title: "Lab 6 Homework"
author: "Eric Coyle"
date: "2021-01-26"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
getwd
```

```
## function () 
## .Internal(getwd())
## <bytecode: 0x00000000155e07c0>
## <environment: namespace:base>
```



```r
fisheries <- readr::read_csv(file ="data/FAO_1950to2012_111914.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_character(),
##   `ISSCAAP group#` = col_double(),
##   `FAO major fishing area` = col_double()
## )
## i Use `spec()` for the full column specifications.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
glimpse(fisheries)
```

```
## Rows: 17,692
## Columns: 71
## $ Country                   <chr> "Albania", "Albania", "Albania", "Albania...
## $ `Common name`             <chr> "Angelsharks, sand devils nei", "Atlantic...
## $ `ISSCAAP group#`          <dbl> 38, 36, 37, 45, 32, 37, 33, 45, 38, 57, 3...
## $ `ISSCAAP taxonomic group` <chr> "Sharks, rays, chimaeras", "Tunas, bonito...
## $ `ASFIS species#`          <chr> "10903XXXXX", "1750100101", "17710001XX",...
## $ `ASFIS species name`      <chr> "Squatinidae", "Sarda sarda", "Sphyraena ...
## $ `FAO major fishing area`  <dbl> 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 3...
## $ Measure                   <chr> "Quantity (tonnes)", "Quantity (tonnes)",...
## $ `1950`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1951`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1952`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1953`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1954`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1955`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1956`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1957`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1958`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1959`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1960`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1961`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1962`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1963`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1964`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1965`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1966`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1967`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1968`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1969`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1970`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1971`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1972`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1973`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1974`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1975`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1976`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1977`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1978`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1979`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1980`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1981`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1982`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1983`                    <chr> NA, NA, NA, NA, NA, NA, "559", NA, NA, NA...
## $ `1984`                    <chr> NA, NA, NA, NA, NA, NA, "392", NA, NA, NA...
## $ `1985`                    <chr> NA, NA, NA, NA, NA, NA, "406", NA, NA, NA...
## $ `1986`                    <chr> NA, NA, NA, NA, NA, NA, "499", NA, NA, NA...
## $ `1987`                    <chr> NA, NA, NA, NA, NA, NA, "564", NA, NA, NA...
## $ `1988`                    <chr> NA, NA, NA, NA, NA, NA, "724", NA, NA, NA...
## $ `1989`                    <chr> NA, NA, NA, NA, NA, NA, "583", NA, NA, NA...
## $ `1990`                    <chr> NA, NA, NA, NA, NA, NA, "754", NA, NA, NA...
## $ `1991`                    <chr> NA, NA, NA, NA, NA, NA, "283", NA, NA, NA...
## $ `1992`                    <chr> NA, NA, NA, NA, NA, NA, "196", NA, NA, NA...
## $ `1993`                    <chr> NA, NA, NA, NA, NA, NA, "150 F", NA, NA, ...
## $ `1994`                    <chr> NA, NA, NA, NA, NA, NA, "100 F", NA, NA, ...
## $ `1995`                    <chr> "0 0", "1", NA, "0 0", "0 0", NA, "52", "...
## $ `1996`                    <chr> "53", "2", NA, "3", "2", NA, "104", "8", ...
## $ `1997`                    <chr> "20", "0 0", NA, "0 0", "0 0", NA, "65", ...
## $ `1998`                    <chr> "31", "12", NA, NA, NA, NA, "220", "18", ...
## $ `1999`                    <chr> "30", "30", NA, NA, NA, NA, "220", "18", ...
## $ `2000`                    <chr> "30", "25", "2", NA, NA, NA, "220", "20",...
## $ `2001`                    <chr> "16", "30", NA, NA, NA, NA, "120", "23", ...
## $ `2002`                    <chr> "79", "24", NA, "34", "6", NA, "150", "84...
## $ `2003`                    <chr> "1", "4", NA, "22", NA, NA, "84", "178", ...
## $ `2004`                    <chr> "4", "2", "2", "15", "1", "2", "76", "285...
## $ `2005`                    <chr> "68", "23", "4", "12", "5", "6", "68", "1...
## $ `2006`                    <chr> "55", "30", "7", "18", "8", "9", "86", "1...
## $ `2007`                    <chr> "12", "19", NA, NA, NA, NA, "132", "18", ...
## $ `2008`                    <chr> "23", "27", NA, NA, NA, NA, "132", "23", ...
## $ `2009`                    <chr> "14", "21", NA, NA, NA, NA, "154", "20", ...
## $ `2010`                    <chr> "78", "23", "7", NA, NA, NA, "80", "228",...
## $ `2011`                    <chr> "12", "12", NA, NA, NA, NA, "88", "9", NA...
## $ `2012`                    <chr> "5", "5", NA, NA, NA, NA, "129", "290", N...
```

```r
??fisheries
```

```
## starting httpd help server ... done
```

```r
head(fisheries)
```

```
## # A tibble: 6 x 71
##   Country `Common name` `ISSCAAP group#` `ISSCAAP taxono~ `ASFIS species#`
##   <chr>   <chr>                    <dbl> <chr>            <chr>           
## 1 Albania Angelsharks,~               38 Sharks, rays, c~ 10903XXXXX      
## 2 Albania Atlantic bon~               36 Tunas, bonitos,~ 1750100101      
## 3 Albania Barracudas n~               37 Miscellaneous p~ 17710001XX      
## 4 Albania Blue and red~               45 Shrimps, prawns  2280203101      
## 5 Albania Blue whiting~               32 Cods, hakes, ha~ 1480403301      
## 6 Albania Bluefish                    37 Miscellaneous p~ 1702021301      
## # ... with 66 more variables: `ASFIS species name` <chr>, `FAO major fishing
## #   area` <dbl>, Measure <chr>, `1950` <chr>, `1951` <chr>, `1952` <chr>,
## #   `1953` <chr>, `1954` <chr>, `1955` <chr>, `1956` <chr>, `1957` <chr>,
## #   `1958` <chr>, `1959` <chr>, `1960` <chr>, `1961` <chr>, `1962` <chr>,
## #   `1963` <chr>, `1964` <chr>, `1965` <chr>, `1966` <chr>, `1967` <chr>,
## #   `1968` <chr>, `1969` <chr>, `1970` <chr>, `1971` <chr>, `1972` <chr>,
## #   `1973` <chr>, `1974` <chr>, `1975` <chr>, `1976` <chr>, `1977` <chr>,
## #   `1978` <chr>, `1979` <chr>, `1980` <chr>, `1981` <chr>, `1982` <chr>,
## #   `1983` <chr>, `1984` <chr>, `1985` <chr>, `1986` <chr>, `1987` <chr>,
## #   `1988` <chr>, `1989` <chr>, `1990` <chr>, `1991` <chr>, `1992` <chr>,
## #   `1993` <chr>, `1994` <chr>, `1995` <chr>, `1996` <chr>, `1997` <chr>,
## #   `1998` <chr>, `1999` <chr>, `2000` <chr>, `2001` <chr>, `2002` <chr>,
## #   `2003` <chr>, `2004` <chr>, `2005` <chr>, `2006` <chr>, `2007` <chr>,
## #   `2008` <chr>, `2009` <chr>, `2010` <chr>, `2011` <chr>, `2012` <chr>
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries<-janitor::clean_names(fisheries)
names(fisheries)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "x1950"                   "x1951"                  
## [11] "x1952"                   "x1953"                  
## [13] "x1954"                   "x1955"                  
## [15] "x1956"                   "x1957"                  
## [17] "x1958"                   "x1959"                  
## [19] "x1960"                   "x1961"                  
## [21] "x1962"                   "x1963"                  
## [23] "x1964"                   "x1965"                  
## [25] "x1966"                   "x1967"                  
## [27] "x1968"                   "x1969"                  
## [29] "x1970"                   "x1971"                  
## [31] "x1972"                   "x1973"                  
## [33] "x1974"                   "x1975"                  
## [35] "x1976"                   "x1977"                  
## [37] "x1978"                   "x1979"                  
## [39] "x1980"                   "x1981"                  
## [41] "x1982"                   "x1983"                  
## [43] "x1984"                   "x1985"                  
## [45] "x1986"                   "x1987"                  
## [47] "x1988"                   "x1989"                  
## [49] "x1990"                   "x1991"                  
## [51] "x1992"                   "x1993"                  
## [53] "x1994"                   "x1995"                  
## [55] "x1996"                   "x1997"                  
## [57] "x1998"                   "x1999"                  
## [59] "x2000"                   "x2001"                  
## [61] "x2002"                   "x2003"                  
## [63] "x2004"                   "x2005"                  
## [65] "x2006"                   "x2007"                  
## [67] "x2008"                   "x2009"                  
## [69] "x2010"                   "x2011"                  
## [71] "x2012"
```


```r
fisheries$country <- as.factor(fisheries$country)
fisheries$isscaap_group_number <- as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number <- as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area <- as.factor(fisheries$fao_major_fishing_area)
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
names(fisheries_tidy)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "year"                    "catch"
```



```r
fisheries_tidy%>%
  count(country,sort=T)
```

```
## # A tibble: 203 x 2
##    country                      n
##    <fct>                    <int>
##  1 United States of America 18080
##  2 Spain                    17482
##  3 Japan                    15429
##  4 Portugal                 11570
##  5 Korea, Republic of       10824
##  6 France                   10639
##  7 Taiwan Province of China  9927
##  8 Indonesia                 9274
##  9 Australia                 8183
## 10 Un. Sov. Soc. Rep.        7084
## # ... with 193 more rows
```


```r
fisheries_tidy%>%
  summarise(n_country=n_distinct(country))
```

```
## # A tibble: 1 x 1
##   n_country
##       <int>
## 1       203
```

```r
names(fisheries_tidy)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "year"                    "catch"
```

```r
fisheries_tidy
```

```
## # A tibble: 376,771 x 10
##    country common_name isscaap_group_n~ isscaap_taxonom~ asfis_species_n~
##    <fct>   <chr>       <fct>            <chr>            <fct>           
##  1 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  2 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  3 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  4 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  5 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  6 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  7 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  8 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
##  9 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## 10 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## # ... with 376,761 more rows, and 5 more variables: asfis_species_name <chr>,
## #   fao_major_fishing_area <fct>, measure <chr>, year <dbl>, catch <dbl>
```

4. Refocus the data only to include only: country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.


```r
fisheries_tidy%>%
  select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch)
```

```
## # A tibble: 376,771 x 6
##    country isscaap_taxonomic_g~ asfis_species_na~ asfis_species_num~  year catch
##    <fct>   <chr>                <chr>             <fct>              <dbl> <dbl>
##  1 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1995    NA
##  2 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1996    53
##  3 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1997    20
##  4 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1998    31
##  5 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1999    30
##  6 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2000    30
##  7 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2001    16
##  8 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2002    79
##  9 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2003     1
## 10 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2004     4
## # ... with 376,761 more rows
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
fisheries_tidy%>%
  summarise(n_asfis_species_name=n_distinct(asfis_species_name))
```

```
## # A tibble: 1 x 1
##   n_asfis_species_name
##                  <int>
## 1                 1546
```

```r
fisheries_tidy%>%
  summarise(n_asfis_species_number=n_distinct(asfis_species_number))
```

```
## # A tibble: 1 x 1
##   n_asfis_species_number
##                    <int>
## 1                   1551
```
#some same species name get different species number (subspecies?)
6. Which country had the largest overall catch in the year 2000?


```r
fisheries_tidy%>%
  select(country,year,catch)%>%
  filter(year==2000)%>%
  group_by(country)%>%
  filter(!is.na(catch)) %>%
  summarize(catch_total=sum(catch))%>%
  arrange(catch_total)
```

```
## # A tibble: 187 x 2
##    country                 catch_total
##    <fct>                         <dbl>
##  1 Congo, Dem. Rep. of the           0
##  2 Guadeloupe                        0
##  3 Haiti                             0
##  4 Monaco                            3
##  5 Antigua and Barbuda               4
##  6 Wallis and Futuna Is.             4
##  7 Bosnia and Herzegovina            5
##  8 Pitcairn Islands                  5
##  9 Turks and Caicos Is.              6
## 10 French Guiana                     7
## # ... with 177 more rows
```
#China had the largest catch in 2000
7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
fisheries_tidy%>%
  select(country,asfis_species_name,year,catch)%>%
  filter(asfis_species_name=="Sardina pilchardus",between(year,1990,2000))%>%
  group_by(country)%>%
  filter(!is.na(catch))%>%
  summarize(catch_total=sum(catch))%>%
  arrange(catch_total)
```

```
## # A tibble: 37 x 2
##    country    catch_total
##    <fct>            <dbl>
##  1 Mauritania           0
##  2 Norway               1
##  3 Panama               2
##  4 Honduras             4
##  5 Other nei            6
##  6 Ireland              7
##  7 China                8
##  8 Belize              15
##  9 Cyprus              17
## 10 Poland              18
## # ... with 27 more rows
```
#Morocco caught the most sardines in that span, I actually have some cans of sardines from morocco in my cuppboard right now!

8. Which five countries caught the most cephalopods between 2008-2012?

```r
names(fisheries_tidy)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "year"                    "catch"
```

```r
head(fisheries_tidy)
```

```
## # A tibble: 6 x 10
##   country common_name isscaap_group_n~ isscaap_taxonom~ asfis_species_n~
##   <fct>   <chr>       <fct>            <chr>            <fct>           
## 1 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## 2 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## 3 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## 4 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## 5 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## 6 Albania Angelshark~ 38               Sharks, rays, c~ 10903XXXXX      
## # ... with 5 more variables: asfis_species_name <chr>,
## #   fao_major_fishing_area <fct>, measure <chr>, year <dbl>, catch <dbl>
```

```r
fisheries_tidy%>%
  tabyl(isscaap_taxonomic_group)
```

```
##               isscaap_taxonomic_group     n      percent
##             Abalones, winkles, conchs  3461 0.0091859511
##    Carps, barbels and other cyprinids  1483 0.0039360779
##             Clams, cockles, arkshells  5378 0.0142739224
##                 Cods, hakes, haddocks 21616 0.0573717192
##                     Crabs, seaspiders  7578 0.0201130129
##            Flounders, halibuts, soles 18872 0.0500887807
##         Herrings, sardines, anchovies 17867 0.0474213780
##  Horseshoe crabs and other arachnoids    80 0.0002123306
##             King crabs, squatlobsters   951 0.0025240796
##          Lobsters, spinyrock lobsters  8816 0.0233988285
##          Marine fishes not identified 16204 0.0430075563
##   Miscellaneous aquatic invertebrates  1036 0.0027496808
##          Miscellaneous coastal fishes 69821 0.1853141563
##         Miscellaneous demersal fishes 27360 0.0726170539
##       Miscellaneous diadromous fishes  1203 0.0031929209
##      Miscellaneous marine crustaceans  2975 0.0078960430
##         Miscellaneous marine molluscs  3516 0.0093319284
##          Miscellaneous pelagic fishes 38992 0.1034899183
##                               Mussels  1791 0.0047535506
##                               Oysters  1930 0.0051224749
##               Salmons, trouts, smelts  4728 0.0125487365
##                     Scallops, pectens  2340 0.0062106691
##      Seaurchins and other echinoderms  2340 0.0062106691
##                                 Shads  2605 0.0069140141
##               Sharks, rays, chimaeras 23210 0.0616024057
##                       Shrimps, prawns 13741 0.0364704290
##       Squids, cuttlefishes, octopuses 14532 0.0385698475
##               Sturgeons, paddlefishes   399 0.0010589987
##           Tilapias and other cichlids   107 0.0002839921
##            Tunas, bonitos, billfishes 61839 0.1641288740
```



```r
fisheries_tidy%>%
  select(country,isscaap_taxonomic_group,year,catch)%>%
  filter(isscaap_taxonomic_group=="Squids, cuttlefishes, octopuses",between(year,2008,2012))%>%
  group_by(country)%>%
  filter(!is.na(catch))%>%
  summarize(catch_total=sum(catch))%>%
  arrange(catch_total)
```

```
## # A tibble: 116 x 2
##    country                    catch_total
##    <fct>                            <dbl>
##  1 "China, Hong Kong SAR"               0
##  2 "Korea, Dem. People's Rep"           0
##  3 "Libya"                              0
##  4 "Sri Lanka"                          0
##  5 "Viet Nam"                           0
##  6 "American Samoa"                     1
##  7 "Netherlands"                        1
##  8 "New Caledonia"                      1
##  9 "R\xe9union"                         1
## 10 "Vanuatu"                            1
## # ... with 106 more rows
```
#china caught the most cephalopods in that time frame

9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
fisheries_tidy%>%
  select(common_name,asfis_species_name,year,catch)%>%
  filter(between(year,2008,2012))%>%
  group_by(asfis_species_name)%>%
  filter(!is.na(catch))%>%
  summarize(catch_total=sum(catch))%>%
  arrange(desc(catch_total))
```

```
## # A tibble: 1,353 x 2
##    asfis_species_name    catch_total
##    <chr>                       <dbl>
##  1 Osteichthyes               107808
##  2 Theragra chalcogramma       41075
##  3 Engraulis ringens           35523
##  4 Katsuwonus pelamis          32153
##  5 Trichiurus lepturus         30400
##  6 Clupea harengus             28527
##  7 Thunnus albacares           20119
##  8 Scomber japonicus           14723
##  9 Gadus morhua                13253
## 10 Thunnus alalunga            12019
## # ... with 1,343 more rows
```
##Theragra chalcogramma has the highest catch total for 2008-2012

10. Use the data to do at least one analysis of your choice.

```r
fisheries_tidy%>%
  group_by(country)%>%
  filter(!is.na(catch))%>%
  summarise(mean_catch=mean(catch))%>%
  arrange(mean_catch)
```

```
## # A tibble: 199 x 2
##    country                  mean_catch
##    <fct>                         <dbl>
##  1 Guadeloupe                    0.219
##  2 Bonaire/S.Eustatius/Saba      1    
##  3 Sint Maarten                  1    
##  4 Monaco                        1.95 
##  5 Ethiopia                      3.18 
##  6 Bosnia and Herzegovina        3.95 
##  7 Pitcairn Islands              4.13 
##  8 Haiti                         5.24 
##  9 Libya                         6.61 
## 10 Turks and Caicos Is.          7.12 
## # ... with 189 more rows
```

```r
fisheries_tidy%>%
  summarize(across(c(common_name,asfis_species_number,asfis_species_name,isscaap_group_number,isscaap_taxonomic_group), n_distinct))
```

```
## # A tibble: 1 x 5
##   common_name asfis_species_n~ asfis_species_n~ isscaap_group_n~
##         <int>            <int>            <int>            <int>
## 1        1551             1551             1546               30
## # ... with 1 more variable: isscaap_taxonomic_group <int>
```
##so every common name gets its own asfis species number but not asfis species name. 

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
