library(shiny)
library(tidyverse)
library(glue)
library(sf) 
library(lme4)
library(leaflet)
library(shinythemes)

CensusTracts <- st_read('./data/DC')

CensusTracts |> 
  ggplot() +
  geom_sf() 



Burglaries2023 <- read_csv("./data/burglaries_2023.csv")


Burglaries2023 <- Burglaries2023 |> 
  distinct(incident_number, .keep_all = TRUE) |> 
  drop_na(latitude) |> 
  mutate(incident_occurred_date = str_sub(incident_occurred, 1, 10))  |> 
  mutate(incident_occurred_date = ymd(incident_occurred_date))



CensusTracts |> 
  ggplot() +
  geom_sf() +
  geom_point(
    data = Burglaries2023 |> drop_na(latitude),
    aes(x = longitude, y = latitude),
    size = 0.1
  )



Burglaries2023_geo <- st_as_sf(
  Burglaries2023 |> drop_na(latitude),
  coords = c('longitude', 'latitude'),
  crs = st_crs(CensusTracts)
)




CensusTracts |> 
  ggplot() +
  geom_sf() +
  geom_sf(data = Burglaries2023_geo, size = 0.1)



Burglaries2023_CensusTracts <- st_join(Burglaries2023_geo, CensusTracts, join = st_within, left = FALSE) 



Burglaries2023_CensusTracts |> 
  filter(is.na(incident_number))  



CensusTracts |> 
  ggplot() +
  geom_sf() +
  geom_sf(data = Burglaries2023_CensusTracts, size = 0.1)




Burglaries2023_CensusTracts |> 
  filter(is.na(incident_number))




Burglaries2023_CensusTracts |> 
  st_drop_geometry() |> 
  group_by(GEOID) |> 
  count(name = "incident_number") |> 
  arrange(desc(incident_number))



leaflet(data = Burglaries2023 |> 
          drop_na(latitude) # |> 
        #     filter(`Route Name` == "WEST END - WHITE BRIDGE")
) |>  
  addTiles() |> 
  addMarkers(~longitude, 
             ~latitude, 
             popup = ~as.character(`incident_number`), 
             label = ~as.character(`incident_number`)
  )



leaflet(Burglaries2023 |> drop_na(longitude)) %>% 
  addTiles() %>% 
  addMarkers(
    ~longitude,
    ~latitude,
    clusterOptions = markerClusterOptions(),
    popup = ~as.character(`incident_number`), 
    label = ~as.character(`incident_number`)
  )






