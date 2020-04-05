# hcslim

*Slim Highcharts for R Shiny*

Highcharter and htmlWidgets add many failure points between processing in R and plotting with Highcharts. 
We provide minimal UI/HTML-based functions for creating plots in accordance with Highcharts documentation. 
This allows easier use of Highcharts documentation and forums.
It also provides a direct download of the Highcharts code, so the latest stable Highcharts version will always be used, although it may make applications less stable.

## Installation

Install the latest version from github:

```r
devtools::install_github( "superchordate/hcslim" )
```

## Usage

Highcharts examples can be found at https://www.highcharts.com/demo. We'll look specifically at [this example](https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/demo/line-labels/).

The HTML code for this chart looks like:

```html
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
</figure>
```

And Javascript:

```js
Highcharts.chart('container', {
    chart: {
        type: 'line'
    },
    title: {
        text: 'Monthly Average Temperature'
    },
    subtitle: {
        text: 'Source: WorldClimate.com'
    },
    xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    },
    yAxis: {
        title: {
            text: 'Temperature (°C)'
        }
    },
    plotOptions: {
        line: {
            dataLabels: {
                enabled: true
            },
            enableMouseTracking: false
        }
    },
    series: [{
        name: 'Tokyo',
        data: [7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
    }, {
        name: 'London',
        data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
    }]
});
```

To build this chart in a R Shiny app with hcslim in your [app.R file](https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/):
```R
require(shiny)
require(hcslim)
shinyApp(ui = basicPage(

    hcslim::usecode(
        'highcharts',
        'modules/exporting',
        'modules/export-data',
        'modules/accessibility'
    ),
    
    uiOutput('testchart')

  ),
  server = function(input, output) {

    output$testchart = renderUI({ hcslim::hchtml( 'testchart', list(
        chart = list(type = 'line'),
        title = list(text = 'Monthly Average Temperature'),
        subtitle = list(text = 'Source = WorldClimate.com'),
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
            data = c(7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6)
          ),
          list(
            name = 'London',
            data = c(3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8)
          )
        )
      ))
      
    })

})
```