url <- "https://raw.githubusercontent.com/DyerlabTeaching/Data-Containers/main/data/arapat.csv"
beetles <- read_csv( url )

spec(beetles)

dim( beetles )
