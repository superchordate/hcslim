require(shiny)
require(hcslim)

shinyApp(ui = basicPage(

    hcslim::usecode(
        'highcharts',
        'modules/exporting',
        'modules/export-data',
        'modules/accessibility',
        'modules/boost'
    ),
    
    uiOutput('testchart')

  ),
  server = function(input, output) {

    output$testchart = renderUI({ 
      
      x1 = round(runif(10)*10,1)
      x2 = round(runif(10)*10,1)
      
      return(hchtml( 'testchart', list(
        chart = list(type = 'line'),
        title = list(text = 'Random Numbers'),
        xAxis = list(
            categories = c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')
        ),
        yAxis = list(
            title= list(
                text = 'Temperature (°C)'
            )
        ),
        plotOptions = list(
            line = list(dataLabels = list(enabled = TRUE), enableMouseTracking = FALSE)
        ),
        series = list(
          list(
            name = 'Tokyo',
            data = x1
          ),
          list(
            name = 'London',
            data = x2
          )
        )
      )))
      
    })

})