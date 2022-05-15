# GIS3_Lab7
An attempt at an RShiny/Leaflet Web App



---
title: "Lab7_ReadMe"
author: "Grey Moszkowski"
date: "5/15/2022"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Goal

My goal with this exercise was to create an RShiny web app map of anti-aircraft events in Ukraine. My hope was to create an app that allows the user to visualiize anti-air events by month using radio buttons in the UI. 

## Data Process

Using the VIINA dataset of war events in Ukraine found here(https://github.com/zhukovyuri/VIINA), I selected Ukrainian-instigated anti-air event. I also turned them into sf objects. The code is as follows:

```{r}
library(sf)
library(tmap)
library(tidyverse)
setwd("~/Documents/University of Chicago/Fourth Year/GIS III/Lab 7")

download.file(url = "https://github.com/zhukovyuri/VIINA/raw/master/Data/events_latest.csv", 
                         destfile = "latest_events.csv")
ukraine <- read.csv(file = "latest_events.csv") # https://github.com/zhukovyuri/VIINA Documentation is here.
ukraine_sf <- st_as_sf(ukraine, coords = c('longitude', 'latitude'), crs = st_crs(4326)) # Convert to SF object
ukraine_clean <- subset(ukraine_sf, select = c('event_id', 'date', 'a_rus_b',
                                               'a_ukr_b', 'a_civ_b', 'a_other_b', 't_aad_b',
                                               't_airstrike_b', 't_armor_b', 't_artillery_b',
                                               't_control_b', 't_occupy_b', 't_hospital_b', 
                                               't_milcas_b', 't_civcas_b', 'geometry')) #Select relevant columns
write_sf(obj = ukraine_clean, dsn = "ukraine_clean.gpkg")
aa <- ukraine_clean %>% filter(a_ukr_b == 1, t_aad_b == 1) # Subset ukrainian-instigated anti-aircraft events
head(aa)
```

I then added a month column to the data, giving me an easy way to access the month each event took place.

```{r}
aa$month = "Month"
aa$month[1:30] = "February"
aa$month[31:141] = "March"
aa$month[142:183] = "April"
head(aa)
```

## Outcome

This project is best classified as a work in progress. I have so far been unable to visualize the points using leaflet and RShiny, which has confounded me. I believe this to be due to my unfamiliarity with leaflet. I can create the UI and the basemap, but cannot make the points appear with addMarkers(), either in Shiny or in a seperate R script. I've spent some time in the leaflet documentation and it should work, because the data I am passing to addMarkers() is sfc_POINT data which is compatible with addMarkers(). I also have a sneaking suspicion that my radio buttons would not be truly interactive, even if I were to successfully plot the points. 

The full code of my attempted web app is in the app.R file in this repo. If anyone has information on how to make this work, please let me know!




