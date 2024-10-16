#######################################Function


getRiceData <- function(){
  
  url <- "https://docs.google.com/spreadsheets/d/1Mk1YGH9LqjF7drJE-td1G_JkdADOU0eMlrP01WFBT8s/pub?gid=0&single=true&output=csv"
  
  library(tidyverse)
  library(lubridate)
  library(dplyr)
  read_csv( url ) -> rice
  #names( rice )
  
  
  #make date object
  rice |>
    mutate( Date = mdy_hms( DateTime,
                            tz="EST")) -> rice #how to format this further?
  #get am/pm? Cannot change from mdy_hms
  #not easy to change here, better to change time format when putting in say a graph for example and do the time format there
  # DateTime is only text here, the column i made is an actual date column
  #view(rice)
  
  #make month, weekday, day objects. "Make" generally means use mutate
  rice |>
    mutate( Month = month( Date,
                           abbr = FALSE,
                           label = TRUE)) |>
    mutate( Weekday = wday( Date,
                            abbr = FALSE,
                            label = TRUE)) |>
    mutate( Day = yday( Date)) -> rice
  
  #view(rice)
  
  
  #make all units metric
  #columns to fix: windspeed (mph to kmh), airtemp (F to C), rainfall (in to cm?)
  
  rice |>
    mutate( WindSpeed_kmh = 1.60934 * WindSpeed_mph) |>
    mutate( AirTempC = (AirTempF - 32) * 5/9) |>
    mutate( Rainfall_cm = 2.54 * Rain_in) |>
    select( - WindSpeed_mph,
            - AirTempF,
            - Rain_in) -> rice
  
  
  #view(rice)
  
  #get rid of extra data ("-" + select)
  #remove bp_hg, ph_mv, BGAPC, odo_sat, depth ft, surfacenad83
  
  rice |>
    select( - BP_HG,
            - PH_mv,
            - BGAPC_CML,
            - BGAPC_rfu,
            - ODO_sat,
            - Depth_ft,
            - SurfaceWaterElev_m_levelNad83m,
            - RecordID,
            - DateTime) -> rice
  
  #view(rice)
  #reorder the columns - select
  
  rice |>
    select( Date,
            Month,
            Weekday,
            Day,
            H2O_TempC,
            Depth_m,
            ODO_mgl,
            Chla_ugl,
            Turbidity_ntu,
            SpCond_mScm,
            Salinity_ppt,
            PH,
            PAR,
            AirTempC,
            RelHumidity,
            WindSpeed_kmh,
            WindDir,
            Rainfall_cm) -> rice
  
  #view( rice )
  
  return( rice )
  
}


