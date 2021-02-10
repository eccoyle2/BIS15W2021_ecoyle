---
title: "Lab 10 Homework"
author: "Eric Coyle"
date: "2021-02-10"
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
library(naniar)
```

## Desert Ecology
For this assignment, we are going to use a modified data set on [desert ecology](http://esapubs.org/archive/ecol/E090/118/). The data are from: S. K. Morgan Ernest, Thomas J. Valone, and James H. Brown. 2009. Long-term monitoring and experimental manipulation of a Chihuahuan Desert ecosystem near Portal, Arizona, USA. Ecology 90:1708.

```r
deserts <- read_csv(here("lab10", "data", "surveys_complete.csv"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   record_id = col_double(),
##   month = col_double(),
##   day = col_double(),
##   year = col_double(),
##   plot_id = col_double(),
##   species_id = col_character(),
##   sex = col_character(),
##   hindfoot_length = col_double(),
##   weight = col_double(),
##   genus = col_character(),
##   species = col_character(),
##   taxa = col_character(),
##   plot_type = col_character()
## )
```

1. Use the function(s) of your choice to get an idea of its structure, including how NA's are treated. Are the data tidy?  

```r
glimpse(deserts)
```

```
## Rows: 34,786
## Columns: 13
## $ record_id       <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, ...
## $ month           <dbl> 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, ...
## $ day             <dbl> 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,...
## $ year            <dbl> 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1977, 197...
## $ plot_id         <dbl> 2, 3, 2, 7, 3, 1, 2, 1, 1, 6, 5, 7, 3, 8, 6, 4, 3, ...
## $ species_id      <chr> "NL", "NL", "DM", "DM", "DM", "PF", "PE", "DM", "DM...
## $ sex             <chr> "M", "M", "F", "M", "M", "M", "F", "M", "F", "F", "...
## $ hindfoot_length <dbl> 32, 33, 37, 36, 35, 14, NA, 37, 34, 20, 53, 38, 35,...
## $ weight          <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
## $ genus           <chr> "Neotoma", "Neotoma", "Dipodomys", "Dipodomys", "Di...
## $ species         <chr> "albigula", "albigula", "merriami", "merriami", "me...
## $ taxa            <chr> "Rodent", "Rodent", "Rodent", "Rodent", "Rodent", "...
## $ plot_type       <chr> "Control", "Long-term Krat Exclosure", "Control", "...
```

```r
deserts%>%
  naniar::miss_var_summary()
```

```
## # A tibble: 13 x 3
##    variable        n_miss pct_miss
##    <chr>            <int>    <dbl>
##  1 hindfoot_length   3348     9.62
##  2 weight            2503     7.20
##  3 sex               1748     5.03
##  4 record_id            0     0   
##  5 month                0     0   
##  6 day                  0     0   
##  7 year                 0     0   
##  8 plot_id              0     0   
##  9 species_id           0     0   
## 10 genus                0     0   
## 11 species              0     0   
## 12 taxa                 0     0   
## 13 plot_type            0     0
```

```r
head(deserts)
```

```
## # A tibble: 6 x 13
##   record_id month   day  year plot_id species_id sex   hindfoot_length weight
##       <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>      <chr>           <dbl>  <dbl>
## 1         1     7    16  1977       2 NL         M                  32     NA
## 2         2     7    16  1977       3 NL         M                  33     NA
## 3         3     7    16  1977       2 DM         F                  37     NA
## 4         4     7    16  1977       7 DM         M                  36     NA
## 5         5     7    16  1977       3 DM         M                  35     NA
## 6         6     7    16  1977       1 PF         M                  14     NA
## # ... with 4 more variables: genus <chr>, species <chr>, taxa <chr>,
## #   plot_type <chr>
```

2. How many genera and species are represented in the data? What are the total number of observations? Which species is most/ least frequently sampled in the study?

```r
deserts%>%
  summarise(genus_count=n_distinct(genus),
            species_count=n_distinct(species),
            observation_count=n())
```

```
## # A tibble: 1 x 3
##   genus_count species_count observation_count
##         <int>         <int>             <int>
## 1          26            40             34786
```

```r
deserts%>%
  tabyl(species)%>%
  arrange(desc(n))
```

```
##          species     n      percent
##         merriami 10596 3.046053e-01
##     penicillatus  3123 8.977750e-02
##            ordii  3027 8.701777e-02
##          baileyi  2891 8.310815e-02
##        megalotis  2609 7.500144e-02
##      spectabilis  2504 7.198298e-02
##         torridus  2249 6.465245e-02
##           flavus  1597 4.590927e-02
##         eremicus  1299 3.734261e-02
##         albigula  1252 3.599149e-02
##      leucogaster  1006 2.891968e-02
##      maniculatus   899 2.584373e-02
##          harrisi   437 1.256253e-02
##        bilineata   303 8.710401e-03
##        spilosoma   248 7.129305e-03
##         hispidus   179 5.145748e-03
##              sp.    86 2.472259e-03
##        audubonii    75 2.156040e-03
##       fulvescens    75 2.156040e-03
##  brunneicapillus    50 1.437360e-03
##          taylori    46 1.322371e-03
##      fulviventer    43 1.236129e-03
##     ochrognathus    43 1.236129e-03
##        chlorurus    39 1.121141e-03
##         leucopus    36 1.034899e-03
##         squamata    16 4.599552e-04
##      melanocorys    13 3.737136e-04
##      intermedius     9 2.587248e-04
##        gramineus     8 2.299776e-04
##         montanus     8 2.299776e-04
##           fuscus     5 1.437360e-04
##        undulatus     5 1.437360e-04
##       leucophrys     2 5.749439e-05
##       savannarum     2 5.749439e-05
##           clarki     1 2.874720e-05
##       scutalatus     1 2.874720e-05
##     tereticaudus     1 2.874720e-05
##           tigris     1 2.874720e-05
##        uniparens     1 2.874720e-05
##          viridis     1 2.874720e-05
```

```r
deserts%>%
  ggplot(aes(x=species))+
  geom_bar()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Species Counts",x="Species")
```

![](lab10_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

3. What is the proportion of taxa included in this study? Show a table and plot that reflects this count.

```r
deserts%>%
  tabyl(taxa)
```

```
##     taxa     n      percent
##     Bird   450 0.0129362387
##   Rabbit    75 0.0021560398
##  Reptile    14 0.0004024608
##   Rodent 34247 0.9845052607
```

```r
deserts%>%
  ggplot(aes(x=taxa,fill=taxa))+
  geom_bar()+
  scale_y_log10()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Taxa Present",x="Taxa")
```

![](lab10_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

4. For the taxa included in the study, use the fill option to show the proportion of individuals sampled by `plot_type.`

```r
deserts%>%
  ggplot(aes(x=taxa,fill=plot_type))+
  geom_bar()+
  scale_y_log10()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Taxa Present",x="Taxa")
```

![](lab10_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

5. What is the range of weight for each species included in the study? Remove any observations of weight that are NA so they do not show up in the plot.

```r
deserts%>%
  ggplot(aes(x=species,y=weight))+
  geom_boxplot(na.rm = T)+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Weight of Different Species",x="Species",y="Weight")
```

![](lab10_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

6. Add another layer to your answer from #4 using `geom_point` to get an idea of how many measurements were taken for each species.

```r
deserts%>%
  group_by(species)%>%
  filter(weight!="NA")%>%
  count(n_distinct(record_id))
```

```
## # A tibble: 22 x 3
## # Groups:   species [22]
##    species     `n_distinct(record_id)`     n
##    <chr>                         <int> <int>
##  1 albigula                      32283  1152
##  2 baileyi                       32283  2810
##  3 eremicus                      32283  1260
##  4 flavus                        32283  1548
##  5 fulvescens                    32283    75
##  6 fulviventer                   32283    41
##  7 hispidus                      32283   172
##  8 intermedius                   32283     8
##  9 leucogaster                   32283   970
## 10 leucopus                      32283    36
## # ... with 12 more rows
```


```r
deserts%>%
group_by(species)%>%
filter(weight!="NA")%>%
count(species)%>%
ggplot(aes(x=species,y=n))+
geom_point(size=3)+
theme(axis.text.x = element_text(angle = 60, hjust = 1))+
labs(title = "Weight Measurements per Species",x="Species",y="Number of Weight Measurements")
```

![](lab10_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

7. [Dipodomys merriami](https://en.wikipedia.org/wiki/Merriam's_kangaroo_rat) is the most frequently sampled animal in the study. How have the number of observations of this species changed over the years included in the study?

```r
deserts%>%
  filter(species=="merriami")%>%
  tabyl(year)
```

```
##  year   n    percent
##  1977 264 0.02491506
##  1978 389 0.03671197
##  1979 209 0.01972442
##  1980 493 0.04652699
##  1981 559 0.05275576
##  1982 609 0.05747452
##  1983 528 0.04983012
##  1984 396 0.03737259
##  1985 667 0.06294828
##  1986 406 0.03831635
##  1987 469 0.04426199
##  1988 365 0.03444696
##  1989 321 0.03029445
##  1990 462 0.04360136
##  1991 404 0.03812760
##  1992 307 0.02897320
##  1993 253 0.02387693
##  1994 293 0.02765194
##  1995 436 0.04114760
##  1996 492 0.04643262
##  1997 576 0.05436014
##  1998 503 0.04747074
##  1999 348 0.03284258
##  2000 233 0.02198943
##  2001 305 0.02878445
##  2002 309 0.02916195
```

```r
deserts%>%
  filter(species=="merriami")%>%
  ggplot(aes(x=year))+
    geom_bar()+
    theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Dipodomys merriami Observed Over Time",x="Year",y="Number of Observations")
```

![](lab10_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

8. What is the relationship between `weight` and `hindfoot` length? Consider whether or not over plotting is an issue.

```r
deserts%>%
  ggplot(aes(x=weight,y=hindfoot_length))+
  geom_point(na.rm=T)
```

![](lab10_hw_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

```r
deserts%>%
  ggplot(aes(x=weight,y=hindfoot_length))+
  geom_jitter(na.rm = T,size=.9)+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Relationship between Weight and Hindfoot Length",x="Weight",y="Hind foot Length")
```

![](lab10_hw_files/figure-html/unnamed-chunk-18-1.png)<!-- -->
#overplotting is definitely an issue in my opinion

9. Which two species have, on average, the highest weight? Once you have identified them, make a new column that is a ratio of `weight` to `hindfoot_length`. Make a plot that shows the range of this new ratio and fill by sex.

```r
deserts%>%
  group_by(species)%>%
  summarise(mean_weight=mean(weight,na.rm=T))%>%
  arrange(desc(mean_weight))
```

```
## # A tibble: 40 x 2
##    species      mean_weight
##    <chr>              <dbl>
##  1 albigula           159. 
##  2 spectabilis        120. 
##  3 spilosoma           93.5
##  4 hispidus            65.6
##  5 fulviventer         58.9
##  6 ochrognathus        55.4
##  7 ordii               48.9
##  8 merriami            43.2
##  9 baileyi             31.7
## 10 leucogaster         31.6
## # ... with 30 more rows
```

```r
deserts2<-deserts%>%
  mutate(Weight_hindfoot_ratio=(weight/hindfoot_length))
deserts2
```

```
## # A tibble: 34,786 x 14
##    record_id month   day  year plot_id species_id sex   hindfoot_length weight
##        <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>      <chr>           <dbl>  <dbl>
##  1         1     7    16  1977       2 NL         M                  32     NA
##  2         2     7    16  1977       3 NL         M                  33     NA
##  3         3     7    16  1977       2 DM         F                  37     NA
##  4         4     7    16  1977       7 DM         M                  36     NA
##  5         5     7    16  1977       3 DM         M                  35     NA
##  6         6     7    16  1977       1 PF         M                  14     NA
##  7         7     7    16  1977       2 PE         F                  NA     NA
##  8         8     7    16  1977       1 DM         M                  37     NA
##  9         9     7    16  1977       1 DM         F                  34     NA
## 10        10     7    16  1977       6 PF         F                  20     NA
## # ... with 34,776 more rows, and 5 more variables: genus <chr>, species <chr>,
## #   taxa <chr>, plot_type <chr>, Weight_hindfoot_ratio <dbl>
```

```r
deserts2%>%
  filter(species=="albigula"|species=="spectabilis")%>%
  ggplot(aes(x=species,y=Weight_hindfoot_ratio,fill=sex))+
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Relationship between Weight and Hindfoot Length In Heaviest Rodent Species",x="Species",y="Ratio of Weight to Hindfoot Length")
```

```
## Warning: Removed 684 rows containing non-finite values (stat_boxplot).
```

![](lab10_hw_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

```r
names(deserts)
```

```
##  [1] "record_id"       "month"           "day"             "year"           
##  [5] "plot_id"         "species_id"      "sex"             "hindfoot_length"
##  [9] "weight"          "genus"           "species"         "taxa"           
## [13] "plot_type"
```

10. Make one plot of your choice! Make sure to include at least two of the aesthetics options you have learned.

```r
deserts%>%
  group_by(plot_type,sex)%>%
  summarise(mean_hindfoot_length=mean(hindfoot_length,plot_type=plot_type,na.rm=T))%>%
  ggplot(aes(x=plot_type,y=mean_hindfoot_length,fill=sex))+
  geom_col()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Hindfoot Average Length Across Plot Types",
       x = "Plot Types",
       Y="Average Hindfoot Length",
       fill = "Sex")
```

```
## `summarise()` has grouped output by 'plot_type'. You can override using the `.groups` argument.
```

![](lab10_hw_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
