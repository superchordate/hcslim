require(dplyr)
require(magrittr)
require(easyr)

begin() # clear variables, workspace to file location.

# read main and supplemental files. 
for(file in list.files('../main', full.names = TRUE)) source(file, local = TRUE)
for(file in list.files('../supplemental', full.names = TRUE)) source(file, local = TRUE)

# line chart.
options = list(
  chart = list(type = 'line'),
  title = list(text = 'Some Numbers'),
  yAxis = list(
      title = list(
          text = '123456'
      )
  ),
  series = list(
      list(
        name = '123',
        data = c(1, 2, 3)
      ),
      list(
        name = '456',
        data = c(4, 5, 6)
      )
  )
)

hc_view(options = options)

# map
options = list(
  title = list(text = 'Highmaps basic lat/lon demo'),
  chart = list(map = hc_markjs('topology')),
  series = list(

    # Use the gb-all map with no data as a basemap
    list(
      name = 'Great Britain',
      borderColor = '#A0A0A0',
      nullColor = 'rgba(200, 200, 200, 0.3)',
      showInLegend = FALSE
    ),
    list(
      name = 'Separators',
      type = 'mapline',
      nullColor = '#707070',
      showInLegend =  FALSE,
      enableMouseTracking =  FALSE,
      accessibility = list(enabled =  FALSE)
    ),

    # Specify points using lat/lon
    list(            
      type = 'mappoint',
      name = 'Cities',
      accessibility = list(point = list(
        valueDescriptionFormat = 'list(xDescription). Lat = list(point.lat:.2f), lon = list(point.lon:.2f).'
      )),
      color = hc_markjs('Highcharts.getOptions().colors[1]'),
      data = list(
        list(
          name = 'London',
          lat = 51.507222,
          lon = -0.1275
        ), list(
          name = 'Birmingham',
          lat = 52.483056,
          lon = -1.893611
        ), list(
          name = 'Leeds',
          lat = 53.799722,
          lon = -1.549167
        ), list(
          name = 'Glasgow',
          lat = 55.858,
          lon = -4.259
        )
      )
    )

  )
)

hc_view(
  options = options, 
  class = 'mapChart',
  loadmapfromurl = 'https://code.highcharts.com/mapdata/countries/gb/gb-all.topo.json',
)

