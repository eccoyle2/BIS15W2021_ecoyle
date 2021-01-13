---
title: "Importing Data Frames"
date: "2021-01-12"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
  pdf_document:
    toc: yes
---

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to HW 2 in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Learning Goals
*At the end of this exercise, you will be able to:*    
1. Import .csv files as data frames using `read_csv()`.  
2. Use summary functions to explore the dimensions, structure, and contents of a data frame.  
3. Use the `select()` command of dplyr to sort data frames.  

## Review
At this point, you should have familiarity in RStudio, GitHub, and basic operations in R. You understand how to do arithmetic, assign values to objects, and work with vectors, data matrices, and data frames. If you are confused or need some extra help, please [email me](mailto: jmledford@ucdavis.edu).  

## Load the tidyverse

```r
library("tidyverse")
```

## Data Frames
For the remainder of the course, we will work exclusively with data frames. Recall that data frames store multiple classes of data. Last time, you were shown how to build data frames using the `data.frame()` command. However, scientists often make their data available as supplementary material associated with a publication. This is excellent scientific practice as it insures repeatability by showing exactly how analyses were performed. As data scientists, we capitalize on this by importing data directly into R.  

## Importing Data
R allows us to import a wide variety of data types. The most common type of file is a .csv file which stands for comma separated values. Spreadsheets are often developed in Excel then saved as .csv files for use in R. There are packages that allow you to open excel files and many other formats directly but .csv is the most common.  

An opinionated word about excel. It is fine to use excel for data entry and basic analysis. But, it often adds formatting that makes excel files difficult to work with in any program besides excel. R can read excel files, but I know of no R programmers that routinely use them. Instead they save copies of their excel files as .csv which strips away formatting but makes them easier to use in a variety of programs. We won't work with excel files in BIS 15L, but we will learn to import them.  

To import any file, first make sure that you are in the correct working directory. If you are not in the correct directory, R will not "see" the file.

```r
getwd()
```

```
## [1] "C:/Users/ericc/Desktop/BIS15W2021_ecoyle/Lab 3 and HW 3"
```

## Load the data
Here we open a .csv file. Since we are using the tidyverse, we open the file using `read_csv()`. `readr` is included in the tidyverse set of packages. We specify the package and function with the `::` symbol. This becomes important if you have multiple packages loaded that contain functions with the same name.  

In the previous part of the lab, you exported a `.csv` of hot springs data. Let's try to reload that `.csv`.  

```r
hot_springs <- readr::read_csv("hsprings_data.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   spring = col_character(),
##   scientist = col_character(),
##   temp_C = col_double(),
##   depth_ft = col_double()
## )
```

Use the `str()` function to get an idea of the data structure of `hot_springs`.  

```r
str(hot_springs)
```

```
## tibble [9 x 4] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ spring   : chr [1:9] "Buckeye" "Buckeye" "Buckeye" "Benton" ...
##  $ scientist: chr [1:9] "Jill" "Susan" "Steve" "Jill" ...
##  $ temp_C   : num [1:9] 36.2 35.4 35.3 35.1 35.4 ...
##  $ depth_ft : num [1:9] 4.15 4.13 4.12 3.21 3.23 3.2 5.67 5.65 5.66
##  - attr(*, "spec")=
##   .. cols(
##   ..   spring = col_character(),
##   ..   scientist = col_character(),
##   ..   temp_C = col_double(),
##   ..   depth_ft = col_double()
##   .. )
```

What is the class of the scientist column? Change it to factor and then show the levels of that factor.  

```r
class(hot_springs$scientist)
```

```
## [1] "character"
```

```r
levels(hot_springs$scientist)
```

```
## NULL
```


```r
hot_springs$scientist <- as.factor(hot_springs$scientist)
class(hot_springs$scientist)
```

```
## [1] "factor"
```


```r
levels(hot_springs$scientist)
```

```
## [1] "Jill"  "Steve" "Susan"
```

## Practice
1. In your lab 3 folder there is another folder titled `data`. Inside the `data` folder there is a `.csv` titled `Gaeta_etal_CLC_data.csv`. Open this data and store them as an object called `fish`.  

The data are from: Gaeta J., G. Sass, S. Carpenter. 2012. Biocomplexity at North Temperate Lakes LTER: Coordinated Field Studies: Large Mouth Bass Growth 2006. Environmental Data Initiative.  [link](https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-ntl&identifier=267)  

```r
fish <- readr::read_csv("Gaeta_etal_CLC_data.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   lakeid = col_character(),
##   fish_id = col_double(),
##   annnumber = col_character(),
##   length = col_double(),
##   radii_length_mm = col_double(),
##   scalelength = col_double()
## )
```

2. What is the structure of these data?

```r
str(fish)
```

```
## tibble [4,033 x 6] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ lakeid         : chr [1:4033] "AL" "AL" "AL" "AL" ...
##  $ fish_id        : num [1:4033] 299 299 299 300 300 300 300 301 301 301 ...
##  $ annnumber      : chr [1:4033] "EDGE" "2" "1" "EDGE" ...
##  $ length         : num [1:4033] 167 167 167 175 175 175 175 194 194 194 ...
##  $ radii_length_mm: num [1:4033] 2.7 2.04 1.31 3.02 2.67 ...
##  $ scalelength    : num [1:4033] 2.7 2.7 2.7 3.02 3.02 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   lakeid = col_character(),
##   ..   fish_id = col_double(),
##   ..   annnumber = col_character(),
##   ..   length = col_double(),
##   ..   radii_length_mm = col_double(),
##   ..   scalelength = col_double()
##   .. )
```

Notice that when the data are imported, you are presented with a message that tells you how R interpreted the column classes. This is also where error messages will appear if there are problems.  

## Summary functions
Once data have been uploaded, you may want to get an idea of its structure, contents, and dimensions. I routinely run one or more of these commands when data are first imported.  

We can summarize our data frame with the`summary()` function.  

```r
summary(fish)
```

```
##     lakeid             fish_id       annnumber             length     
##  Length:4033        Min.   :  1.0   Length:4033        Min.   : 58.0  
##  Class :character   1st Qu.:156.0   Class :character   1st Qu.:253.0  
##  Mode  :character   Median :267.0   Mode  :character   Median :299.0  
##                     Mean   :258.3                      Mean   :293.3  
##                     3rd Qu.:376.0                      3rd Qu.:342.0  
##                     Max.   :478.0                      Max.   :420.0  
##  radii_length_mm    scalelength     
##  Min.   : 0.4569   Min.   : 0.6282  
##  1st Qu.: 2.3252   1st Qu.: 4.2596  
##  Median : 3.5380   Median : 5.4062  
##  Mean   : 3.6589   Mean   : 5.3821  
##  3rd Qu.: 4.8229   3rd Qu.: 6.4145  
##  Max.   :11.0258   Max.   :11.0258
```

`glimpse()` is another useful summary function.

```r
glimpse(fish)
```

```
## Rows: 4,033
## Columns: 6
## $ lakeid          <chr> "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL...
## $ fish_id         <dbl> 299, 299, 299, 300, 300, 300, 300, 301, 301, 301, 3...
## $ annnumber       <chr> "EDGE", "2", "1", "EDGE", "3", "2", "1", "EDGE", "3...
## $ length          <dbl> 167, 167, 167, 175, 175, 175, 175, 194, 194, 194, 1...
## $ radii_length_mm <dbl> 2.697443, 2.037518, 1.311795, 3.015477, 2.670733, 2...
## $ scalelength     <dbl> 2.697443, 2.697443, 2.697443, 3.015477, 3.015477, 3...
```

`nrow()` gives the numbers of rows.

```r
nrow(fish) #the number of rows or observations
```

```
## [1] 4033
```

`ncol` gives the number of columns.

```r
ncol(fish) #the number of columns or variables
```

```
## [1] 6
```

`dim()` gives the dimensions.

```r
dim(fish) #total dimensions
```

```
## [1] 4033    6
```

`names` gives the column names.

```r
names(fish) #column names
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```

`head()` prints the first n rows of the data frame.

```r
head(fish, n = 10)
```

```
## # A tibble: 10 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
```

`tail()` prinst the last n rows of the data frame.

```r
tail(fish, n = 10)
```

```
## # A tibble: 10 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 WS         180 10           403            8.15        11.0
##  2 WS         180 9            403            7.49        11.0
##  3 WS         180 8            403            6.97        11.0
##  4 WS         180 7            403            6.24        11.0
##  5 WS         180 6            403            5.41        11.0
##  6 WS         180 5            403            4.98        11.0
##  7 WS         180 4            403            4.22        11.0
##  8 WS         180 3            403            3.04        11.0
##  9 WS         180 2            403            2.03        11.0
## 10 WS         180 1            403            1.19        11.0
```

```r
table(fish$scalelength)
```

```
## 
## 0.628151249 0.636516731 0.773093802 0.831563121 1.149311492 1.406561924 
##           1           1           1           1           1           3 
## 1.434064437 1.495554149  1.58589275 1.610975643 1.684025383 1.731233068 
##           2           2           2           2           3           3 
##  1.77335137 1.887673426  1.88900762 1.899827933 1.956718552 1.958226546 
##           3           3           2           3           3           2 
## 1.971127435 2.005243921 2.006052316 2.011999403 2.013384084  2.01984051 
##           3           2           2           3           2           3 
## 2.036940991 2.072127063 2.096885844 2.110308547   2.1432421 2.161087313 
##           3           2           3           3           3           3 
## 2.201024872 2.211094162 2.238618125  2.24510317 2.254546655 2.258668513 
##           3           3           3           3           4           3 
## 2.278322775 2.309860144 2.351964158 2.360921068  2.39555159 2.450808082 
##           2           3           3           2           3           3 
## 2.454148547 2.455295072 2.461392027 2.462071738 2.470817189 2.523331633 
##           3           3           4           2           3           3 
## 2.545394987 2.546162818 2.551073939 2.557863377 2.574023716 2.586442929 
##           4           3           2           5           4           4 
##  2.60138755 2.605975255 2.624540327 2.646581281 2.655819322 2.658253925 
##           3           6           3           4           4           4 
## 2.658640924 2.668376587 2.674057701 2.675454011 2.682918318 2.695586004 
##           4           4           3           2           3           3 
## 2.697132505 2.697442983 2.698180739 2.702413552 2.727573612 2.757779769 
##           3           3           3           3           5           3 
## 2.758069497 2.765616949 2.780134741 2.793024149 2.796890656 2.802833315 
##           4           4           3           3           5           3 
## 2.807880684 2.817653284 2.844255477 2.850511394 2.864524181   2.8755279 
##           3           3           4           3           4           4 
## 2.890862187 2.897278902 2.923823888 2.925881796 2.937448446 2.941509482 
##           3           3           4           3           4           4 
##  2.94296592 2.964261763 2.965323293 2.972643009 2.973960923 2.974395269 
##           5           4           4           4           4           4 
## 2.980789017 2.988498138 3.005358151 3.014440224 3.015477385  3.01882278 
##           4           4           5           4           4           4 
## 3.035957571 3.058853422 3.084104568 3.129810676 3.140903465 3.162062026 
##           3           5           4           5           4           4 
## 3.163436233 3.172529467 3.179084336 3.189512843 3.192469422 3.200424236 
##           4           5           6           7           4           5 
## 3.208750193  3.22653507 3.229873576 3.243768633 3.268240729 3.275981283 
##           4           6           6           6           5           5 
## 3.283597645 3.301820589 3.306645268 3.319721359 3.328152853 3.343855565 
##           6           6           4           4           4           4 
## 3.357750602 3.364914007 3.365051381 3.368417484 3.371104238 3.439350567 
##           4           3           7           5           3           4 
## 3.442494297 3.453230371  3.45723839 3.474478178  3.47501731 3.479905384 
##           5           5           6           5           4           5 
## 3.486728492 3.491605204 3.495271967  3.50124235 3.520569093 3.540724628 
##           4           7           6           6           7           6 
## 3.550433833 3.559325928 3.604008515  3.63570923 3.642083652 3.646839453 
##           4           5           5           4           4           4 
## 3.677409381 3.678517528 3.721535481  3.73596319 3.756916705 3.772060265 
##           5           7           3           8           6           6 
## 3.786643018 3.797454519 3.798121927 3.810008922 3.849398068 3.851885672 
##           7           7           5           7           5           7 
## 3.867392796 3.890632603 3.904376035 3.906124578  3.90894603 3.920177482 
##           8           8           6           7           7          10 
## 3.922384927 3.922668534 3.926782446 3.934043174 3.953296481 3.954971736 
##          10           7           9          10           9           9 
## 3.965876038 3.975724562 3.987345042 3.995967962   3.9990749 4.015998192 
##           7           9           8           7           4           8 
## 4.042230054 4.042932656 4.047510317 4.048551544 4.084877716 4.086815007 
##           9           6           9           7           8           4 
## 4.096814475 4.115171542 4.130059786 4.133062643 4.136123786 4.136356373 
##           9           9           6           7           9           9 
## 4.141406129 4.144791175  4.14568313 4.167911991 4.171900316 4.175101463 
##           7           8           7           7          11           7 
## 4.186116575 4.187736727 4.190666885 4.193688192 4.201559154   4.2017963 
##          10           7           6           7           9           8 
## 4.219361447 4.237364988 4.256269181 4.256711011  4.25727889  4.25955586 
##           9          10           9           8          11           8 
## 4.273209587  4.27417381 4.285892212 4.296282479 4.301657069 4.313148616 
##           9           8          14          10           7           9 
##  4.31438999 4.324112882  4.33257111 4.345026368 4.358907038 4.387797047 
##          12           9          11           9           8          11 
##  4.38840628 4.391777272 4.399993711 4.407958515 4.418797197 4.421411822 
##           8          11           9          11           9           9 
## 4.430097909 4.442500286 4.459633063 4.469366349 4.493225662 4.497550637 
##          14          10          14           6          10           8 
## 4.513005851 4.519317559 4.533865744 4.542219138  4.54253204 4.555577214 
##          10          11           7           9          12           9 
## 4.563966245 4.565284682 4.579928161 4.588780217  4.59641289 4.606302464 
##           9           9           9          13           8           8 
## 4.614444747 4.626093352 4.631277555 4.632666819 4.637879649 4.643203698 
##           7          10           9          12           7           7 
## 4.664314686 4.670751905 4.673330238 4.690118624 4.725462193 4.736675762 
##           7           9          12          13           7          12 
## 4.741689019 4.755765531 4.761219411 4.761400345 4.763088291 4.794547433 
##           7           8           8          13           8           8 
## 4.814216289 4.829933532 4.831537721 4.835507435 4.836792608 4.844292234 
##          11           8           9           7          12          12 
## 4.851237218 4.857894959 4.889790377 4.894276187 4.895239229  4.90439904 
##           9           7           7          10           6          13 
## 4.920116842 4.968445024 4.969806095  4.98657318 4.998061699 5.049813135 
##          10           7          13          12          10           7 
## 5.058001817 5.074995972 5.078278001  5.08110952 5.095811876 5.108669218 
##          10           9           9           7          12          11 
## 5.120097185 5.127988541 5.130323514 5.146631631 5.158432688 5.165661162 
##           9          13           9          10          10           6 
## 5.169415014 5.182832332 5.196862611  5.20016923 5.221786955 5.223966427 
##          10          11          11          10          14          11 
## 5.232478948 5.256454863 5.261481223 5.276443129 5.287393604 5.291036048 
##           7           9           9          13           9           7 
## 5.296091436 5.312409318 5.316778788  5.31995492 5.326940899 5.344842042 
##          10           8           8          10           9          10 
##  5.35532307 5.356719133 5.389440756 5.406208458 5.414998877 5.429056953 
##           9           8           9           7          10          10 
## 5.430090833  5.43384551 5.436126326 5.452250118 5.466752013 5.467984071 
##          12           8          11          15           8          13 
## 5.477850668 5.480088293  5.49107785 5.491501253 5.512869906 5.520867454 
##          12          14           9          13           8          10 
## 5.541056085 5.553558741  5.56865141 5.576282883 5.580494878 5.582184369 
##          11          11          14          11          10          13 
## 5.592688422 5.606168722 5.610120907 5.619783059 5.623967989 5.640412056 
##          12          11          16          10          14          11 
## 5.668774619 5.674127794 5.676594978 5.676999591 5.699643996 5.705491208 
##          10          10          11          11           8          13 
## 5.709048239 5.718807038 5.723596694 5.727239616 5.735551545 5.736142568 
##           7          11          11          12          10          11 
##  5.75912762 5.781149809 5.794595776 5.795387216 5.815159175 5.819691415 
##           7          10           9          15          10          11 
## 5.860261506 5.882788817 5.903222649 5.956542181 5.958780446  5.97285272 
##          14          10           9          13          11          11 
## 5.975534747  5.98002466 5.989046073   5.9977522 6.001830192 6.027043495 
##           9          10          10          14          11          12 
## 6.029992096 6.033123759  6.05230424 6.052987354 6.053672487 6.055954929 
##          12          11          15          10           9          12 
## 6.056170574 6.066157832 6.101336399 6.109809847  6.11391024 6.150263506 
##          12          10          13           9          10          15 
## 6.177317736 6.182458053 6.193214613 6.214131227 6.258504616 6.274249391 
##          11          13          12          15          12          11 
## 6.277193825 6.279830177 6.284072427 6.285793896 6.298104025 6.311789763 
##          11          14          17          12          14          13 
## 6.338165653 6.345184215 6.353846415  6.37294771 6.375861974 6.395392862 
##          11          12          14           9          11          13 
## 6.403095616 6.414541536 6.424188172 6.441943988 6.465514826 6.474934741 
##          14          11          10          13          14          14 
## 6.524849942 6.549720354 6.605461857 6.616776406 6.634477351 6.659110662 
##          17          13          13          12          15          10 
##  6.66580044 6.670866019 6.695904636 6.697042667 6.706873628 6.709544241 
##          12          13          13          14          12          15 
## 6.741251528 6.788956478 6.794421517 6.798118585 6.812158315 6.852408279 
##          13          11          13          14          14          15 
## 6.863162417 6.874686829 6.880847646 6.904229819 6.909389807 6.909813076 
##          14          12          14          14          12          14 
## 6.934103537 6.942168824 6.999547958 7.063296575 7.084481305 7.137441764 
##           9          11          13          15          15          13 
## 7.156012566 7.218420496 7.231674547 7.267399256 7.270902516 7.278518094 
##          13          14          13          14          14          17 
##  7.36282701 7.394288576 7.470900442 7.489310127 7.522447115 7.536659376 
##          15          14          13          12          14          11 
## 7.552002907 7.737192412 7.744726142 7.761399759  7.76898125 7.796736519 
##          14          15          13          14          12          16 
## 7.815564319 7.827613738  7.87621539 7.891747112 7.935605585 7.946451439 
##          11          11          14          14          15          14 
## 7.953012463   7.9665111 7.968914967  8.00243928 8.120045895 8.176395307 
##          14          14          15          15          14          14 
## 8.205798437  8.24928523 8.293392185 8.330674295 8.482999096  8.71283287 
##          15          14          10          16          15          17 
## 8.718544754 9.503263671  9.64031823 11.02582836 
##          13          15          15          17
```

`table()` is useful when you have a limited number of categorical variables. It produces fast counts of the number of observations in a variable. We will come back to this later... 

```r
table(fish$lakeid)
```

```
## 
##  AL  AR  BO  BR  CR  DY  FD  JN  LC  LJ  LR LSG  MN  RD  UB  WS 
## 383 262 197 291 343 355 302 238 173 181 292 143 293 135 191 254
```

We can also click on the `fish` data frame in the Environment tab or type View(fish).

```r
View(fish)
```

```r
names(fish)
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```

## Subset
Subset is a way of pulling out observations that meet specific criteria in a variable.  

```r
little_fish <- subset(fish, length<=100)
little_fish
```

```
## # A tibble: 5 x 6
##   lakeid fish_id annnumber length radii_length_mm scalelength
##   <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
## 1 LSG         58 EDGE          92           1.15        1.15 
## 2 LSG         59 EDGE          64           0.773       0.773
## 3 WS         151 EDGE          58           0.628       0.628
## 4 WS         152 EDGE          74           0.832       0.832
## 5 WS         153 EDGE          78           0.637       0.637
```

## Practice
1. Load the data `mammal_lifehistories_v2.csv` and place it into a new object called `mammals`.

```r
mammals<-readr::read_csv("data/mammal_lifehistories_v2.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   order = col_character(),
##   family = col_character(),
##   Genus = col_character(),
##   species = col_character(),
##   mass = col_double(),
##   gestation = col_double(),
##   newborn = col_double(),
##   weaning = col_double(),
##   `wean mass` = col_double(),
##   AFR = col_double(),
##   `max. life` = col_double(),
##   `litter size` = col_double(),
##   `litters/year` = col_double()
## )
```

2. Provide the dimensions of the data frame.

```r
dim(mammals)
```

```
## [1] 1440   13
```

3. Check the column names in the data frame. 

```r
names(mammals)
```

```
##  [1] "order"        "family"       "Genus"        "species"      "mass"        
##  [6] "gestation"    "newborn"      "weaning"      "wean mass"    "AFR"         
## [11] "max. life"    "litter size"  "litters/year"
```

4. Use `str()` to show the structure of the data frame and its individual columns; compare this to `glimpse()`. 

```r
str(mammals)
```

```
## tibble [1,440 x 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ order       : chr [1:1440] "Artiodactyla" "Artiodactyla" "Artiodactyla" "Artiodactyla" ...
##  $ family      : chr [1:1440] "Antilocapridae" "Bovidae" "Bovidae" "Bovidae" ...
##  $ Genus       : chr [1:1440] "Antilocapra" "Addax" "Aepyceros" "Alcelaphus" ...
##  $ species     : chr [1:1440] "americana" "nasomaculatus" "melampus" "buselaphus" ...
##  $ mass        : num [1:1440] 45375 182375 41480 150000 28500 ...
##  $ gestation   : num [1:1440] 8.13 9.39 6.35 7.9 6.8 5.08 5.72 5.5 8.93 9.14 ...
##  $ newborn     : num [1:1440] 3246 5480 5093 10167 -999 ...
##  $ weaning     : num [1:1440] 3 6.5 5.63 6.5 -999 ...
##  $ wean mass   : num [1:1440] 8900 -999 15900 -999 -999 ...
##  $ AFR         : num [1:1440] 13.5 27.3 16.7 23 -999 ...
##  $ max. life   : num [1:1440] 142 308 213 240 -999 251 228 255 300 324 ...
##  $ litter size : num [1:1440] 1.85 1 1 1 1 1.37 1 1 1 1 ...
##  $ litters/year: num [1:1440] 1 0.99 0.95 -999 -999 2 -999 1.89 1 1 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   order = col_character(),
##   ..   family = col_character(),
##   ..   Genus = col_character(),
##   ..   species = col_character(),
##   ..   mass = col_double(),
##   ..   gestation = col_double(),
##   ..   newborn = col_double(),
##   ..   weaning = col_double(),
##   ..   `wean mass` = col_double(),
##   ..   AFR = col_double(),
##   ..   `max. life` = col_double(),
##   ..   `litter size` = col_double(),
##   ..   `litters/year` = col_double()
##   .. )
```


```r
glimpse(mammals)
```

```
## Rows: 1,440
## Columns: 13
## $ order          <chr> "Artiodactyla", "Artiodactyla", "Artiodactyla", "Art...
## $ family         <chr> "Antilocapridae", "Bovidae", "Bovidae", "Bovidae", "...
## $ Genus          <chr> "Antilocapra", "Addax", "Aepyceros", "Alcelaphus", "...
## $ species        <chr> "americana", "nasomaculatus", "melampus", "buselaphu...
## $ mass           <dbl> 45375.0, 182375.0, 41480.0, 150000.0, 28500.0, 55500...
## $ gestation      <dbl> 8.13, 9.39, 6.35, 7.90, 6.80, 5.08, 5.72, 5.50, 8.93...
## $ newborn        <dbl> 3246.36, 5480.00, 5093.00, 10166.67, -999.00, 3810.0...
## $ weaning        <dbl> 3.00, 6.50, 5.63, 6.50, -999.00, 4.00, 4.04, 2.13, 1...
## $ `wean mass`    <dbl> 8900, -999, 15900, -999, -999, -999, -999, -999, 157...
## $ AFR            <dbl> 13.53, 27.27, 16.66, 23.02, -999.00, 14.89, 10.23, 2...
## $ `max. life`    <dbl> 142, 308, 213, 240, -999, 251, 228, 255, 300, 324, 3...
## $ `litter size`  <dbl> 1.85, 1.00, 1.00, 1.00, 1.00, 1.37, 1.00, 1.00, 1.00...
## $ `litters/year` <dbl> 1.00, 0.99, 0.95, -999.00, -999.00, 2.00, -999.00, 1...
```

5. . Try the `table()` command to produce counts of mammal order, family, and genus.  

```r
table(mammals$order)
```

```
## 
##   Artiodactyla      Carnivora        Cetacea     Dermoptera     Hyracoidea 
##            161            197             55              2              4 
##    Insectivora     Lagomorpha  Macroscelidea Perissodactyla      Pholidota 
##             91             42             10             15              7 
##       Primates    Proboscidea       Rodentia     Scandentia        Sirenia 
##            156              2            665              7              5 
##  Tubulidentata      Xenarthra 
##              1             20
```

```r
garter_snake<-readr::read_csv("Garter snake project- Copy of Telemetry Data_Eric.csv")
```

```
## Warning: Missing column names filled in: 'X94' [94]
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   GlobalID = col_logical(),
##   Observer = col_character(),
##   `Study Site` = col_character(),
##   Date = col_character(),
##   Time = col_character(),
##   Microbrand = col_character(),
##   `Treatment Group` = col_character(),
##   `Same location as last location?` = col_character(),
##   Status = col_character(),
##   `Habitat Type` = col_character(),
##   `Estimation Quantifiers` = col_character(),
##   `Visible?` = col_character(),
##   Position = col_character(),
##   `Snake  % in sun` = col_character(),
##   Activity = col_character(),
##   Substrate = col_character(),
##   `Disturb before located?` = col_character(),
##   `Disturb after located?` = col_character(),
##   Wind = col_character(),
##   Weather = col_character()
##   # ... with 13 more columns
## )
## i Use `spec()` for the full column specifications.
```

```r
glimpse(garter_snake)
```

```
## Rows: 43
## Columns: 94
## $ GlobalID                              <lgl> NA, NA, NA, NA, NA, NA, NA, N...
## $ Observer                              <chr> "Allie_Essert", "Allie_Essert...
## $ `Study Site`                          <chr> "Natomas", "Natomas", "Natoma...
## $ Date                                  <chr> "8/26/2019", "8/26/2019", "9/...
## $ Time                                  <chr> "11:06 AM", "11:24 AM", "12:1...
## $ Microbrand                            <chr> "13121", "13078", "13121", "2...
## $ Frequency                             <dbl> 164.8795, 164.5015, 164.8795,...
## $ `Treatment Group`                     <chr> "CanalResident", "CanalReside...
## $ `Same location as last location?`     <chr> "no", "no", "yes", "no", "no"...
## $ EastingNAD83                          <dbl> 626168, 626817, 626139, 62726...
## $ NorthingNAD83                         <dbl> 4287194, 4287989, 4287698, 42...
## $ TI                                    <dbl> 20.580, 17.130, 24.215, 25.80...
## $ T2                                    <dbl> 20.55, 17.22, 24.05, 25.60, 2...
## $ Status                                <chr> "Release", "Alive", "alive", ...
## $ `Habitat Type`                        <chr> NA, "IrrigCanal", "irrigcanal...
## $ `GPS Accuracy (m)`                    <dbl> 3, 3, 3, NA, 3, 3, 3, 3, 3, 3...
## $ `Estimation Quantifiers`              <chr> "exact", "exact", "exact", "e...
## $ `Visible?`                            <chr> NA, "no", "yes", "yes", "no",...
## $ Position                              <chr> NA, "Unknown", "sprawled", NA...
## $ `Snake  % in sun`                     <chr> NA, "Unknown", "0%", NA, "0",...
## $ `Snake to water distance (m)`         <dbl> NA, 1, 0, NA, 2, 2, 1, 2, 2, ...
## $ `Snake to debris pile distance (m)`   <dbl> NA, NA, NA, NA, NA, NA, NA, N...
## $ `Snake to water control distance (m)` <dbl> NA, NA, 7, NA, 8, 30, NA, NA,...
## $ `Snake to terr imped distance (m)`    <dbl> NA, 20, NA, NA, 12, 25, NA, N...
## $ Activity                              <chr> NA, "NotMoving", "moving", NA...
## $ Substrate                             <chr> NA, "4_Underground, 6_HiddenU...
## $ `Disturb before located?`             <chr> NA, "no", "no", NA, "no", "no...
## $ `Disturb after located?`              <chr> NA, "no", "no", NA, "no", "no...
## $ Wind                                  <chr> "Light_Air", "Calm", "Light_A...
## $ Weather                               <chr> "Sunny/Clear", "Sunny/Clear",...
## $ `Air Temp`                            <dbl> 32, 32, 24, 26, 24, 24, 27, 3...
## $ `Substrate Temp`                      <dbl> 32, 32, 17, 30, 26, 26, 27, 2...
## $ `Water Temp`                          <dbl> 25, 25, 17, 22, 18, 18, 21, 2...
## $ `Confidence in hab/veg?`              <dbl> NA, 100, 100, NA, 80, 100, 80...
## $ `Habitat%WATER`                       <dbl> NA, 0, 70, NA, 0, 0, 10, 10, ...
## $ `Habitat%FLOATING`                    <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Habitat%SUBMERGENT`                  <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Habitat%EMERGENT`                    <dbl> NA, 5, 0, NA, 0, 0, 50, 40, 5...
## $ `Habitat%TERRESTRIAL`                 <dbl> NA, 40, 0, NA, 50, 50, 0, 0, ...
## $ `Habitat%LITTER`                      <dbl> NA, 55, 0, NA, 30, 30, 40, 50...
## $ `Habitat%ROCK/RIP RAP`                <dbl> NA, 30, 0, NA, 20, 0, 0, 0, 0...
## $ `Habitat%BARE GROUND`                 <dbl> NA, 0, 0, NA, 0, 20, 0, 0, 0,...
## $ `Habitat%TOTAL`                       <dbl> NA, 100, 100, NA, 100, 100, 1...
## $ `Veg%DUCKWEED`                        <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%AZOLA`                           <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%ALGAE`                           <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%COONTAIL`                        <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%PONDWEED`                        <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%MILFOIL`                         <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%TULE`                            <dbl> NA, 0, 0, NA, 0, 0, 0, 100, 8...
## $ `TULE height`                         <chr> NA, "0", "0", NA, "0", "0", "...
## $ `Veg%CATTAIL`                         <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 15,...
## $ `CATTAIL height`                      <chr> NA, "0", "0", NA, "0", "0", "...
## $ `Veg%SEDGE`                           <dbl> NA, 10, 0, NA, 0, 40, 0, 0, 0...
## $ `SEDGE height`                        <chr> NA, "15to50cm", "0", NA, "0",...
## $ `Veg%RUSH`                            <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `RUSH height`                         <chr> NA, "0", "0", NA, "0", "0", "...
## $ `Veg%PARROT FEATHER`                  <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `PARROT FEATHER height`               <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%PRIMROSE`                        <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `PRIMROSE height`                     <chr> NA, "0", "0", NA, "0", "0", "...
## $ `Veg%SMARTWEED`                       <chr> NA, "0", "0", NA, "0", "0", "...
## $ `SMARTWEED height`                    <chr> NA, "0", "0", NA, "0", "0", "...
## $ `Veg%ARROWHEAD`                       <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `ARROWHEAD height`                    <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%RICE`                            <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `RICE height`                         <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%WATERGRASS`                      <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `WATERGRASS height`                   <chr> NA, "0", "0", NA, "0", "0", "...
## $ `Veg%SPRANGLETOP`                     <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `SPRANGLETOP height`                  <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%WATER HYACINTH`                  <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `WATER HYACINTH height`               <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%HORSETAIL`                       <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `HORSETAIL height`                    <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%TURF GRASS`                      <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `TURF GRASS height`                   <chr> NA, "0", "0", NA, "0", "0", "...
## $ `Veg%BUNCH GRASS`                     <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `BUNCH GRASS height`                  <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%SINGLE STEM`                     <dbl> NA, 80, 0, NA, 0, 0, 0, 0, 0,...
## $ `SINGLE STEM height`                  <chr> NA, "50to100cm", "0", NA, "0"...
## $ `Veg%WEEDY DICOT`                     <dbl> NA, 10, 0, NA, 10, 60, 0, 0, ...
## $ `WEEDY DICOT height`                  <chr> NA, "50to100cm", "0", NA, "50...
## $ `Veg%SHRUB`                           <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `SHRUB height`                        <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%BLACKBERRY`                      <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `BLACKBERRY height`                   <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%GRAPE`                           <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `GRAPE height`                        <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%OTHER`                           <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `OTHER height`                        <dbl> NA, 0, 0, NA, 0, 0, 0, 0, 0, ...
## $ `Veg%TOTAL`                           <chr> NA, "0", "0", NA, "0", "100",...
## $ Notes                                 <chr> NA, "0", "in weird location",...
## $ X94                                   <dbl> NA, NA, NA, NA, NA, NA, NA, N...
```

## Wrap-up
Please review the learning goals and be sure to use the code here as a reference when completing the homework.  
-->[Home](https://jmledford3115.github.io/datascibiol/)
