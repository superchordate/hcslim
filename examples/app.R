require(shiny)
require(hcslim)

shinyApp(
  
  ui = basicPage(
    usecode('highcharts'),    
    uiOutput('mychart')
  ),

  server = function(input, output) {

    output$mychart = renderUI({ 
      
      return(hchtml('mychart', list(

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
        
      )))
      
    })

})

