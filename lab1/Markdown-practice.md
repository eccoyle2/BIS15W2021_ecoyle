---
title: "Test Markdown"
author: "Eric Coyle"
date: "1/5/2021"
output: 
  html_document: 
    keep_md: yes
---



# This is my first Markdown File
## This is my first Markdown file
### This is my first Markdown file

```r
4*2
```

```
## [1] 8
```
## this is my [email]9mailtto:eccoyle@ucdavis.edu)

## this is [Google}(http://www.google.com)

```r
2+7
```

```
## [1] 9
```

```r
2*8
```

```
## [1] 16
```

```r
10-11
```

```
## [1] -1
```

```r
15/3
```

```
## [1] 5
```

#### this should be rreally small

## this my other [email](mailto:ericcoyle17@mittymonarch.com)
this is the weather today [weather](https://www.msn.com/en-us/weather/today/Davis,California,United-States/we-city?el=SHPz6cxFbrSNcyZwLcLOtF8mqFyMB0Tj8diQMYSgTlsFT50zHLAd7mjTkMXP5zZMOMdZ%2BiPrBY9%2B2uDITALm%2Blx9n0rI27UQCYSjBF%2FdIOyyp5BL%2BjvaLt7DN9vMlaLD&weaDegreeType=F&ocid=msedgntp)


```r
#install.packages("tidyverse")
library("tidyverse")
```


```r
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()
```

![](Markdown-practice_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

## ____trying out underscores
##{does this do anything special}
