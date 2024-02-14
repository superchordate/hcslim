require(shiny)
require(dplyr)
require(magrittr)

# read main and supplemental files. 
for(file in list.files('../main', full.names = TRUE)) source(file, local = TRUE)
for(file in list.files('../supplemental', full.names = TRUE)) source(file, local = TRUE)

shinyApp(
  
  ui = basicPage(
    hc_use(maps = TRUE),
    # optional - use a defaults file. 
    HTML('<script type="text/javascript" src="highcharts-defaults.js"></script>'),
    uiOutput('full-spec'),
    uiOutput('iris'),
    uiOutput('iris-grouped-withinfo'),
    uiOutput('map')
  ),

  server = function(input, output) {

    # manual data, for example only - it's rare you'll actually do this. 
    output[['full-spec']] = renderUI({ 

      options = list(

        chart = list(type = 'line'),
        title = list(text = 'Full Spec'),
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

      # enabling the tooltip is not intuitive so we have this function to add it. 
      # I like to use enableMouseTracking = FALSE to remove distractions.
      options %<>% hc_enabletooltips()

      return(hc_html('full-spec', options))
      
    })
    
    
    # plot using iris data. more compact style.
    output[['iris']] = renderUI(hc_html('iris', list(
      title = list(text = 'iris'),
      chart = list(type = 'bubble'),
      series = list(list(
        data = iris %>% select(x = Sepal.Length, y = Sepal.Width, z = Petal.Length)
      ))
    )))

    # example of a grouped series chart. 
    output[['iris-grouped-withinfo']] = renderUI({
      
      # initial options. 
      options = list(
        title = list(text = 'iris-grouped-withinfo'),
        chart = list(type = 'bubble')
      )

      # add grouped series.
      names(iris) = gsub('[.]', '', names(iris)) # periods will break JS later. 
      options %<>% hc_addgroupedseries(
        data = iris, 
        groupcol = 'Species', 
        xcol = 'SepalLength', ycol = 'SepalWidth', zcol = 'PetalLength'
      )
      
      # all the data will be passed to Highcharts. 
      # so you can use it all in the tooltip.
      # https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/tooltip/pointformat-extra-information/
      options$tooltip = list(
        pointFormat = '
          Sepal Length/Width: {point.SepalLength} / {point.SepalWidth} <br/>
          Petal Length/Width: {point.PetalLength} / {point.PetalWidth}
        '
      )
      options %<>% hc_enabletooltips()

      return(hc_html('iris-grouped-withinfo', options))

  })

  # maps are a bit tricky. there are multiple ways to do them, but here is one:
  output[['map']] = renderUI({
    options = list(
      title = list(text = 'map'),
      chart = list(map = hc_markjs('topology')),
      plotOptions = list(mappoint = list(dataLabels = list(enabled = TRUE))),
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
          color = 'blue',
          # I haven't been able to get the dataLabels to work..
          dataLabels = list(enabled = TRUE, format = '{point.name}', color = 'red'),
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

    hc_html(
      id = 'map',
      options = options, 
      class = 'mapChart',
      loadmapfromurl = 'https://code.highcharts.com/mapdata/countries/gb/gb-all.topo.json',
    )

  })

})

