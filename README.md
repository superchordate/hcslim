# hcslim

*Slim Highcharts for R Shiny*

Highcharter and htmlWidgets add many failure points between processing in R and plotting with Highcharts. 
We provide minimal UI/HTML-based functions for creating plots in accordance with Highcharts documentation. 
This allows easier use of Highcharts documentation and forums.
It also provides a direct download of the Highcharts code, so the latest stable Highcharts version will always be used, although it may make applications less stable.

* [Highcharts](#highcharts)
* [Installation](#installation)
* [Philosophy](#philosophy)
* [Contributions](#contributions)
* [Usage](#usage)
* [Troubleshooting](#troubleshooting)
* [Converting Highcharter-based Apps](#converting-highcharter-based-apps)

## Highcharts

Highcharts may require a paid license. Special consideration is given for personal (non-commercial) use, schools, and non-profit organizations. Get more information at https://www.highcharts.com.

## Installation

Install the latest version from github:

```r
devtools::install_github( "superchordate/hcslim" )
```

## Philosophy

`hcslim` takes a **web-first approach**:

Instead of pre-packaging all the HTML and JS in a widget, it provides tools for building out a website that can connect to these resources. This requires knowledge of web development. In fact, R Shiny developers need to know how the web works in order to be effective. [w3schools](https://www.w3schools.com/) is a great resource if you need to learn how websites work.

This approach has key benefits:

* Gives developers flexibility to optimize applications and choose specific highcharts versions and modules.
* Simplifies design by removing unnecessary R-based abstractions.
* Directly aligns with the highcharts documentation and forums. These are are fully mature, compared to Highcharter which has very little documentation or forum posts.

## Contributions

`hcslim` is very new and coverage isn't great. In particular, we need functions to make transforming data easier for lists and for treemaps. Please consider making a Pull Request if you end up writing code like this.

## Usage

Highcharts examples can be found at https://www.highcharts.com/demo. If you click through you will find JS Fiddle examples that contain everything you need to build a chart, including JS libraries. Once you find one of these, it can be replicated easily in `hcslim`.

We'll look specifically at [this example](https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/demo/line-labels/).

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

## Troubleshooting

If there are no R errors and the charts aren't showing, use the browser JavaScript console to check for JavaScript errors. Sometimes there will be Highcharts errors that will give you a hint as to what is wrong.

If there are no Highcharts errors, but you do see unclear errors, it might be a JavaScript syntax issue in the code output by hcslim. Use the `printjson = TRUE` argument for `hchtml` or `renderHighcharts` to print the output JSON data for your chart to the R console. 

* You can paste this into a JS Fiddle example for the chart type you are working with.
* For example, if it's a treemap then I google `highcharts jsfiddle treemap`, access the fiddle, and replace the options object `{type: "treemap", ...}` with the console output. Then tweak the options to find out what fixes the chart.
* If you are familiar with JavaScript , you can probably find the issue by visually scanning the output.

Common errors:

* Not marking JavaScript code with `markjs()`.
* `invalid escape sequence`: when using markjs, open/close your characters with " instead of '. If you have " inside a markjs argment you might get this Javascript error. I'll try to fix this in a later version.*
* Not having the JS files you need. Pay attention to JSFiddle examples to see what JS files they import and either include these in your project or add them with `usefules()`, in the correct order. Order is really important with Highcharts code modules.
* If you are using actual .js files instead of `usecode()` your files may need to be in a folder structure that matches JSFiddles. For example, if the JS fiddle reference is https://code.highcharts.com/modules/exporting.js then you need to save this file into the modules folder relative to the location of highcharts.js.

## Converting Highcharter-based Apps

While it is smart to start new apps using the format above, it may be very difficult to convert existing apps. For this reason, functions have been included to make switching from Highcharter easier. To use these, just replace Highcharter with hcslim in your code. Most functions have been replaced such that they will directly work, **except for renderHighchart()**. Where as before you would have used:

```R
renderHighchart({
    # code to build chart here (including series data).
})
```

You now need to give the chart id followed by a function that builds the options list, similar to:

```R
renderHighchart('mychart', function(){
    # code to build options here (including series data).
})
```

**markjs**

When converting your options to JSON, `hcslim` needs to know what parts are Javascript, otherwise it'll surround your javascript with quotes and it won't run. 

This is where the markjs function comes in. Using https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/xaxis/labels-formatter-extended/:

*When using markjs, open/close your characters with " instead of '. If you have " inside a markjs argment you might get the Javascript error `invalid escape sequence`. I'll try to fix this in a later version.*

```html
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>

<div id="container"></div>
```

```js
Highcharts.chart('container', {

    title: {
        text: 'Demo of reusing but modifying default X axis label formatter'
    },

    subtitle: {
        text: 'X axis labels should have thousands separators'
    },

    xAxis: {
        labels: {
            formatter: function () {
                var label = this.axis.defaultLabelFormatter.call(this);

                // Use thousands separator for four-digit numbers too
                if (/^[0-9]{4}$/.test(label)) {
                    return Highcharts.numberFormat(this.value, 0);
                }
                return label;
            }
        }
    },

    series: [{
        data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
        pointStart: 9000,
        type: 'column'
    }]

});
```

Notice the Javascript under formatter. In hcslim:

```R
require(shiny)
require(hcslim)
shinyApp(ui = basicPage(

    #jquery is already loaded by Shiny.
    hcslim::usecode(
        'highcharts' 
    ),
    
    uiOutput('testchart')

  ),
  server = function(input, output) {

    output$testchart = renderUI({ hcslim::hchtml( 'testchart', list(
        title = list(text = 'Demo of reusing but modifying default X axis label formatter'),
        subtitle = list(text = 'X axis labels should have thousands separators'),
        xAxis = list(
            labels = list(formatter = markjs(" 
                function () {
                    var label = this.axis.defaultLabelFormatter.call(this);

                    // Use thousands separator for four-digit numbers too
                    if (/^[0-9]{4}$/.test(label)) {
                        return Highcharts.numberFormat(this.value, 0);
                    }
                    return label;
                }
            "))
        ),
        series = list(
          list(
            data = [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
            pointStart = 9000,
            type = 'column'
          )
        )
      ))
      
    })

})
```
