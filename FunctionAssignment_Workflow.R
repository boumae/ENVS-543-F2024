#######Function in class activity 
#1. All the data is represented in common units (Imperial or Standard).
#2. An actual date object represents the date and time information.
#3. Additional columns for Month, Day, and Weekday as properly ordered variables. 
#4. No extraneous columns of data.
#5. The file should be documented with comments.



url <- "https://docs.google.com/spreadsheets/d/1Mk1YGH9LqjF7drJE-td1G_JkdADOU0eMlrP01WFBT8s/pub?gid=0&single=true&output=csv"

library(tidyverse)
library(lubridate)
library(dplyr)
read_csv( url ) -> rice
names( rice )


#make date object
rice |>
  mutate( Date = mdy_hms( DateTime,
                          tz="EST")) -> rice #how to format this further?
#get am/pm? Cannot change from mdy_hms
#not easy to change here, better to change time format when putting in say a graph for example and do the time format there
# DateTime is only text here, the column i made is an actual date column
view(rice)

#make month, weekday, day objects. "Make" generally means use mutate
rice |>
  mutate( Month = month( Date,
                         abbr = FALSE,
                         label = TRUE)) |>
  mutate( Weekday = wday( Date,
                          abbr = FALSE,
                          label = TRUE,
                          week_start = getOption("lubridate.week.start", 7))) |>
  mutate( Day = yday( Date)) -> rice

view(rice)


#make all units metric
#columns to fix: windspeed (mph to kmh), airtemp (F to C), rainfall (in to cm?)

rice |>
  select(everything() ) |>
  mutate( WindSpeed_kmh = 1.60934 * WindSpeed_mph) |>
  mutate( AirTempC = (AirTempF - 32) * 5/9) |>
  mutate( Rainfall_cm = 2.54 * Rain_in) |>
  select( - WindSpeed_mph,
          - AirTempF,
          - Rain_in) -> rice


view(rice)

#get rid of extra data ("-" + select)
#remove bp_hg, ph_mv, BGAPC, odo_sat, depth ft, surfacenad83

rice |>
  select( everything()) |>
  select( - BP_HG,
          - PH_mv,
          - BGAPC_CML,
          - BGAPC_rfu,
          - ODO_sat,
          - Depth_ft,
          - SurfaceWaterElev_m_levelNad83m,
          - RecordID,
          - DateTime) -> rice

view(rice)
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

view( rice )




#####################################time test
library(dplyr)

# Sample data frame
df <- data.frame(
  id = 1:3,
  date_column = as.POSIXct(c("2024-09-28 08:30:00", "2024-09-28 14:15:00", "2024-09-28 19:45:00"))
)

# Change time to 12-hour format while keeping the date
df <- df %>%
  mutate(date_12h = format(date_column, "%Y-%m-%d %I:%M %p"))

# View the modified data frame
print(df)
view( df )

## time test2
library(dplyr)
library(lubridate)

# Sample data frame with mdy_hms format
df2 <- data.frame(
  id = 1:3,
  date_column = c("09/28/2024 08:30:00", "09/28/2024 14:15:00", "09/28/2024 19:45:00")
)

# Convert the date_column to POSIXct and change time to 12-hour format
df2 <- df2 %>%
  mutate(
    date_column = mdy_hms(date_column),  # Convert to POSIXct
    date_12h = format(date_column, "%Y-%m-%d %I:%M %p")  # Change time to 12-hour format
  )

# View the modified data frame
print(df2)
view( df2)