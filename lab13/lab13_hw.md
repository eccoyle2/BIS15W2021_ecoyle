---
title: "Lab 13 Homework"
author: "Eric Coyle"
date: "2021-03-03"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Libraries

```r
if (!require("tidyverse")) install.packages('tidyverse')
```

```
## Loading required package: tidyverse
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
```

```
## √ ggplot2 3.3.3     √ purrr   0.3.4
## √ tibble  3.1.0     √ dplyr   1.0.4
## √ tidyr   1.1.2     √ stringr 1.4.0
## √ readr   1.4.0     √ forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```


```r
library(tidyverse)
library(shiny)
library(shinydashboard)
library(naniar)
library(janitor)
```

## Data
The data for this assignment come from the [University of California Information Center](https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus. Admissions are broken down into three categories: applications, admits, and enrollees. The number of individuals in each category are presented by demographic.  

```r
UC_admit <- readr::read_csv("data/UC_admit.csv")%>%
  clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Campus = col_character(),
##   Academic_Yr = col_double(),
##   Category = col_character(),
##   Ethnicity = col_character(),
##   `Perc FR` = col_character(),
##   FilteredCountFR = col_double()
## )
```

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine if there are NA's and how they are treated.**  


```r
glimpse(UC_admit)
```

```
## Rows: 2,160
## Columns: 6
## $ campus            <chr> "Davis", "Davis", "Davis", "Davis", "Davis", "Davis"~
## $ academic_yr       <dbl> 2019, 2019, 2019, 2019, 2019, 2019, 2019, 2019, 2018~
## $ category          <chr> "Applicants", "Applicants", "Applicants", "Applicant~
## $ ethnicity         <chr> "International", "Unknown", "White", "Asian", "Chica~
## $ perc_fr           <chr> "21.16%", "2.51%", "18.39%", "30.76%", "22.44%", "0.~
## $ filtered_count_fr <dbl> 16522, 1959, 14360, 24024, 17526, 277, 3425, 78093, ~
```

```r
head(UC_admit)
```

```
## # A tibble: 6 x 6
##   campus academic_yr category   ethnicity       perc_fr filtered_count_fr
##   <chr>        <dbl> <chr>      <chr>           <chr>               <dbl>
## 1 Davis         2019 Applicants International   21.16%              16522
## 2 Davis         2019 Applicants Unknown         2.51%                1959
## 3 Davis         2019 Applicants White           18.39%              14360
## 4 Davis         2019 Applicants Asian           30.76%              24024
## 5 Davis         2019 Applicants Chicano/Latino  22.44%              17526
## 6 Davis         2019 Applicants American Indian 0.35%                 277
```

```r
names(UC_admit)
```

```
## [1] "campus"            "academic_yr"       "category"         
## [4] "ethnicity"         "perc_fr"           "filtered_count_fr"
```



```r
UC_admit%>%
  summary()
```

```
##     campus           academic_yr     category          ethnicity        
##  Length:2160        Min.   :2010   Length:2160        Length:2160       
##  Class :character   1st Qu.:2012   Class :character   Class :character  
##  Mode  :character   Median :2014   Mode  :character   Mode  :character  
##                     Mean   :2014                                        
##                     3rd Qu.:2017                                        
##                     Max.   :2019                                        
##                                                                         
##    perc_fr          filtered_count_fr 
##  Length:2160        Min.   :     1.0  
##  Class :character   1st Qu.:   447.5  
##  Mode  :character   Median :  1837.0  
##                     Mean   :  7142.6  
##                     3rd Qu.:  6899.5  
##                     Max.   :113755.0  
##                     NA's   :1
```


```r
UC_admit$academic_yr<-as.character(UC_admit$academic_yr)
```


**2. The president of UC has asked you to build a shiny app that shows admissions by ethnicity across all UC campuses. Your app should allow users to explore year, campus, and admit category as interactive variables. Use shiny dashboard and try to incorporate the aesthetics you have learned in ggplot to make the app neat and clean.**


```r
ui <- dashboardPage(
  dashboardHeader(title = "UC Ethnic Information"),
  dashboardSidebar(disable = T),
  dashboardBody(
  fluidRow(
  box(title = "Plot Options", width = 3,
  selectInput("x", "Select Admission details", choices = c("campus", "academic_yr", "category"), 
              selected = "campus"),
      hr(),
      helpText("Source: (https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus.")
  ),
  box(title = "Ethnicity", width = 6,
  plotOutput("plot", width = "600px", height = "500px")
  ) 
  )
  )
)

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
  UC_admit %>% 
  ggplot(aes_string(x = input$x,y="filtered_count_fr",fill="ethnicity"))+
  geom_col(position = "dodge")+
       scale_fill_brewer(palette = "Set1")+
  theme_light(base_size = 18)+
      theme(axis.text.x = element_text(angle = 60, hjust = 1))+
      labs(title = "UC Admission Information",x=NULL,y="Number of Indivicuals")
  })
  
  
  session$onSessionEnded(stopApp)
  }
shinyApp(ui, server)
```

```
## PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}

**3. Make alternate version of your app above by tracking enrollment at a campus over all of the represented years while allowing users to interact with campus, category, and ethnicity.**

```r
names(UC_admit)
```

```
## [1] "campus"            "academic_yr"       "category"         
## [4] "ethnicity"         "perc_fr"           "filtered_count_fr"
```


```r
UC_admit%>%
  tabyl(category)
```

```
##    category   n   percent
##      Admits 720 0.3333333
##  Applicants 720 0.3333333
##   Enrollees 720 0.3333333
```
#this following app is a less efficient and less clean way of comparing numbers across campus, ethnicity, and category as the second app below it, but I wanted to keep it to play around with later


```r
ui <- dashboardPage(
  dashboardHeader(title = "UC Enrollment"),
  dashboardSidebar(disable = T),
  dashboardBody(
  fluidRow(
  box(title = "Plot Options", width = 3,
  selectInput("x", "Student/Applicant Details", choices = c("ethnicity", "category", "campus"), 
              selected = "campus"),
      hr(),
      helpText("Source: (https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus.")
  ), 
  box(title = "Academic Year", width = 6,
  plotOutput("plot", width = "600px", height = "500px")
  ) 
  ) 
  ) 
)

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
  UC_admit %>% 
  ggplot(aes_string(x = "academic_yr", y="filtered_count_fr",fill = input$x)) +
  geom_col(position = "dodge")+
  theme_light(base_size = 18)
  })
  
  session$onSessionEnded(stopApp)
  }

shinyApp(ui, server)
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}
#this is the, in my opinion, better app for the question above


```r
ui <- dashboardPage(skin="red",
  dashboardHeader(title = "UC Enrollment"),
  dashboardSidebar(disable = F),
  dashboardBody(selectInput("campus", " Select Campus:", 
                  choices=unique(UC_admit$campus)),
  fluidRow(
  box(title = "Plot Options", width = 4,
  selectInput("x", "Student/Applicant Details", choices = c("ethnicity", "category"), 
              selected = "campus"),
      hr(),
      helpText("Source: (https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus.")
  ), 
  box(title = "Academic Year", width = 6,
  plotOutput("plot", width = "600px", height = "500px")
  ) 
  ) 
  ) 
  )
server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
  UC_admit %>%
      filter(campus == input$campus) %>%
  ggplot(aes_string(x = "academic_yr", y="filtered_count_fr",fill = input$x)) +
  geom_col(position = "dodge")+
       scale_fill_brewer(palette = "Set1")+
  theme_light(base_size = 18)+
     theme(axis.text.x = element_text(angle = 60, hjust = 1))+
      labs(title = "UC Admission Information",x=NULL,y="Number of Admittees")
  })
  
  session$onSessionEnded(stopApp)
  }

shinyApp(ui, server)
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
