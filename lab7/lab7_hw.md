---
title: "Lab 7 Homework"
author: "Eric Coyle"
date: "2021-02-02"
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

## Data
**1. For this homework, we will use two different data sets. Please load `amniota` and `amphibio`.**  

`amniota` data:  
Myhrvold N, Baldridge E, Chan B, Sivam D, Freeman DL, Ernest SKM (2015). “An amniote life-history
database to perform comparative analyses with birds, mammals, and reptiles.” _Ecology_, *96*, 3109.
doi: 10.1890/15-0846.1 (URL: https://doi.org/10.1890/15-0846.1).

```r
amniota<-readr::read_csv("data/amniota.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   common_name = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
amniota<-janitor::clean_names(amniota)
```

`amphibio` data:  
Oliveira BF, São-Pedro VA, Santos-Barrera G, Penone C, Costa GC (2017). “AmphiBIO, a global database
for amphibian ecological traits.” _Scientific Data_, *4*, 170123. doi: 10.1038/sdata.2017.123 (URL:
https://doi.org/10.1038/sdata.2017.123).

```r
amphibio<-readr::read_csv("data/amphibio.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   id = col_character(),
##   Order = col_character(),
##   Family = col_character(),
##   Genus = col_character(),
##   Species = col_character(),
##   Seeds = col_logical(),
##   OBS = col_logical()
## )
## i Use `spec()` for the full column specifications.
```

```
## Warning: 125 parsing failures.
##  row col           expected                                                           actual                file
## 1410 OBS 1/0/T/F/TRUE/FALSE Identified as P. appendiculata in Boquimpani-Freitas et al. 2002 'data/amphibio.csv'
## 1416 OBS 1/0/T/F/TRUE/FALSE Identified as T. miliaris in Giaretta and Facure 2004            'data/amphibio.csv'
## 1447 OBS 1/0/T/F/TRUE/FALSE Considered endangered by Soto-Azat et al. 2013                   'data/amphibio.csv'
## 1448 OBS 1/0/T/F/TRUE/FALSE Considered extinct by Soto-Azat et al. 2013                      'data/amphibio.csv'
## 1471 OBS 1/0/T/F/TRUE/FALSE nomem dubitum                                                    'data/amphibio.csv'
## .... ... .................. ................................................................ ...................
## See problems(...) for more details.
```

```r
amphibio<-janitor::clean_names(amphibio)
```

## Questions  
**2. Do some exploratory analysis of the `amniota` data set. Use the function(s) of your choice. Try to get an idea of how NA's are represented in the data.**  


```r
summary(amniota)
```

```
##     class              order              family             genus          
##  Length:21322       Length:21322       Length:21322       Length:21322      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##    species            subspecies   common_name        female_maturity_d 
##  Length:21322       Min.   :-999   Length:21322       Min.   :-30258.7  
##  Class :character   1st Qu.:-999   Class :character   1st Qu.:  -999.0  
##  Mode  :character   Median :-999   Mode  :character   Median :  -999.0  
##                     Mean   :-999                      Mean   :  -723.7  
##                     3rd Qu.:-999                      3rd Qu.:  -999.0  
##                     Max.   :-999                      Max.   :  9131.2  
##  litter_or_clutch_size_n litters_or_clutches_per_y adult_body_mass_g  
##  Min.   :-999.000        Min.   :-999.0            Min.   :     -999  
##  1st Qu.:-999.000        1st Qu.:-999.0            1st Qu.:        4  
##  Median :   1.692        Median :-999.0            Median :       24  
##  Mean   :-383.909        Mean   :-766.8            Mean   :    29107  
##  3rd Qu.:   3.200        3rd Qu.:-999.0            3rd Qu.:      135  
##  Max.   : 156.000        Max.   :  52.0            Max.   :149000000  
##  maximum_longevity_y  gestation_d       weaning_d     
##  Min.   :-999.000    Min.   :-999.0   Min.   :-999.0  
##  1st Qu.:-999.000    1st Qu.:-999.0   1st Qu.:-999.0  
##  Median :-999.000    Median :-999.0   Median :-999.0  
##  Mean   :-737.061    Mean   :-874.9   Mean   :-892.4  
##  3rd Qu.:   1.083    3rd Qu.:-999.0   3rd Qu.:-999.0  
##  Max.   : 211.000    Max.   :7396.9   Max.   :1826.2  
##  birth_or_hatching_weight_g weaning_weight_g     egg_mass_g     
##  Min.   :   -999.0          Min.   :    -999   Min.   :-999.00  
##  1st Qu.:   -999.0          1st Qu.:    -999   1st Qu.:-999.00  
##  Median :   -999.0          Median :    -999   Median :-999.00  
##  Mean   :    -88.6          Mean   :    1116   Mean   :-739.64  
##  3rd Qu.:   -999.0          3rd Qu.:    -999   3rd Qu.:   0.56  
##  Max.   :2250000.0          Max.   :17000000   Max.   :1500.00  
##   incubation_d    fledging_age_d    longevity_y       male_maturity_d 
##  Min.   :-999.0   Min.   :-999.0   Min.   :-999.000   Min.   :-999.0  
##  1st Qu.:-999.0   1st Qu.:-999.0   1st Qu.:-999.000   1st Qu.:-999.0  
##  Median :-999.0   Median :-999.0   Median :-999.000   Median :-999.0  
##  Mean   :-820.5   Mean   :-909.4   Mean   :-737.821   Mean   :-827.8  
##  3rd Qu.:-999.0   3rd Qu.:-999.0   3rd Qu.:   1.042   3rd Qu.:-999.0  
##  Max.   :1762.0   Max.   : 345.0   Max.   : 177.000   Max.   :9131.2  
##  inter_litter_or_interbirth_interval_y female_body_mass_g male_body_mass_g 
##  Min.   :-999.000                      Min.   :   -999    Min.   :   -999  
##  1st Qu.:-999.000                      1st Qu.:   -999    1st Qu.:   -999  
##  Median :-999.000                      Median :   -999    Median :   -999  
##  Mean   :-932.502                      Mean   :     41    Mean   :   1243  
##  3rd Qu.:-999.000                      3rd Qu.:     14    3rd Qu.:     13  
##  Max.   :   4.847                      Max.   :3700000    Max.   :4545000  
##  no_sex_body_mass_g   egg_width_mm    egg_length_mm    fledging_mass_g 
##  Min.   :     -999   Min.   :-999.0   Min.   :-999.0   Min.   :-999.0  
##  1st Qu.:     -999   1st Qu.:-999.0   1st Qu.:-999.0   1st Qu.:-999.0  
##  Median :     -999   Median :-999.0   Median :-999.0   Median :-999.0  
##  Mean   :    30689   Mean   :-970.5   Mean   :-968.9   Mean   :-984.6  
##  3rd Qu.:       28   3rd Qu.:-999.0   3rd Qu.:-999.0   3rd Qu.:-999.0  
##  Max.   :136000000   Max.   : 125.0   Max.   : 455.0   Max.   :9992.0  
##   adult_svl_cm       male_svl_cm     female_svl_cm    birth_or_hatching_svl_cm
##  Min.   :-999.000   Min.   :-999.0   Min.   :-999.0   Min.   :-999.0          
##  1st Qu.:-999.000   1st Qu.:-999.0   1st Qu.:-999.0   1st Qu.:-999.0          
##  Median :-999.000   Median :-999.0   Median :-999.0   Median :-999.0          
##  Mean   :-656.153   Mean   :-985.1   Mean   :-947.4   Mean   :-940.3          
##  3rd Qu.:   9.499   3rd Qu.:-999.0   3rd Qu.:-999.0   3rd Qu.:-999.0          
##  Max.   :3049.000   Max.   : 315.2   Max.   :1125.0   Max.   : 760.0          
##  female_svl_at_maturity_cm female_body_mass_at_maturity_g no_sex_svl_cm   
##  Min.   :-999.0            Min.   :  -999.0               Min.   :-999.0  
##  1st Qu.:-999.0            1st Qu.:  -999.0               1st Qu.:-999.0  
##  Median :-999.0            Median :  -999.0               Median :-999.0  
##  Mean   :-989.4            Mean   :  -980.6               Mean   :-747.1  
##  3rd Qu.:-999.0            3rd Qu.:  -999.0               3rd Qu.:-999.0  
##  Max.   : 580.0            Max.   :194000.0               Max.   :3300.0  
##  no_sex_maturity_d
##  Min.   : -999.0  
##  1st Qu.: -999.0  
##  Median : -999.0  
##  Mean   : -942.6  
##  3rd Qu.: -999.0  
##  Max.   :14610.0
```

```r
anyNA(amniota)
```

```
## [1] FALSE
```

```r
amniota%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 36 x 3
##    variable                  n_miss pct_miss
##    <chr>                      <int>    <dbl>
##  1 class                          0        0
##  2 order                          0        0
##  3 family                         0        0
##  4 genus                          0        0
##  5 species                        0        0
##  6 subspecies                     0        0
##  7 common_name                    0        0
##  8 female_maturity_d              0        0
##  9 litter_or_clutch_size_n        0        0
## 10 litters_or_clutches_per_y      0        0
## # ... with 26 more rows
```

```r
amniota_tidy<-amniota%>%
  na_if("-999")
```


```r
amniota_tidy%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 36 x 3
##    variable                       n_miss pct_miss
##    <chr>                           <int>    <dbl>
##  1 subspecies                      21322    100  
##  2 female_body_mass_at_maturity_g  21318    100. 
##  3 female_svl_at_maturity_cm       21120     99.1
##  4 fledging_mass_g                 21111     99.0
##  5 male_svl_cm                     21040     98.7
##  6 no_sex_maturity_d               20860     97.8
##  7 egg_width_mm                    20727     97.2
##  8 egg_length_mm                   20702     97.1
##  9 weaning_weight_g                20258     95.0
## 10 female_svl_cm                   20242     94.9
## # ... with 26 more rows
```

**3. Do some exploratory analysis of the `amphibio` data set. Use the function(s) of your choice. Try to get an idea of how NA's are represented in the data.**  


```r
glimpse(amphibio)
```

```
## Rows: 6,776
## Columns: 38
## $ id                      <chr> "Anf0001", "Anf0002", "Anf0003", "Anf0004",...
## $ order                   <chr> "Anura", "Anura", "Anura", "Anura", "Anura"...
## $ family                  <chr> "Allophrynidae", "Alytidae", "Alytidae", "A...
## $ genus                   <chr> "Allophryne", "Alytes", "Alytes", "Alytes",...
## $ species                 <chr> "Allophryne ruthveni", "Alytes cisternasii"...
## $ fos                     <dbl> NA, NA, NA, NA, NA, 1, 1, 1, 1, 1, 1, 1, 1,...
## $ ter                     <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
## $ aqu                     <dbl> 1, 1, 1, 1, NA, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
## $ arb                     <dbl> 1, 1, 1, 1, 1, 1, NA, NA, NA, NA, NA, NA, N...
## $ leaves                  <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ flowers                 <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ seeds                   <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ fruits                  <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ arthro                  <dbl> 1, 1, 1, NA, 1, 1, 1, 1, 1, NA, 1, 1, NA, N...
## $ vert                    <dbl> NA, NA, NA, NA, NA, NA, 1, NA, NA, NA, 1, 1...
## $ diu                     <dbl> 1, NA, NA, NA, NA, NA, 1, 1, 1, NA, 1, 1, N...
## $ noc                     <dbl> 1, 1, 1, NA, 1, 1, 1, 1, 1, NA, 1, 1, 1, NA...
## $ crepu                   <dbl> 1, NA, NA, NA, NA, 1, NA, NA, NA, NA, NA, N...
## $ wet_warm                <dbl> NA, NA, NA, NA, 1, 1, NA, NA, NA, NA, 1, NA...
## $ wet_cold                <dbl> 1, NA, NA, NA, NA, NA, 1, NA, NA, NA, NA, N...
## $ dry_warm                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ dry_cold                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ body_mass_g             <dbl> 31.00, 6.10, NA, NA, 2.31, 13.40, 21.80, NA...
## $ age_at_maturity_min_y   <dbl> NA, 2.0, 2.0, NA, 3.0, 2.0, 3.0, NA, NA, NA...
## $ age_at_maturity_max_y   <dbl> NA, 2.0, 2.0, NA, 3.0, 3.0, 5.0, NA, NA, NA...
## $ body_size_mm            <dbl> 31.0, 50.0, 55.0, NA, 40.0, 55.0, 80.0, 60....
## $ size_at_maturity_min_mm <dbl> NA, 27, NA, NA, NA, 35, NA, NA, NA, NA, NA,...
## $ size_at_maturity_max_mm <dbl> NA, 36.0, NA, NA, NA, 40.5, NA, NA, NA, NA,...
## $ longevity_max_y         <dbl> NA, 6, NA, NA, NA, 7, 9, NA, NA, NA, NA, NA...
## $ litter_size_min_n       <dbl> 300, 60, 40, NA, 7, 53, 300, 1500, 1000, NA...
## $ litter_size_max_n       <dbl> 300, 180, 40, NA, 20, 171, 1500, 1500, 1000...
## $ reproductive_output_y   <dbl> 1, 4, 1, 4, 1, 4, 6, 1, 1, 1, 1, 1, 1, 1, N...
## $ offspring_size_min_mm   <dbl> NA, 2.6, NA, NA, 5.4, 2.6, 1.5, NA, 1.5, NA...
## $ offspring_size_max_mm   <dbl> NA, 3.5, NA, NA, 7.0, 5.0, 2.0, NA, 1.5, NA...
## $ dir                     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ lar                     <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
## $ viv                     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ obs                     <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
```

```r
head(amphibio)
```

```
## # A tibble: 6 x 38
##   id    order family genus species   fos   ter   aqu   arb leaves flowers seeds
##   <chr> <chr> <chr>  <chr> <chr>   <dbl> <dbl> <dbl> <dbl>  <dbl>   <dbl> <lgl>
## 1 Anf0~ Anura Allop~ Allo~ Alloph~    NA     1     1     1     NA      NA NA   
## 2 Anf0~ Anura Alyti~ Alyt~ Alytes~    NA     1     1     1     NA      NA NA   
## 3 Anf0~ Anura Alyti~ Alyt~ Alytes~    NA     1     1     1     NA      NA NA   
## 4 Anf0~ Anura Alyti~ Alyt~ Alytes~    NA     1     1     1     NA      NA NA   
## 5 Anf0~ Anura Alyti~ Alyt~ Alytes~    NA     1    NA     1     NA      NA NA   
## 6 Anf0~ Anura Alyti~ Alyt~ Alytes~     1     1     1     1     NA      NA NA   
## # ... with 26 more variables: fruits <dbl>, arthro <dbl>, vert <dbl>,
## #   diu <dbl>, noc <dbl>, crepu <dbl>, wet_warm <dbl>, wet_cold <dbl>,
## #   dry_warm <dbl>, dry_cold <dbl>, body_mass_g <dbl>,
## #   age_at_maturity_min_y <dbl>, age_at_maturity_max_y <dbl>,
## #   body_size_mm <dbl>, size_at_maturity_min_mm <dbl>,
## #   size_at_maturity_max_mm <dbl>, longevity_max_y <dbl>,
## #   litter_size_min_n <dbl>, litter_size_max_n <dbl>,
## #   reproductive_output_y <dbl>, offspring_size_min_mm <dbl>,
## #   offspring_size_max_mm <dbl>, dir <dbl>, lar <dbl>, viv <dbl>, obs <lgl>
```

```r
names(amphibio)
```

```
##  [1] "id"                      "order"                  
##  [3] "family"                  "genus"                  
##  [5] "species"                 "fos"                    
##  [7] "ter"                     "aqu"                    
##  [9] "arb"                     "leaves"                 
## [11] "flowers"                 "seeds"                  
## [13] "fruits"                  "arthro"                 
## [15] "vert"                    "diu"                    
## [17] "noc"                     "crepu"                  
## [19] "wet_warm"                "wet_cold"               
## [21] "dry_warm"                "dry_cold"               
## [23] "body_mass_g"             "age_at_maturity_min_y"  
## [25] "age_at_maturity_max_y"   "body_size_mm"           
## [27] "size_at_maturity_min_mm" "size_at_maturity_max_mm"
## [29] "longevity_max_y"         "litter_size_min_n"      
## [31] "litter_size_max_n"       "reproductive_output_y"  
## [33] "offspring_size_min_mm"   "offspring_size_max_mm"  
## [35] "dir"                     "lar"                    
## [37] "viv"                     "obs"
```

```r
amphibio%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 38 x 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 obs        6776    100  
##  2 fruits     6774    100. 
##  3 flowers    6772     99.9
##  4 seeds      6772     99.9
##  5 leaves     6752     99.6
##  6 dry_cold   6735     99.4
##  7 vert       6657     98.2
##  8 wet_cold   6625     97.8
##  9 crepu      6608     97.5
## 10 dry_warm   6572     97.0
## # ... with 28 more rows
```

**4. How many total NA's are in each data set? Do these values make sense? Are NA's represented by values?**   


```r
amphibio%>%
  summarise(number_nas=sum(is.na(amphibio)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     170691
```


```r
amniota%>%
  summarise(number_nas=sum(is.na(amniota)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1          0
```

**5. Make any necessary replacements in the data such that all NA's appear as "NA".**   

```r
amniota_tidy<-amniota%>%
  na_if("-999")%>%
  na_if("-30258.711")
```


```r
head(amniota_tidy)
```

```
## # A tibble: 6 x 36
##   class order family genus species subspecies common_name female_maturity~
##   <chr> <chr> <chr>  <chr> <chr>        <dbl> <chr>                  <dbl>
## 1 Aves  Acci~ Accip~ Acci~ albogu~         NA Pied Gosha~              NA 
## 2 Aves  Acci~ Accip~ Acci~ badius          NA Shikra                  363.
## 3 Aves  Acci~ Accip~ Acci~ bicolor         NA Bicolored ~              NA 
## 4 Aves  Acci~ Accip~ Acci~ brachy~         NA New Britai~              NA 
## 5 Aves  Acci~ Accip~ Acci~ brevip~         NA Levant Spa~             363.
## 6 Aves  Acci~ Accip~ Acci~ castan~         NA Chestnut-f~              NA 
## # ... with 28 more variables: litter_or_clutch_size_n <dbl>,
## #   litters_or_clutches_per_y <dbl>, adult_body_mass_g <dbl>,
## #   maximum_longevity_y <dbl>, gestation_d <dbl>, weaning_d <dbl>,
## #   birth_or_hatching_weight_g <dbl>, weaning_weight_g <dbl>, egg_mass_g <dbl>,
## #   incubation_d <dbl>, fledging_age_d <dbl>, longevity_y <dbl>,
## #   male_maturity_d <dbl>, inter_litter_or_interbirth_interval_y <dbl>,
## #   female_body_mass_g <dbl>, male_body_mass_g <dbl>, no_sex_body_mass_g <dbl>,
## #   egg_width_mm <dbl>, egg_length_mm <dbl>, fledging_mass_g <dbl>,
## #   adult_svl_cm <dbl>, male_svl_cm <dbl>, female_svl_cm <dbl>,
## #   birth_or_hatching_svl_cm <dbl>, female_svl_at_maturity_cm <dbl>,
## #   female_body_mass_at_maturity_g <dbl>, no_sex_svl_cm <dbl>,
## #   no_sex_maturity_d <dbl>
```

```r
summary(amniota_tidy)
```

```
##     class              order              family             genus          
##  Length:21322       Length:21322       Length:21322       Length:21322      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##    species            subspecies    common_name        female_maturity_d
##  Length:21322       Min.   : NA     Length:21322       Min.   :  23.81  
##  Class :character   1st Qu.: NA     Class :character   1st Qu.: 289.00  
##  Mode  :character   Median : NA     Mode  :character   Median : 365.12  
##                     Mean   :NaN                        Mean   : 726.85  
##                     3rd Qu.: NA                        3rd Qu.: 819.34  
##                     Max.   : NA                        Max.   :9131.25  
##                     NA's   :21322                      NA's   :17853    
##  litter_or_clutch_size_n litters_or_clutches_per_y adult_body_mass_g  
##  Min.   :  0.900         Min.   : 0.120            Min.   :        0  
##  1st Qu.:  2.000         1st Qu.: 1.000            1st Qu.:       15  
##  Median :  2.800         Median : 1.050            Median :       44  
##  Mean   :  3.826         Mean   : 1.752            Mean   :    37493  
##  3rd Qu.:  4.150         3rd Qu.: 2.000            3rd Qu.:      238  
##  Max.   :156.000         Max.   :52.000            Max.   :149000000  
##  NA's   :8244            NA's   :16374             NA's   :4645       
##  maximum_longevity_y  gestation_d        weaning_d      
##  Min.   :  0.083     Min.   :   5.00   Min.   :   1.94  
##  1st Qu.:  6.000     1st Qu.:  29.91   1st Qu.:  27.75  
##  Median : 12.308     Median :  63.92   Median :  51.60  
##  Mean   : 16.466     Mean   : 105.28   Mean   : 113.05  
##  3rd Qu.: 22.000     3rd Qu.: 151.88   3rd Qu.: 129.83  
##  Max.   :211.000     Max.   :7396.92   Max.   :1826.25  
##  NA's   :15822       NA's   :18926     NA's   :19279    
##  birth_or_hatching_weight_g weaning_weight_g     egg_mass_g      
##  Min.   :0.00e+00           Min.   :       1   Min.   :   0.218  
##  1st Qu.:1.30e+00           1st Qu.:      13   1st Qu.:   2.100  
##  Median :5.90e+00           Median :      43   Median :   5.100  
##  Mean   :4.48e+03           Mean   :   41386   Mean   :  22.252  
##  3rd Qu.:4.39e+01           3rd Qu.:     850   3rd Qu.:  20.100  
##  Max.   :2.25e+06           Max.   :17000000   Max.   :1500.000  
##  NA's   :17779              NA's   :20258      NA's   :15907     
##   incubation_d     fledging_age_d   longevity_y      male_maturity_d  
##  Min.   :   2.00   Min.   :  1.0   Min.   :  0.083   Min.   :  30.44  
##  1st Qu.:  17.00   1st Qu.: 16.5   1st Qu.:  5.500   1st Qu.: 365.00  
##  Median :  29.25   Median : 27.5   Median : 10.700   Median : 365.25  
##  Mean   :  46.67   Mean   : 36.8   Mean   : 13.521   Mean   : 787.16  
##  3rd Qu.:  59.50   3rd Qu.: 46.0   3rd Qu.: 18.200   3rd Qu.: 913.00  
##  Max.   :1762.00   Max.   :345.0   Max.   :177.000   Max.   :9131.25  
##  NA's   :17682     NA's   :19478   NA's   :15822     NA's   :19278    
##  inter_litter_or_interbirth_interval_y female_body_mass_g male_body_mass_g 
##  Min.   :0.047                         Min.   :      0    Min.   :      0  
##  1st Qu.:0.318                         1st Qu.:     14    1st Qu.:     16  
##  Median :0.999                         Median :     41    Median :     48  
##  Mean   :0.907                         Mean   :   2076    Mean   :   6197  
##  3rd Qu.:1.000                         3rd Qu.:    220    3rd Qu.:    246  
##  Max.   :4.847                         Max.   :3700000    Max.   :4545000  
##  NA's   :19904                         NA's   :14113      NA's   :14679    
##  no_sex_body_mass_g   egg_width_mm    egg_length_mm    fledging_mass_g  
##  Min.   :        0   Min.   :  2.50   Min.   :  2.50   Min.   :   4.85  
##  1st Qu.:       13   1st Qu.:  8.00   1st Qu.: 10.94   1st Qu.:  14.60  
##  Median :       35   Median : 13.00   Median : 19.98   Median :  24.80  
##  Mean   :    68952   Mean   : 22.99   Mean   : 36.40   Mean   : 452.27  
##  3rd Qu.:      164   3rd Qu.: 35.90   3rd Qu.: 58.92   3rd Qu.: 107.00  
##  Max.   :136000000   Max.   :125.00   Max.   :455.00   Max.   :9992.00  
##  NA's   :11663       NA's   :20727    NA's   :20702    NA's   :21111    
##   adult_svl_cm      male_svl_cm     female_svl_cm      birth_or_hatching_svl_cm
##  Min.   :   1.79   Min.   :  1.57   Min.   :   1.800   Min.   :  0.400         
##  1st Qu.:   9.50   1st Qu.: 21.41   1st Qu.:   5.756   1st Qu.:  2.450         
##  Median :  18.50   Median : 35.85   Median :   8.150   Median :  3.300         
##  Mean   :  38.20   Mean   : 50.44   Mean   :  20.609   Mean   : 12.099         
##  3rd Qu.:  40.50   3rd Qu.: 63.39   3rd Qu.:  17.721   3rd Qu.:  5.256         
##  Max.   :3049.00   Max.   :315.20   Max.   :1125.000   Max.   :759.999         
##  NA's   :14274     NA's   :21040    NA's   :20242      NA's   :20085           
##  female_svl_at_maturity_cm female_body_mass_at_maturity_g no_sex_svl_cm   
##  Min.   :  2.85            Min.   :    30.0               Min.   :   1.7  
##  1st Qu.:  4.90            1st Qu.:    82.5               1st Qu.:   5.7  
##  Median :  6.00            Median : 97050.0               Median :   7.7  
##  Mean   : 18.69            Mean   : 97032.5               Mean   :  20.0  
##  3rd Qu.:  8.40            3rd Qu.:194000.0               3rd Qu.:  11.0  
##  Max.   :580.00            Max.   :194000.0               Max.   :3300.0  
##  NA's   :21120             NA's   :21318                  NA's   :16052   
##  no_sex_maturity_d
##  Min.   :   33.0  
##  1st Qu.:  365.3  
##  Median :  913.1  
##  Mean   : 1604.5  
##  3rd Qu.: 2008.9  
##  Max.   :14610.0  
##  NA's   :20860
```

**6. Use the package `naniar` to produce a summary, including percentages, of missing data in each column for the `amniota` data.**  

```r
amniota_tidy%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 36 x 3
##    variable                       n_miss pct_miss
##    <chr>                           <int>    <dbl>
##  1 subspecies                      21322    100  
##  2 female_body_mass_at_maturity_g  21318    100. 
##  3 female_svl_at_maturity_cm       21120     99.1
##  4 fledging_mass_g                 21111     99.0
##  5 male_svl_cm                     21040     98.7
##  6 no_sex_maturity_d               20860     97.8
##  7 egg_width_mm                    20727     97.2
##  8 egg_length_mm                   20702     97.1
##  9 weaning_weight_g                20258     95.0
## 10 female_svl_cm                   20242     94.9
## # ... with 26 more rows
```

**7. Use the package `naniar` to produce a summary, including percentages, of missing data in each column for the `amphibio` data.**

```r
amphibio%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 38 x 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 obs        6776    100  
##  2 fruits     6774    100. 
##  3 flowers    6772     99.9
##  4 seeds      6772     99.9
##  5 leaves     6752     99.6
##  6 dry_cold   6735     99.4
##  7 vert       6657     98.2
##  8 wet_cold   6625     97.8
##  9 crepu      6608     97.5
## 10 dry_warm   6572     97.0
## # ... with 28 more rows
```

**8. For the `amniota` data, calculate the number of NAs in the `egg_mass_g` column sorted by taxonomic class; i.e. how many NA's are present in the `egg_mass_g` column in birds, mammals, and reptiles? Does this results make sense biologically? How do these results affect your interpretation of NA's?**  


```r
amniota_tidy%>%
  group_by(class)%>%
  select(class,egg_mass_g)%>%
  naniar::miss_var_summary()%>%
  arrange(pct_miss)
```

```
## # A tibble: 3 x 4
## # Groups:   class [3]
##   class    variable   n_miss pct_miss
##   <chr>    <chr>       <int>    <dbl>
## 1 Aves     egg_mass_g   4914     50.1
## 2 Reptilia egg_mass_g   6040     92.0
## 3 Mammalia egg_mass_g   4953    100
```

#makes sense that mammals do not have egg masses, although I guess the data set did not include platypus, or did it?...

```r
names(amniota_tidy)
```

```
##  [1] "class"                                
##  [2] "order"                                
##  [3] "family"                               
##  [4] "genus"                                
##  [5] "species"                              
##  [6] "subspecies"                           
##  [7] "common_name"                          
##  [8] "female_maturity_d"                    
##  [9] "litter_or_clutch_size_n"              
## [10] "litters_or_clutches_per_y"            
## [11] "adult_body_mass_g"                    
## [12] "maximum_longevity_y"                  
## [13] "gestation_d"                          
## [14] "weaning_d"                            
## [15] "birth_or_hatching_weight_g"           
## [16] "weaning_weight_g"                     
## [17] "egg_mass_g"                           
## [18] "incubation_d"                         
## [19] "fledging_age_d"                       
## [20] "longevity_y"                          
## [21] "male_maturity_d"                      
## [22] "inter_litter_or_interbirth_interval_y"
## [23] "female_body_mass_g"                   
## [24] "male_body_mass_g"                     
## [25] "no_sex_body_mass_g"                   
## [26] "egg_width_mm"                         
## [27] "egg_length_mm"                        
## [28] "fledging_mass_g"                      
## [29] "adult_svl_cm"                         
## [30] "male_svl_cm"                          
## [31] "female_svl_cm"                        
## [32] "birth_or_hatching_svl_cm"             
## [33] "female_svl_at_maturity_cm"            
## [34] "female_body_mass_at_maturity_g"       
## [35] "no_sex_svl_cm"                        
## [36] "no_sex_maturity_d"
```

```r
amniota_tidy%>%
  filter(species=="anatinus")
```

```
## # A tibble: 1 x 36
##   class order family genus species subspecies common_name female_maturity~
##   <chr> <chr> <chr>  <chr> <chr>        <dbl> <chr>                  <dbl>
## 1 Mamm~ Mono~ Ornit~ Orni~ anatin~         NA Platypus                645.
## # ... with 28 more variables: litter_or_clutch_size_n <dbl>,
## #   litters_or_clutches_per_y <dbl>, adult_body_mass_g <dbl>,
## #   maximum_longevity_y <dbl>, gestation_d <dbl>, weaning_d <dbl>,
## #   birth_or_hatching_weight_g <dbl>, weaning_weight_g <dbl>, egg_mass_g <dbl>,
## #   incubation_d <dbl>, fledging_age_d <dbl>, longevity_y <dbl>,
## #   male_maturity_d <dbl>, inter_litter_or_interbirth_interval_y <dbl>,
## #   female_body_mass_g <dbl>, male_body_mass_g <dbl>, no_sex_body_mass_g <dbl>,
## #   egg_width_mm <dbl>, egg_length_mm <dbl>, fledging_mass_g <dbl>,
## #   adult_svl_cm <dbl>, male_svl_cm <dbl>, female_svl_cm <dbl>,
## #   birth_or_hatching_svl_cm <dbl>, female_svl_at_maturity_cm <dbl>,
## #   female_body_mass_at_maturity_g <dbl>, no_sex_svl_cm <dbl>,
## #   no_sex_maturity_d <dbl>
```
#huh, guess they do not weigh the eggs of platypus

**9. The `amphibio` data have variables that classify species as fossorial (burrowing), terrestrial, aquatic, or arboreal.Calculate the number of NA's in each of these variables. Do you think that the authors intend us to think that there are NA's in these columns or could they represent something else? Explain.**

```r
amphibio%>%
  select("fos","ter","aqu","arb")%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 4 x 3
##   variable n_miss pct_miss
##   <chr>     <int>    <dbl>
## 1 fos        6053     89.3
## 2 arb        4347     64.2
## 3 aqu        2810     41.5
## 4 ter        1104     16.3
```
#in this case I think since a species is either terrestrial, aquatic, arboreal, or burrowing (and not combinations of said life styles), that NA's here do not mean a lack of data but rather that the species represented by the row does no follow that lifestyle. If you add up the percentages of the data that isnt NA in these four columns you get 100 percent, further supporting how each entry follows one of these life styles and not the other and that NA are used here to fill in for where it is known a species does match the criteria of that column (i.e. it is known that that species is not terrestrial, arboreal, aquatic, and/or fossorial)

**10. Now that we know how NA's are represented in the `amniota` data, how would you load the data such that the values which represent NA's are automatically converted?**

```r
amniota_advance<-readr::read_csv(file="data/amniota.csv",na=c("-999","-30258.711"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   subspecies = col_logical(),
##   common_name = col_character(),
##   gestation_d = col_logical(),
##   weaning_d = col_logical(),
##   weaning_weight_g = col_logical(),
##   male_svl_cm = col_logical(),
##   female_svl_cm = col_logical(),
##   birth_or_hatching_svl_cm = col_logical(),
##   female_svl_at_maturity_cm = col_logical(),
##   female_body_mass_at_maturity_g = col_logical(),
##   no_sex_svl_cm = col_logical()
## )
## i Use `spec()` for the full column specifications.
```

```
## Warning: 13577 parsing failures.
##  row                      col           expected actual               file
## 9803 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9804 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9805 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9806 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9807 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## .... ........................ .................. ...... ..................
## See problems(...) for more details.
```

```r
amniota_advance%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 36 x 3
##    variable                       n_miss pct_miss
##    <chr>                           <int>    <dbl>
##  1 subspecies                      21322     100 
##  2 gestation_d                     21322     100 
##  3 weaning_d                       21322     100 
##  4 weaning_weight_g                21322     100 
##  5 male_svl_cm                     21322     100 
##  6 female_svl_cm                   21322     100 
##  7 female_svl_at_maturity_cm       21322     100 
##  8 female_body_mass_at_maturity_g  21322     100 
##  9 no_sex_svl_cm                   21322     100 
## 10 birth_or_hatching_svl_cm        21321     100.
## # ... with 26 more rows
```

```r
amniota_tidy%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 36 x 3
##    variable                       n_miss pct_miss
##    <chr>                           <int>    <dbl>
##  1 subspecies                      21322    100  
##  2 female_body_mass_at_maturity_g  21318    100. 
##  3 female_svl_at_maturity_cm       21120     99.1
##  4 fledging_mass_g                 21111     99.0
##  5 male_svl_cm                     21040     98.7
##  6 no_sex_maturity_d               20860     97.8
##  7 egg_width_mm                    20727     97.2
##  8 egg_length_mm                   20702     97.1
##  9 weaning_weight_g                20258     95.0
## 10 female_svl_cm                   20242     94.9
## # ... with 26 more rows
```
#strange, why are percentages ansd numbers different between the two

```r
amniota%>%
  select(female_maturity_d)%>%
  arrange(female_maturity_d)
```

```
## # A tibble: 21,322 x 1
##    female_maturity_d
##                <dbl>
##  1           -30259.
##  2           -30259.
##  3           -30259.
##  4           -30259.
##  5             -999 
##  6             -999 
##  7             -999 
##  8             -999 
##  9             -999 
## 10             -999 
## # ... with 21,312 more rows
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
